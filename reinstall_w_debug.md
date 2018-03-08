# Reinstalling iRODS from source


The most valuable instructive step to be taken from this point is to reinstall the iRODS server and icommands packages with Debug symbols enabled. Doing this will allow us to step through commands under GDB as they're being executed, and even peek into the internal workings of the software.

There's even a tool we will use later --called "rr" (record/replay) --  which allows us to fully record and then *replay*  (ie. deterministically "debug" in an environment almost identical to GDB's) the operations performed by the iRODS server during the *record* operation. You can even do reverse execution, that is undo steps, function "finishes", set reverse-run breakpoints, etc.

*NOTE*
If you use `bash` as your command shell, it might be helpful to first visit [Appendix A](./appendix.md#part-A) to learn how to add certain useful, informative highlights to your command prompt  to help expedite our work in the coming sections.

## Preparation and Prerequisites

---

To install the debuggable iRODS packages, we will first remove the ones we installed previously, and build them.

Since we've already done a repository-sourced version of the `irods-server` and `irods-database-plugin-postgres` packages via the command-line, we'll need to uninstall them first to make way for our newly built packages.

Therefore, first shut down any currently running services under iRODS:  
`sudo su - irods -c "./irodsctl stop"`
Then do the following command to remove the existing iRODS software from the machine:  
`sudo apt-get remove irods-{dev,runtime}`
(Because all other iRODS packages depend on these two , this minimal command will do all of our uninstalling work for us.)

It will also behoove us to remove all remnants of the previous server configuration contained in:  
- ICAT content ...  
```
sudo su - postgres -c "dropdb --if-exists ICAT && createdb ICAT"
```
- *and* system files  ( be sure not to do the following until you've actually taken the above steps to remove the old irods packages or the package system *won't* be happy - [<sup>*see appendix w.r.t. "getting out of dpkg heck"</sup>](./appendix.md#dpkg_heck) )
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

Let us first make sure the `ninja-build` package is installed: (`ninja` is a close relative of `make` -- but highly optimized to take advantage of fast / multi-core CPU's):  
`sudo apt-get install ninja-build`

At this point we want to create local copies of two source code repositories (or "repo's") on iRODS's [GitHub](http://github.com/irods). These are the [core/ICAT-server](http://github.com/irods/irods) and the [icommands](http://github.com/irods/irods_client_icommands) code repositories.  Let's create and situate ourselves in a convenient parent directory first - for purposes of the description here, we will assume it to be `github` subdirectory of our `$HOME` directory:  
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
Now we create parallel directories in which to actually generate all intermediate files as well as the `.deb` (Debian) package files that will ultimately result when we build from the source.

*NOTE* - a beneficial effect of using **cmake** to build "outside the source"  is essentially to keep the repository itself "clean" - so git doesn't need to be confused by the presence of a multitude of files resulting from the build.

With this in mind, set a dummy `bash` variable `d`:  
`d=irods`  
and follow up with the boilerplate commands below:
```
mkdir bld__$d && cd bld__$d  && \
cmake -DCMAKE_BUILD_TYPE=Debug -GNinja ../$d && \
ninja package  
```
which should build all of the iRODS core code, including ICAT server, runtime, development support files, and plugins.

This will take a while, but once it is done, a number  of `*.deb` packages will have been created, typically named something like:
```
irods-database-plugin-mysql_4.2.2~trusty_amd64.deb   
irods-database-plugin-postgres_4.2.2~trusty_amd64.deb  
irods-runtime_4.2.2~trusty_amd64.deb
irods-database-plugin-oracle_4.2.2~trusty_amd64.deb  
irods-dev_4.2.2~trusty_amd64.deb                       
irods-server_4.2.2~trusty_amd64.deb
```
Before going on to the next compilation  step we want to install the `dev` and `runtime` packages:  
`sudo dpkg -i irods-{dev,runtime}*.deb`  
and then exit that directory:  
`cd ..`  

We now repeat the package building step for the **icommands** build:  
`d=irods_client_icommands`   
and again the boilerplate:
```
mkdir bld__$d && cd bld__$d  && \
cmake -DCMAKE_BUILD_TYPE=Debug -GNinja ../$d && \
ninja package  
```
With that success, we can install the resulting package as well:
```
sudo dpkg -i irods*icommands*.deb
```

Since the *icommands* are actually required for installing the iRODS server proper.
we'll change directories back to the place of our previous build:
```
cd ../bld__irods
sudo dpkg -i irods-server*.deb irods-database-plugin-postgres*.deb
```
At this point we can return to a fully iRODS-enabled system using the old stand-by :
```
sudo python /var/lib/irods/scripts/setup_irods.py < /var/lib/irods/packaging/localhost_setup_postgres.input
```

---
Footnotes


<A name="footnote1"><sup>1</sup></A> To be more sensitive to system environment, and more resilient in the face of upgrades, an improved addition to `~/.bashrc` might be:
```
if [ -d /opt/irods-externals ] && [[ ! ($PATH =~ /opt/irods-externals) ]] ; then
  while read d ; do
        export PATH="$d:$PATH"
  done < <(ls -d /opt/irods-externals/{cmake,clang}*/bin 2>/dev/null)
fi
```
And note that this also adds `clang` and `clang++` into your PATH, as well as `cmake`.
