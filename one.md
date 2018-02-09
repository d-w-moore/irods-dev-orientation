## Testing out the newly installed iRODS Server

If you've installed the iRODS server binary and its associated support packages and run the setup script, as directed in the last section, you should now have a functioning instance of an iRODS server running locally on your computer. The server is the interface and mediator between any client (local or remote) and the ICAT database that tracks all data objects iRODS knows about.

You can now begin interacting with the server using the iRODS client "icommands".  Of these just a couple of examples will be given here, after which it will behoove any beginner to step through the beginner training ([link](#endsection) at the end of this section) in which the environment and some basic use cases are explored, and some aspects of the iRODS infrastructure are explained -- object metadata and its manipulation being an important very part of the latter.

In many cases similar their un\*x-like cousins (except for a prepended 'i' in the name), the icommands are also analogous in function to those same counterparts : `icd`, `ipwd`, `ils`, and `irm` do pretty much what you'd think -- the difference being that they function relative to the hierarchy of iRODS collections  and data objects, rather than to the Unix filesystem. `iput` is another important one which can take a file from your current Unix directory and place it into iRODS as a data object.

---

To verify the iRODS server is running on your machine, you can open a terminal window and take the following steps:

* The command `sudo su - irods` should allow you to become the `irods` "service account" (ie. admin) user.

* As `irods`, you should be able to see the current position in the iRODS hierarchy (tracked by your current session as the admin user, logged into the ICAT-enabled server) by typing the following command : `ipwd`

* Use the command line `touch sample.txt` to make sure a file by that name exists in your current directory.  Then type `iput sample.txt` This should insert the file you just created -- but as a new data object -- into the iRODS catalog. Issuing an `ils` command should verify that it is there, in the `/tempZone/home/irods` directory where you sit by default when first logging in as this iRODS user.

---
<A name="endsection"></A>
Assuming you [cloned](http://slides.com/irods/ugm2017-getting-started#/2) the [irods_training](https://github.com/irods/irods_training) repository while working through the last section, your next step should be read the beginner training contained therein, and work throught the examples presented in that document.
