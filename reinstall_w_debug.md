# Reinstalling iRODS with Debug


The most valuable instructive step to be taken from this point is to reinstall the iRODS server and icommands packages with Debug symbols enabled. Doing this will allow us later to step through commands under GDB as they're being executed, and even peek into the internal workings of the server.  There's a tool called "rr" (record/replay) which allows us to fully record and then *replay*  (ie. deterministically "debug" in an environment almost identical to GDB's) the operations performed by the server during the *record* operation. And yes, you can even do reverse execution, that is undo steps, function "finishes", set reverse-run breakpoints, etc.

*NOTE*
If you use `bash` as your command shell, it might be helpful to first visit [Appendix A](./appendix.md#part-A) to learn how to add certain useful, informative highlights to your command prompt  to help expedite our work in the coming sections.

## Preparation and Prerequisites

---

To install the debuggable iRODS packages, we will first remove the ones we installed previously, and build them.

Since we've already done a repository-sourced version of the `irods-server` and `irods-database-plugin-postgres` packages via the command-line, we'll need to uninstall them first to make way for our newly built packages.

Therefore, first shut down the running instances of iRODS:
```
sudo pkill 'irod.*Server'
```
Alternatively (and more cleanly) one of the following might also work:
* `sudo su - -c "service irods stop"`
* `sudo su - irods -c "./irodsctl stop"`
Then do the following command to remove the existing iRODS software from the machine:
```
sudo apt-get remove irods-{dev,runtime}
```
(Because all other iRODS packages depend on these two , this minimal command will do all of our uninstalling work for us.)

It will also behoove us to remove all remnants of configuration files from the system.  We can do it thus:
```
sudo rm -fr /etc/irods /var/lib/irods /tmp/irods*
```

In order to be able to build the iRODS core and icommands packages, we will need certain **iRODS externals** including most notably cmake and clang/clang++. So we now install these:
```
sudo apt-get install irods-externals\*
```
and use the following line to update the bash PATH for picking up the external' version of cmake :
```
echo "export PATH=$(ls -d /opt/irods-externals/cmake*/bin):\$PATH" |tee -a ~/.bashrc
```
Again, the command `exec bash` will enable this change to `PATH`  in the current terminal window, and future logins and bash sessions will pick it up automatically.

---

## Setting up the build

Let us first make sure the `ninja-build` package is installed.  This is a cousin to `make` but highly optimized to take advantage of multiple CPU cores.
```
sudo apt-get install ninja-build
```

At this point we want to create local copies of the iRODS's core/server repo and icommands repo on GitHub.  Let's create and situate ourselves in a convenient parent directory first - for purposes of the description here, we will assume it to be `github` subdirectory of our `$HOME` directory:  
  `mkdir -p ~/github && cd ~/github`  
Now we use `git`'s' sub-command`clone` to duplicate each of two source code trees we'll be building:  
  `git clone http://github.com/irods/irods`  
  `git clone http://github.com/irods/irods-client-icommands`  

This creates the directories `irods` and `irods-client-icommands`; we'll descend now into each  one and check out the 4-2-stable branch, as well as initializing any related submodules:
```
for d in irods irods-client-icommands; do
  (cd "$d" && git checkout 4-2-stable && \
  git submodule update --init
  )
done
```
Now we create parallel directories in which to actually generate all intermediate files as well as the `.deb` (Debian) package files that will ultimately result when we build from the source:
```
for d in irods irods-client-icommands; do
  mkdir bld__$d && (
     cd bld__$d && cmake -D'CMAKE_BUILD_TYPE=Debug' -GNinja ../$d
  ) || { echo >&2 "fail to create or setup build for '$d'"; break; }
done
```
*NOTE* - a beneficial effect of using **cmake** to build "outside the source" - effectively is to keep the repository itself "clean" - so git doesn't need to be confused by the presence of a multitude of files resulting from the build.
