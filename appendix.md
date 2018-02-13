# APPENDIX
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

# Part B. Running `openvpn` for access to firewalled servers and VM's

- MacOS  
    1. On your first accessing the https://vpn.renci.org web-page, you will be prompted to download a OpenVPN Connect `.dmg` file.
    1. Clicking on this file will most likely fail to install the software the first time, as MacOS guards against developers it doesn't recognize. Solve this problem by opening the `System Preferences` dialog and going to the `General` settings tab.  Your computer will remember the attempt to install the OpenVPN package, and will offer the option to install it after all.  Click through, as the folks at OpenVPN are not rogue developers....
    1. Subsequent openings of the above-mentioned URL should offer a 'connect' or 'login', and you'll want to choose the former after entering your credentials.
    
- Linux  
  ...
- MS Windows  
  ...
