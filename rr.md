## Compiling Mozilla's "rr" (record/replay) source debugger

First change directory to a convenient place for cloned repo's and builds. Then clone the RR repository from github:

```
git clone http://github.com/mozilla/rr.git
```

Optionally do : `mkdir ~/local` if you want a non-root install.

Note the wiki on GitHub has expansive instructions on building the rr binaries:  

  https://github.com/mozilla/rr/wiki/Building-And-Installing#hardwaresoftware-requirements

Do this to install prerequisites for building `rr`:
```
sudo apt-get install ccache cmake make g++-multilib gdb \
  pkg-config realpath python-pexpect manpages-dev git \
  ninja-build capnproto libcapnp-dev
```
  
Also included on the wiki page  is a pointer to how to build capnproto from scratch, 
necessary if using earlier than Ubuntu 16 . Follow the excerpt below, or get fuller 
instructions from the included link:

  https://capnproto.org/install.html#installation-unix

So pause right here to build `capnproto` if you're using Ubuntu 14 (or less recent) :
```
curl -O https://capnproto.org/capnproto-c++-0.6.1.tar.gz
tar zxf capnproto-c++-0.6.1.tar.gz
cd capnproto-c++-0.6.1
./configure
make -j6 check
sudo make install 
```

Now, `cd ..` to escape the **capnproto** build directory (if you performed that step) and  make a  build directory parallel to the `rr` directory: `mkdir build_rr`  

And:

```
$ cd build_rr
$ CC=clang CXX=clang++ cmake -G Ninja -Ddisable32bit=ON ../rr
```

The commands above configure the **rr** build to use the toolchain found under the /opt/irods-externals folder 
(cmake and clang).  Make sure that the /opt/irods-externals folders are in the $PATH environment before /bin and/or /usr/bin.

This will build rr:

```
$ ninja all
```

And, now that rr has been built, test it and install it using sudo. (Note that tuning the `perf_event_paranoid` kernel parameter may be necessary first. Directions at the foot of this section[\[1\]](#1). 

To test:

```
$ ninja test
```

The test runs (more than a thousand of them at this time) take a few minutes to complete, and should all pass.

The installation of rr should target 
/usr/local/ (the default action), not your local file space, since there it may be used by more than one user:

```
$ sudo ninja install
```

To install rr locally under your home directory, make the following changes to the process above:

Add the following flag to the cmake command (use any path that you can write to):
```
-DCMAKE_INSTALL_PREFIX:PATH=$HOME/local
```
And, run the install process without using sudo:
```
$ ninja install
```

Sample use is (under bash, and optionally putting first line of below into your `~/.bashrc` so you don't have to type it every time):

```
export PATH=$HOME/local/bin:$PATH #non-root install only
rr record -w  <cmd args...>
rr ps
rr replay -f <pid>
```
***NOTE w.r.t. debugging the iRODS server(s) using `rr`***
The last of the commands given just above does the replay for the case of an iRODS server (vsn >=4.2) in which agents are spawned using only a fork() system call. In earlier versions (<=4.1) , agents were spawned with a fork() followed by exec() and thus the `-p` switch should be used in place of `-f`.

(The `-w` in the first command apparently prevents the debugging from exiting in the case it aborts or exits with subprocesses still running.)

---
FootNotes
---

<A name="1"></A>

On Linux based platforms , following these instructions may be necessary before testing  or running the newly built `rr`.
   - We must modify a kernel parameter which may be set too high by default for `rr`'s proper functioning. Edit the `/etc/sysctl.conf` to include the following line:  
```
    kernel.perf_event_paranoid = -1
```
   - Although any value less than `2` should do.  
   - To force the system to pick up this change, either do `sysctl -p` as ***root***, or reboot the machine.  

