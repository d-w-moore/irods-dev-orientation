#!/bin/bash -e

########################
# iRODS Build-a-Bear v4
# Save as ~/bin/syncbuildabear
# Replicate the lines below to sync more repo's
# The SHA for the curent repo will be printed by each "git rev-parse"
# use 'R_USERNAME=<remote_loginname> syncbuildabear' if remote != local 
########################

PATH_TO_REPOS=$HOME/github #__ change to reflect your own choice of local path

BUILDHOST=build-ub12.irods.renci.org
SOURCEPATH=/home/${USERNAME:=`id -un`}/${PATH_TO_REPOS}/irods  #__ server code
TARGETPATH=/projects/irods/personal-testing-repos/${R_USERNAME:=$USERNAME}/irods

echo "Syncing irods to ${BUILDHOST}..."
rsync -rlt --delete ${SOURCEPATH}/.git/ ${R_USERNAME}@${BUILDHOST}:${TARGETPATH}/.git/
echo "------ Build-a-Bear Parameters ------"
echo ${TARGETPATH}
cd ${SOURCEPATH}
git rev-parse HEAD

#==  Optionally, copy the above section as below to build/test a custom 
#    irods_client_icommands repo. (Do so by removing or commenting out the `cat` line which follows)
cat <<':'>/dev/null

BUILDHOST=build-ub12.irods.renci.org
SOURCEPATH=/home/${USERNAME:=`id -un`}/${PATH_TO_REPOS}/irods  #__ server code
TARGETPATH=/projects/irods/personal-testing-repos/${R_USERNAME:=$USERNAME}/irods_client_icommands

echo "Syncing irods to ${BUILDHOST}..."
rsync -rlt --delete ${SOURCEPATH}/.git/ ${R_USERNAME}@${BUILDHOST}:${TARGETPATH}/.git/
echo "------ Build-a-Bear Parameters ------"
echo ${TARGETPATH}
cd ${SOURCEPATH}
git rev-parse HEAD

:
