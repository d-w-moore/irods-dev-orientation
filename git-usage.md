# Git and GitHub for Open-Source Collaboration


<A name="basics"> </A>

---


Git basics:
---

### what's what
`git` and all of its subcommands are the essentials here.

`tig` is a TUI for checking your revision history and status and is more in the "nice-to-have" category, but we shall assume in the following examples that you have it.   

### Installing


Make sure you have the `git` and `tig` binaries installed.  

```
sudo apt-get install git tig
```
create an example repo for your own experiments:
```
mkdir myrepo ; cd myrepo ; git init
```
Now you have a place to put your new project. Create a `.c` file:
```
echo 'main(){}' >> mainfn.c
```
and check your status with:
```
git status
```
`git` will tell you there are unstaged changes , meaning you need to tell it


---
<A name="pointers"> </A>

Links and pointers
---
[Configuring a remote for a fork](https://help.github.com/articles/configuring-a-remote-for-a-fork/)
