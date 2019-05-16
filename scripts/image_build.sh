#!/bin/bash

################################################################################
# For this script to work properly it is required to define some environment variables
# in the CI/CD Env variable declaration, while others should be passed as parameters.
#
#------------------------------------------------------------------------------
# Defined as part of the CD/CI Env Variables:
#
# CD_DOCKER_USERNAME
# A DockerHub username to be used for uploading the build.
#
# CD_DOCKER_PASSWORD
# A DockerHub password to be used for uploading the build.
#
# CD_DOCKER_REPO
# A DockerHub repository. By default the CD_REF_SLUG is also used as the docker repo.
#
# CD_BUILD_ALL
# As the build is supposed to be done only for master (for a nightly deployments) and for releases
# (like 'release-2.0.5' for production deployments), it is additionally required to include this
# variable in order to build any other brnach, as it may be required for testing or reviewing work
# as part of the development process.
#

echo "v2019022601"

display_usage() {
  echo "This script should be used as part of a CI strategy."
  echo -e "Usage:\n  build_image.sh [ARGUMENTS]"
  echo -e "\nMandatory arguments \n"
  echo -e "  repo_slug     The git repository  (e.g. bigbluebutton/greenlight)"
  echo -e "  branch | tag  The branch (e.g. master | release-2.0.5)"
  echo -e "  commit_sha    The sha for the current commit (e.g. 750615dd479c23c8873502d45158b10812ea3274)"
}

# if less than two arguments supplied, display usage
if [ $# -le 1 ]; then
	display_usage
	exit 1
fi

# check whether user had supplied -h or --help . If yes display usage
if [[ ($# == "--help") ||  $# == "-h" ]]; then
	display_usage
	exit 0
fi

export CD_REF_SLUG=$1
export CD_REF_NAME=$2
export CD_COMMIT_SHA=$3
if [ -z $CD_DOCKER_REPO ]; then
  export CD_DOCKER_REPO=$CD_REF_SLUG
fi

if [ "$CD_REF_NAME" != "master" ] && [[ "$CD_REF_NAME" != *"release"* ]] && ( -z $CD_BUILD_ALL ] || [ "$CD_BUILD_ALL" != "true" ] ); then
  echo "#### Docker image for $CD_REF_SLUG won't be built"
  exit 0
fi

# Set the version tag when it is a release or the commit sha was included.
if [[ "$CD_REF_NAME" == *"release"* ]]; then
  sed -i "s/VERSION =.*/VERSION = \"${CD_REF_NAME:8}\"/g" config/initializers/version.rb
elif [ ! -z $CD_COMMIT_SHA ]; then
  sed -i "s/VERSION =.*/VERSION = \"$CD_REF_NAME ($(expr substr $CD_COMMIT_SHA 1 8))\"/g" config/initializers/version.rb
fi

if [ -z "$CD_DOCKER_USERNAME" ] || [ -z "$CD_DOCKER_PASSWORD" ]; then
  echo "#### Docker image for $CD_DOCKER_REPO can't be published because CD_DOCKER_USERNAME or CD_DOCKER_PASSWORD are missing"
  exit 0
fi

# Loggin to docker hub
docker login -u="$CD_DOCKER_USERNAME" -p="$CD_DOCKER_PASSWORD"

# Pull the image
echo "#### Pulling Docker image $CD_DOCKER_REPO:$CD_REF_NAME"
#docker pull $CD_DOCKER_REPO:$CD_REF_NAME

# Build the image
echo "#### Docker image $CD_DOCKER_REPO:$CD_REF_NAME is being built"
docker build -t $CD_DOCKER_REPO:$CD_REF_NAME .

docker image ls

echo "#### Docker image $CD_DOCKER_REPO:$CD_REF_NAME is being published"
docker push $CD_DOCKER_USERNAME/$CD_DOCKER_REPO:$CD_REF_NAME

exit 0
