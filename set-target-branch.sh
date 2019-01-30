#!/usr/bin/env bash
set -e

if [ -z "$MERGE_MAP" ]; then
  echo "MERGE_MAP is not set/provided, using .gitlab-merge.json"
  echo "Refer sample as .gitlab-merge-sample-mapping"
  MERGE_MAP=".gitlab-merge.json"
fi

if [ ! -f "$MERGE_MAP" ]; then
    echo "MERGE_MAP File ${MERGE_MAP} not found!"
    AUTO_MERGE=false
    return
fi

if [ -z "$TARGET_BRANCH" ]; then
  echo "TARGET_BRANCH not set"
  echo "Determining Default branch to open the Merge request"
  # Look which is the default branch
  #TARGET_BRANCH=`cat .gitlab-merge-sample-mapping | jq ${CI_COMMIT_REF_NAME}`
  cat ${MERGE_MAP}
  SOURCE_KEY=$CI_COMMIT_REF_NAME
  echo "SOURCE_KEY ${SOURCE_KEY}"
  MERGE_TARGET=`cat ${MERGE_MAP}| jq '.[${SOURCE_KEY}]'`
  echo "MERGE_TARGET: ${MERGE_TARGET}"
fi

if [ "$MERGE_TARGET" == "null" ]; then
   echo "No mapping found in .gitlab-merge.json for creating merge request"
   if [ ! -z "$FALLBACK_TARGET_BRANCH" ]; then
      if [ ! -z "$SQUASH" ]; then
        echo "FALLBACK_TARGET_BRANCH is set and SQUASH not set, so setting squash to true when merge map not found"
        SQUASH=true
      fi
    fi
else
   TARGET_BRANCH=$MERGE_TARGET
   echo "Using TARGET_BRANCH ${TARGET_BRANCH}"
   #Conditional auto merge if it is set to false or anything it will not execute else it will set as true when merge map matches
   if [ -z "$AUTO_MERGE" ]; then
     AUTO_MERGE=true
   fi
fi
