## Compiling Mozilla's "rr" (record/replay) source debugger

First change directory to a convenient place for cloned repo's and builds. Then clone the RR repository from github:

```
git clone http://github.com/mozilla/rr.git
```

Optionally do : `mkdir ~/local` if you want a non-root install.

Note the wiki on GitHub has expansive instructions on building the rr binaries:  
```https://github.com/mozilla/rr/wiki/Building-And-Installing#hardwaresoftware-requirements```

Do this to install prerequisites for building `rr`:
```
sudo apt-get install ccache cmake make g++-multilib gdb \
  pkg-config realpath python-pexpect manpages-dev git \
  ninja-build capnproto libcapnp-dev
  ```
  
Also included on the wiki page  is a pointer to how to build capnproto from scratch, 
necessary if using earlier than Ubuntu 16 . Follow the excerpt below, or get fuller 
instructions from the included link:

```https://capnproto.org/install.html#installation-unix```

So stop right here and use these commands to build `capnproto` if you're using Ubuntu 14 :
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

` cd build_rr  &&  cmake -DCMAKE_INSTALL_PREFIX:PATH=$HOME/local -Ddisable32bit=ON  ../rr `

Again we're assuming an *amd64-compatible* build, *non-root* install. You can omit the '-DCMAKE_INSTALL_PREFIX...' part and the rr binary will be
installed under `/usr/local/` per the default.

After this, you should be able to build with `make` (insert your `-j <#cpusToUse>` if desired) , then:

`make test` and (with `sudo` unless doing non-root install):
`make install`

The tests may fail on `vsyscall_reverse_next` due to a regex-fail in the test, but this is ok.

Sample use is (under bash, and optionally putting first line of below into your `~/.bashrc` so you don't have to type it every time):

```
export PATH=$HOME/local/bin:$PATH #non-root install only
rr record -w  <cmd args...>
rr ps
rr replay -f <pid>
```

(The `-w` in the first command apparently prevents the debugging from exiting in the case it aborts or exits with subprocesses still running.)

