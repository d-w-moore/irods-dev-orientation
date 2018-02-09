## Testing out the newly installed iRODS Server

If you've installed the iRODS server binary and its associated support packages and run the setup script, as directed in the last section, you should now have a functioning, local instance of an iRODS server. You can test this fact by interacting with it via the iRODS client "icommands".  

In many cases similar their un\*x-like cousins (except for a prepended 'i' in the name), the icommands are also analogous in function to those same counterparts : `icd`, `ipwd`, `ils`, and `irm` do pretty much what you'd think -- the difference being that they navigate, orient, and inform you in terms of your current position and environment within the hierarchy of iRODS collections  and data objects, rather than a Unix filesystem . `iput` is another important one which can take a file from your current Unix directory and place it into iRODS as a data object.

Now, to verify there is a running iRODS server on your machine, you can first open a terminal window and take the following steps:

* This command should allow you to become `irods` "service account" (ie. admin) user:  `sudo su - irods`

* As `irods`, you should be able to see the current working directory of that user's current session (ie. persistent connection to the running server) by typing : `ipwd`

* Use the command line `touch sample.txt` to make sure a file by that name exists in your current directory.  Then type `iput sample.txt` This should insert the file you just created -- but as a new data object -- into iRODS' "ICAT" catalog of objects. Issuing an `ils` command should verify that it is there, in the `/tempZone/home/irods` directory where you sit by default when first logging in as this iRODS user.

Assuming you [cloned](http://slides.com/irods/ugm2017-getting-started#/2) the [irods_training](https://github.com/irods/irods_training) repository while working through the last section, your next step should be  read and work throught the examples presented there.
