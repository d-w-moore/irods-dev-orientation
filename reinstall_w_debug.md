# Reinstalling iRODS with Debug

The most valuable instructive step to be taken from this point is to reinstall the iRODS server and icommands packages with Debug symbols enabled. Doing this will allow us later to step through commands under GDB as they're being executed, and even peek into the internal workings of the server.  There's a tool called "rr" (record/replay) which allows us to fully record and then *replay*  (ie. deterministically "debug" in an environment almost identical to GDB's) the operations performed by the server during the *record* operation. And yes, you can even do reverse execution, that is undo steps, function "finishes", set reverse-run breakpoints, etc.

---
# Prerequisites
To install the debuggable iRODS packages, we must build them first.

Since we've already done a repository-sourced version of the `irods-server` `irods-database-plugin-postgres` packages via the command-line, we'll first have to uninstall them to make way for our newly built packages.

Therefore, first do the following command to remove the existing iRODS software from the machine:
```
sudo apt-get remove irods-{dev,runtime}
```
