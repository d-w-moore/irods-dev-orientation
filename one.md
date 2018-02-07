# Chapter 1., In which we test and interact with a living, breathing iRODS Server

A side effect of installing the **4.2.2** release of iRODS server, and running the setup script as directed by the web links mentioned at the end of last chapter, we now have a running server and we can interact with it using "icommands". The first few commands we'll use are `iput`,`ipwd`, `ils`, and `irm`. The first one is used to "put" a local file into iRODS as a data object; the other three commands are iRODS' functional equivalents of the Un\*x commands which they closely resemble.

To verify we have a properly running iRODS server, first open a terminal window and issue the command: 

`sudo su - irods`

If successful, this will switch you over to the iRODS service account user, `irods`. (If not successful, you need your administrator to grant you `sudo` access).  

From this shell prompt you should be able to see the current working directory of the `irods` user's current session (ie. persistent connection to the running server) by typing :
`ipwd`

Now, use the command line `touch sample.txt` to make sure a file by that name exists in your current directory.  
Then type `iput sample.txt`
What this has done is to insert the file you just created, as a new data object (equivalent to a data file in iRODS) into iRODS' local catalog of objects. `ils` should verify that it is there, in the `/tempZone/home/irods` directory where you sit by default when logging in to any new iRODS session as user `irods`.

The next step, assuming you followed the complete directions in the Getting Started slides and used the `git clone` command to download the irods_training repositiory, will be to read -- and step through -- the beginner training outlined in a .PDF file in your local copy of that training repo.

