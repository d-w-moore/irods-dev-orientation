# Reinstalling iRODS from source


The most valuable instructive step to be taken from this point is to reinstall the iRODS server and icommands packages with Debug symbols enabled. Doing this will allow us later to step through commands under GDB as they're being executed, and even peek into the internal workings of the software.

There's even a tool we will use later --called "rr" (record/replay) --  which allows us to fully record and then *replay*  (ie. deterministically "debug" in an environment almost identical to GDB's) the operations performed by the iRODS server during the *record* operation. You can even do reverse execution, that is undo steps, function "finishes", set reverse-run breakpoints, etc.

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

It will also behoove us to remove all remnants of the previous server configuration contained in:  
- ICAT content ...  
```
sudo su - postgres -c "dropdb --if-exists ICAT && createdb ICAT"
```
- *and* system files  
```
sudo rm -fr /etc/irods /var/lib/irods /tmp/irods/
```

In order to be able to build the iRODS core / server code and command line client icommands , we will need certain packages called the **iRODS externals** (these constitute libraries and a toolchain includeing, most notably, `cmake` and the `clang` C/C++ compilers):
```
sudo apt-get install irods-externals\*
```
Now use the following line to update the bash PATH for picking up the external' version of cmake :
```
echo "export PATH=$(ls -d /opt/irods-externals/cmake*/bin):\$PATH" |tee -a ~/.bashrc
```
Again, the command `exec bash` will enable this change to `PATH` in the current terminal window, and future logins and bash sessions will pick it up automatically [\[1\]](#footnote1).

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
  `git clone http://github.com/irods/irods_client_icommands`  

This creates the directories `irods` and `irods_client_icommands`; we'll descend now into each  one and check out the 4-2-stable branch, as well as initializing any related submodules:
```
for d in irods irods_client_icommands; do
  (cd "$d" && git checkout 4-2-stable && \
  git submodule update --init
  )
done
```
Now we create parallel directories in which to actually generate all intermediate files as well as the `.deb` (Debian) package files that will ultimately result when we build from the source:

`d=irods`  
`mkdir bld__$d && cd bld__$d`  
`cmake -DCMAKE_BUILD_TYPE=Debug -GNinja ../$d`  
`cd ..`  

*NOTE* - a beneficial effect of using **cmake** to build "outside the source" - effectively is to keep the repository itself "clean" - so git doesn't need to be confused by the presence of a multitude of files resulting from the build.

The next step is to `cd` into the build directory for the iRODS core and server code and compile it to package form:
```
cd bld__irods ; ninja package
```
This will take a while, but once it is done, a number  of `*.deb` packages will exist, typically named something like
```
irods-database-plugin-mysql_4.2.2~trusty_amd64.deb   
irods-database-plugin-postgres_4.2.2~trusty_amd64.deb  
irods-runtime_4.2.2~trusty_amd64.deb
irods-database-plugin-oracle_4.2.2~trusty_amd64.deb  
irods-dev_4.2.2~trusty_amd64.deb                       
irods-server_4.2.2~trusty_amd64.deb
```
Before going to the next compilation  step (that of building the **icommands**) we want to install the `dev` and `runtime` packages:
```
dpkg -i irods-{dev,runtime}*.deb
```
We now `cd ../bld__irods_client_icommands` and repeat the package building step:
```
ninja package
```
followed by
```
dpkg -i irods-icommands*.debug
```
Since the *icommands* are actually required for installing the iRODS server proper.
Change directories back to the place of our previous build:
```
cd ../bld__irods
dpkg -i irods-server*.deb irods-database-plugin-postgres*.deb
```
At this point we can return to a fully iRODS-enabled system using the old stand-by :
```
sudo python /var/lib/irods/scripts/setup_irods.py < /var/lib/irods/packaging/localhost_setup_postgres.input
```

---
Footnotes


<A name="footnote1"><sup>1</sup></A>A better long-term solution is perhaps the following:  append the following code to your `~/.bash_profile` :
```
if [ -d  /opt/irods-externals ] ;  then
  while read d ; do
        export PATH="$d:$PATH"
  done < <(
        bash -O failglob -c \
        "ls -d /opt/irods-externals/{cmake,clang}*/bin" 2>/dev/null
  )
fi
```
