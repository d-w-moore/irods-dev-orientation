#!/bin/bash -e

########################
# iRODS Build-a-Bear v4
# (modified from original form for demo purposes and some added convenience)
# Save as ~/bin/syncbuildabear
# run as "R_USER=remoteLoginName syncbuildabear" if remoteLoginName NE `id -un`
########################

RELPATH_TO_REPOS=./github  #__ directory / path undef $HOME containing your repo's

BUILDHOST=build-ub12.irods.renci.org
SOURCEPATH=/home/${USERNAME:=`id -un`}/${RELPATH_TO_REPOS}/irods
TARGETPATH=/projects/irods/personal-testing-repos/${R_USER:=$USERNAME}/irods

echo "Syncing irods to ${BUILDHOST}..."
rsync -rlt --delete ${SOURCEPATH}/.git/ ${R_USER}@${BUILDHOST}:${TARGETPATH}/.git/
echo "------ Build-a-Bear Parameters ------"
echo ${TARGETPATH}
cd ${SOURCEPATH}
git rev-parse HEAD

#== replicate the above code for other repository/-ies as necessary:

BUILDHOST=build-ub12.irods.renci.org
SOURCEPATH=/home/${USERNAME:=`id -un`}/${RELPATH_TO_REPOS}/irods_client_icommands
TARGETPATH=/projects/irods/personal-testing-repos/${R_USER:=$USERNAME}/irods_client_icommands

if [ -d "${SOURCEPATH}" ]; then
  echo "Syncing irods to ${BUILDHOST}..."
  rsync -rlt --delete ${SOURCEPATH}/.git/ ${R_USER}@${BUILDHOST}:${TARGETPATH}/.git/
  echo "------ Build-a-Bear Parameters ------"
  echo ${TARGETPATH}
  cd ${SOURCEPATH}
  git rev-parse HEAD
fi
