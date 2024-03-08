#!/bin/bash

VERSION=$1

# Fetch latest tag, fallback to v0.0.0 if doesn't exist
git fetch --prune --unshallow 2>/dev/null
CURRENT_VERSION=$(git describe --abbrev=0 --tags 2>/dev/null)

if [[ $CURRENT_VERSION == '' ]]
then
  CURRENT_VERSION='v0.0.0'
fi

# remove v from tag and split tag by . into an array
VERSION_WITHOUT_V="${CURRENT_VERSION:1}"
CURRENT_VERSION_PARTS=(${VERSION_WITHOUT_V//./ })

# get number parts and increment
MAJOR=${CURRENT_VERSION_PARTS[0]}
MINOR=${CURRENT_VERSION_PARTS[1]}
PATCH=${CURRENT_VERSION_PARTS[2]}

if [[ $VERSION == 'major' ]]
then
  MAJOR=$((MAJOR+1))
  MINOR='0'
  PATCH='0'
elif [[ $VERSION == 'minor' ]]
then
  MINOR=$((MINOR+1))
  PATCH='0'
elif [[ $VERSION == 'patch' ]]
then
  PATCH=$((PATCH+1))
else
  echo "No version type (https://semver.org/) or incorrect type specified, try: -v [major, minor, patch]"
  exit 1
fi

NEW_VERSION="$MAJOR.$MINOR.$PATCH"
{
  echo latest_tag=$CURRENT_VERSION
  echo old_version=$VERSION_WITHOUT_V
  echo new_version=$NEW_VERSION
  echo major_version=$MAJOR
  echo minor_version=$MINOR
  echo patch_version=$PATCH
} >> "$GITHUB_OUTPUT"
