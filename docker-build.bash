#!/bin/bash
set -Eeuo pipefail

traperr() {
  echo "ERROR: ${BASH_SOURCE[1]} at about line ${BASH_LINENO[0]}"
}

set -o errtrace
trap traperr ERR

source ./env.bash

validate_env () {
  if [[ -z ${PROJECT_ID+x} ]] || [[ -z ${REGION+x} ]] || [[ -z ${GOOGLE_APPLICATION_CREDENTIALS+x} ]]; then
    echo "To run this deployment you need to export PROJECT_ID and REGION as follows:
    export REGION=<region e.g. europe-west1>
    export PROJECT_ID=<project name e.g. hyperd>
    export GOOGLE_APPLICATION_CREDENTIALS=<path to your service account key e.g. $PWD/secrets/gcloud/key.json>";
    exit 1
  fi
}

gcloud_setup () {
  gcloud config set project ${PROJECT_ID}
    # implicitly enable the apis we'll use
  gcloud services enable storage-api.googleapis.com
  gcloud services enable cloudresourcemanager.googleapis.com
  gcloud services enable compute.googleapis.com
  gcloud services enable container.googleapis.com
  gcloud services enable iam.googleapis.com

  # create a service account in the project, give it permissions, and obtain a key.
  if gcloud iam service-accounts list | grep "hyperd@$PROJECT_ID.iam.gserviceaccount.com" | awk '{print $1}'; then
    echo "service-accounts: hyperd@$PROJECT_ID.iam.gserviceaccount.com"
  else
    gcloud iam service-accounts create hyperd --display-name "hyperd"
    gcloud projects add-iam-policy-binding $PROJECT_ID --member "serviceAccount:hyperd@$PROJECT_ID.iam.gserviceaccount.com" --role "roles/owner"
    gcloud iam service-accounts keys create $PWD/secrets/gcloud/key.json --iam-account hyperd@$PROJECT_ID.iam.gserviceaccount.com
  fi

  # make the key available in this session
  export GOOGLE_APPLICATION_CREDENTIALS="$PWD/secrets/gcloud/key.json"

  # implicitly install other gcloud components we'll need to run the rest
  gcloud components install -q gsutil kubectl docker-credential-gcr
}

build() {
	cat >&2 <<-'EOF'


--------------------------------------------------------------

	EOF
    echo "run time: $(date) @ $(hostname)"
    echo
    echo "building image: $2"
    echo
    echo "build context: ${BASE_DIR}/$1"
    echo

    docker build --no-cache -t $2 ${BASE_DIR}/$1/
}


build_docker_images () {

  build base/alpine ${REGISTRY}/$PROJECT_ID/alpine:base
  build haproxy/alpine ${REGISTRY}/$PROJECT_ID/haproxy:latest

  # configure pushing to private GCR, and push our image
  gcloud auth configure-docker -q
  docker push ${REGISTRY}/$PROJECT_ID/alpine:base
  docker push ${REGISTRY}/$PROJECT_ID/haproxy:latest
}

init() {

  # check that PROJECT_ID and REGION are exported in the current shell
  validate_env

  # run the initial gcloud setup
  gcloud_setup

  # build the API docker images and push em to a GCR private registry
  build_docker_images
}

report () {
	cat >&2 <<-'EOF'

All the Alpine Factory Docker Images are now up to date.

	EOF
}

init && report
