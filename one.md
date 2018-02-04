# Chapter 1., In which we test and interact with a living, breathing iRODS Server

A side effect of installing the **4.2.2** release of iRODS server, and running the setup script as directed by the web links mentioned at the end of last chapter, we now have a running server and we can interact with it using "icommands". The first two we'll use are `iinit`, `ipwd`, `ils` and `iput`

First however, open a terminal window and issue the command: 
`sudo su - irods`

If successful, this will switch you over to the iRODS service account user, `irods`. (If not successful, you need your administrator to grant you `sudo` access).  From that prompt you should be able to use the current working directory of the `irods` user's current session (ie. persistent connection to the running server).
`ipwd`
to request a directory (much as Un\*x `pwd` does) of the current working directory

`touch sample.txt` to make sure a file by that name exists in your current directory. Then type.
