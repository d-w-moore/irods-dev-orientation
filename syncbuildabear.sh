#!/bin/bash -e

########################
# iRODS Build-a-Bear v4
# Save as ~/bin/syncbuildabear
# Replicate the lines below to sync more repo's
# The SHA for the curent repo will be printed by each "git rev-parse"
# use 'R_USERNAME=<remote_loginname> ~/bin/syncbuildabear' if remote != local 
########################

BUILDHOST=build-ub12.irods.renci.org
SOURCEPATH=/home/${USERNAME:=`id -un`}/Tmp/irods
TARGETPATH=/projects/irods/personal-testing-repos/${R_USERNAME:=$USERNAME}/irods

echo "Syncing irods to ${BUILDHOST}..."
rsync -rlt --delete ${SOURCEPATH}/.git/ ${R_USERNAME}@${BUILDHOST}:${TARGETPATH}/.git/
echo "------ Build-a-Bear Parameters ------"
echo ${TARGETPATH}
cd ${SOURCEPATH}
git rev-parse HEAD
