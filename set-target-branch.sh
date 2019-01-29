#!/usr/bin/env bash
set -e

AUTO_MERGE=false

if [ -z "$MERGE_MAP" ]; then
  echo "MERGE_MAP is not set/provided, using .gitlab-merge.json"
  #echo "Please set MERGE_MAP file path, refer sample as .gitlab-merge-sample-mapping"
  MERGE_MAP=".gitlab-merge.json"
  #exit 0
fi

if [ ! -f "$MERGE_MAP" ]; then
    echo "MERGE_MAP File ${MERGE_MAP} not found!"
    #exit 0
    return
fi

if [ -z "$TARGET_BRANCH" ]; then
  echo "TARGET_BRANCH not set"
  echo "Determining Default branch to open the Merge request"
  # Look which is the default branch
  #TARGET_BRANCH=`cat .gitlab-merge-sample-mapping | jq ${CI_COMMIT_REF_NAME}`
  TARGET_BRANCH=`cat ${MERGE_MAP}| jq .${CI_COMMIT_REF_NAME}`
fi

if [ "$TARGET_BRANCH" == "null" ]; then
   echo "No mapping found in .gitlab-merge.json for creating merge request"
else
   echo "Using TARGET_BRANCH ${TARGET_BRANCH}"
   # Conditional auto merge
  AUTO_MERGE=true
fi