# Git and GitHub for Open-Source Collaboration


<A name="basics"> </A>

Git basics:
---

### Installing

 install `git` and `tig` binaries:  

```
sudo apt-get install git tig
```

### Basic usage - for projects *you* own
```
mkdir myrepo ; cd myrepo ; git init

echo 'main(){}' >> mainfn.c
```
(Oh wait, we want to eventually sync this repo with one by the same name on [GitHub](http://github.com) making it public!) Go to GitHub, create an account if you haven't already. Create a repo on GitHub, we'll assume the URL is something like:
  `http://github.com/<yourUserName>/myrepo`

Among the steps to be taken to save our first work, git's `commit` subcommand in particular demands we have a GitHub user name and e-mail set up. So set those up, either local to this repo folder (in `./.git/config`) or using `--global` to effectively edit the config file for all repos you'll create on your machine (in `~/.gitconfig`):
```
git config [--global] user.name <yourUserName>
git config [--global] user.email <yourGitHubAssociatedEMAIL>
```
With the above done in your repo, you can commit the first changes:
```
git status # -> tell about unstaged changes
git add .  # -> stage everything from '.' recursively
git commit -m "first commit - main function added"
tig  #__ shows first commit
```
Now that the local commit is made, you can make a connection to GitHub and mirror your changes there via:
```
git remote add origin git@github.com:yourUserName/myrepo.git
git push -u origin master
```

---
<A name="pointers"> </A>

### Setup for projects on which you don't have GitHub `push` access

You can add your own fork of another project on GitHub, say [iRODS](http://github.com/irods/irods), and after cloning your fork locally on your machine for development / debugging purposes, add the aforementioned upstream repo to your `git` config for pull requests.

(That is, you'll make changes to your own fork of the project and those can be synced with upstream using `git pull --rebase`, and then formalized into a pull request to the maintainer(s) of the upstream repo.)

The configuration changes for your local repo directory can be made using instructions from here:

[Configuring a remote for a fork](https://help.github.com/articles/configuring-a-remote-for-a-fork/)

*Note also:*

- feature branches are cheap to create and can simplify the process of merging with the work of other collaborators (oh-oh, faux pas - we like to rebase here as a rule, rather than doing raw merges! :) )

- `git rebase -i` can (should, if the trail of commits is too long or "a different story needs to be told") be used to squash a number of changes along a branch before rebasing or cherry-picking your work onto `master` or some other main branch.
