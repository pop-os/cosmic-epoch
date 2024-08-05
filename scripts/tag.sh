#!/usr/bin/env bash

set -e

TAG="$1"

if [ -z "$TAG" ]
then
    echo "$0 [tag]" >&2
    exit 1
fi

echo "Do you want to tag the current state of cosmic-epoch with the tag $TAG? (y/N)"
read answer
if [ "$answer" != "y" ]
then
    echo "Did not answer y, exiting" >&2
    exit 1
fi

set -x

git fetch --recurse-submodules

git tag --force "$TAG"
git submodule foreach git tag --force "$TAG"

git push --force origin tag "$TAG"
git submodule foreach git push --force origin tag "$TAG"
