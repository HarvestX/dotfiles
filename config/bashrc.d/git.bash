#!/usr/bin/env bash

# Print the name of the git working tree's root directory
function groot() {
  local root first_commit
  # git displays its own error if not in a repository
  root=$(git rev-parse --show-toplevel) || return
  if [[ -n $root ]]; then
    echo $root
    return
  elif [[ $(git rev-parse --is-inside-git-dir) = true ]]; then
    # We're inside the .git directory
    # Store the commit id of the first commit to compare later
    # It's possible that $GIT_DIR points somewhere not inside the repo
    first_commit=$(git rev-list --parents HEAD | tail -1) ||
      echo "$0: Can't get initial commit" 2>&1 && false && return
    root=$(git rev-parse --git-dir)/.. &&
      # subshell so we don't change the user's working directory
    ( cd "$root" &&
      if [[ $(git rev-list --parents HEAD | tail -1) = $first_commit ]]; then
        pwd
      else
        echo "$FUNCNAME: git directory is not inside its repository" 2>&1
        false
      fi
    )
  else
    echo "$FUNCNAME: Can't determine repository root" 2>&1
    false
  fi
}

# Change working directory to git repository root
function rcd() {
  local root
  root=$(groot) || return 1  # git_root will print any errors
  cd "$root"
}

# Delete local branch which does not exist on remote repositiory
function gprune() {
  git fetch -p && \
    for branch in $(git branch -vv | grep ': gone]' | awk '{print $1}'); do\
      git branch -D $branch; \
    done
}

