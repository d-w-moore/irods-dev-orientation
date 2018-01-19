# Chapter 1., In which we install iRODS binaries and interact with a living, breathing server

You can now install the server and database plug-ins straight from the repository:
`sudo apt-get -y install irods-server irods-database-plugin-postgres`

At this point, also configure the server and set it in motion:
`sudo python /var/lib/irods/scripts/setup_irods.py < /var/lib/irods/packaging/localhost_setup_postgres.input`
