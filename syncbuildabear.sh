#!/bin/bash -e

########################
# iRODS Build-a-Bear v4
# Save as ~/bin/syncbuildabear
# Replicate the lines below to sync more repo's
# The SHA for the curent repo will be printed by each "git rev-parse"
########################

BUILDHOST=build-ub12.irods.renci.org
SOURCEPATH=/home/${USERNAME:=`id -un`}/Tmp/irods
TARGETPATH=/projects/irods/personal-testing-repos/dmoore/irods

echo "Syncing irods to ${BUILDHOST}..."
rsync -rlt --delete ${SOURCEPATH}/.git/ ${USERNAME:-`id -un`}@${BUILDHOST}:${TARGETPATH}/.git/
echo "------ Build-a-Bear Parameters ------"
echo ${TARGETPATH}
cd ${SOURCEPATH}
git rev-parse HEAD
