#!usr/bin/bash

branch_name="feature-lab_my_branch"
source_branch_name="my_new_branch"

DEVEVLOP_LAB_SOURCE_BRANCH="develop-lab"
DEVELOP_INT_SOURCE_BRANCH="develop-int"
RELEASE_LAB_SOURCE_BRANCH="develop-lab"
RELEASE_INT_SOURCE_BRANCH="develop-int"
HOTFIX_SOURCE_BRANCH="main"
DEVELOP_LAB_SOURCE_CATALOG="DEVELOP_LAB"
DEVELOP_INT_SOURCE_CATALOG="DEVELOP_INT"
RELEASE_LAB_SOURCE_CATALOG="DEVELOP_LAB"
RELEASE_INT_SOURCE_CATALOG="DEVELOP_INT"
HOTFIX_SOURCE_CATALOG="PROD"


# Check if there is a commit on the branch which is not on the source branch (i.e. the branch is new)
if [ "$branch_name"=="*feature-lab*" ]; then
    echo "matched pattern feature-lab"
    if [ ! $(git log $branch_name --not $source_branch_name) ]; then
        echo "branch $branch_name has no commits which are not on the branch $source_branch_name"
    else
        echo "branch $branch_name already has commits which are not on the branch $source_branch_name"
    fi
elif [ "$branch_name"=="*feature-lab*" ] && [ $(git log $branch_name --not $source_branch_name) ]; then
    echo "branch $branch_name has commits which are not on the branch $source_branch_name"
else
    echo 'nothing matched' #"branch $branch_name has no commits which are not on the branch $source_branch_name"
fi
