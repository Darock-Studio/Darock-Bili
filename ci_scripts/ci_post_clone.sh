#!/bin/bash

if [ "$CI_WORKFLOW" = "Public Release" ]; then
    curl -X POST -H "Accept: application/vnd.github.v3+json" -H "Authorization: Bearer $GH_TOKEN" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/Darock-Studio/Darock-Bili/actions/workflows/tf.yml/dispatches -d "{\"ref\":\"$CI_TAG\",\"inputs\":{\"buildv\":\"$CI_TAG\"}}"
fi
