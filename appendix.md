# APPENDIX

---

<A name="part-A"> </A>
## Part A. Helpful `bash` prompt annotations

The following lines, appended to the `~/.bashrc` file, can be useful when working on the `bash` command line to do software development, and can particularly expedite tasks while using `git` to manage version control:

```
function tgrps1 {
  local BOLDRED="\[\033[1;31m\]"
  local GREEN="\[\033[0;32m\]"
  local BOLDYELLOW="\[\033[1;33m\]"
  local BOLDCYAN="\[\033[1;36m\]"
  local NOCOLOR="\[\033[0m\]"
  export GIT_PS1_SHOWDIRTYSTATE=1
  PS1=$BOLDRED'`echo "ERROR($?) " | sed '\''s/^ERROR(0) \$//'\''`'
  PS1+="$GREEN\$(date +%H:%M%p)"
  PS1+="$BOLDYELLOW\$(__git_ps1) "
  PS1+="$BOLDCYAN\u$NOCOLOR@\h:\w \$ "
}
tgrps1
```

Once these lines are added, continue by bringing up a new command window or doing an `exec bash` within the current one, and the command prompt should now reflect:

- the name of the branch currently checked out in the `git`-enabled repository in which you sit - that is, the machine-local folder aka directory aka "repo" closest to and at-or-above your current working directory
- the status relative to changes that might need to be `add`ed or `commit`ed to save work done in the repository
- the return code (highlighted in red) from the last command issued on the command line.

---

<A name="part-B"> </A>
## Part B. Running `openvpn` for access to firewall-protected RENCI servers and VM's

OpenVPN is available on a variety of platforms. Once installed and enabled, it will allow you to connect to RENCI-internal servers which would otherwise be unavailable from outside the office spaces.  In order to download and use OpenVPN, the first step is to navigate to  https://vpn.renci.org , and enter your credentials (RENCI username and password.)  

Then follow the instruction below that corresponds to your choice of computing platform:

- **MacOS**
    1. On first accessing the above URL, you will be prompted to download a OpenVPN Connect `.dmg` file.
    1. Once it is downloaded, clicking on this package installer will most likely fail to install the software the first time, as MacOS guards against software from developers it doesn't recognize. Solve this problem by opening the `System Preferences` dialog and going to the `General` settings tab.  Your computer will remember the attempt to install the OpenVPN package, and will offer the option to override the OS's initial barrier to installing.  Select it and click through, as the folks at OpenVPN are certainly not rogue developers....
    1. Subsequent openings of the above-mentioned URL should offer a 'connect' or 'login', and you'll want to choose the former after entering your credentials.

- **Microsoft Windows**
    * The process for enabling the VPN under Windows is almost identical to that given for MacOS above, except that the product being offered for download may be PrivateTunnel instead of OpenVPN Connect. Either will work.  You will most likely need administrative privileges associated with your windows login.

- **Linux**
    1. Once logged into the above-mentioned URL, click on the bottom-most link to download your connection profile. It will probably be called `client.ovpn`, but it contains your own specific credentials for logging in past RENCI firewalls.   
    1. Assuming you have `sudo` access on your machine, open up a terminal window and  issue the command : `sudo apt-get install openvpn`
    1. In the same terminal window command `openvpn -config [/path/to/client.ovpn]` to enable VPN access. You'll be prompted again for your RENCI user name and password.

---

## Part C. Jenkins / Build-a-Bear for

Thorough testing and Continuous Integration (CI) of new features encourages -- or demands, depending on the number of developers and/or active feature branches on a project -- an automated approach in order to ensure that these code changes do not interact destructively.  Once it's decided to automate testing of such things, it's a straightforward decision to extend the testing to ensuring the software, including projected changes, runs as expected on all of the different use cases and computing platforms for which it has been promised to run.

And so it is also for the iRODS core software: before a feature or code fix is added to the official code-base on GitHub, it is first staged and tested on a [Jenkins](http://jenkins.io) server where a system of automatic tests vet the change automatically - not only against the built-in system of unit tests, but also across the comprehensive list of operating systems iRODS supports. (These are currently Centos6 and 7, and Ubuntu 12,14, and 16).

Enter "Build-a-Bear".

Build-a-Bear, as it's known among core iRODS team, is a system of scripts that allows developers to push a custom build or set of changes from a local directory (ie git repo), to be build and tested prior to making them potentially official with a pull request. The steps in using it are roughly:

Sync your local `git` repo to an NFS-mounted directory visible to the Jenkins server (http://172.25.14.125:8080). This is done with a pre-formulated script typically kept by team members in `~/bin/syncbuildabear`. The script is of the form:

```
#!/bin/bash -e

########################
# iRODS Build-a-Bear v4
# Save as ~/bin/syncbuildabear
########################

BUILDHOST=build-ub12.irods.renci.org
SOURCEPATH=/home/danm/Tmp/irods
TARGETPATH=/projects/irods/personal-testing-repos/dmoore/irods

echo "Syncing irods to ${BUILDHOST}..."
rsync -rlt --delete ${SOURCEPATH}/.git/ dmoore@${BUILDHOST}:${TARGETPATH}/.git/
echo "------ Build-a-Bear Parameters ------"
echo ${TARGETPATH}
cd ${SOURCEPATH}
git rev-parse HEAD
    ```

And the NFS mount is accessed with an addition to `etc/fstab` of the following line:
```
na-projects.edc.renci.org:/ /projects nfs vers=3,hard,intr,rw,bg,timeo=600,rsize=65536,wsize=65536 0 0
```
The operative part of the script can be repeated for as many separate local repositories as need to be sync'ed.
