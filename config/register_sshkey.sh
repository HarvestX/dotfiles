#!/usr/bin/env bash

organization="HarvestX"
target=$HOME/.ssh/authorized_keys

get_org_users() {
  ## get_username_list organization
  local username
  local usernames=()
  local organization=$1
  for row in $(
    gh api /orgs/$organization/members |
      jq -r '.[] | {type: .type, username: .login} | select( .type | contains("User")) | { username: .username } | @base64'
  ); do
    _jq() {
      echo ${row} | base64 --decode | jq -r ${1}
    }
    username=$(_jq '.username')
    usernames+=("$username")
  done
  echo "${usernames[@]}"
}

register_key() {
  # register_key $username $target
  local username=$1
  local target=$2
  echo "$username >> $target" >&2
  echo "## $username" >>$target
  wget -qO- https://github.com/${username}.keys >>$target
}

usernames=$(get_org_users $organization)

echo "Gettig username from $organization"
wcho "Add keys to $target"
echo "# $organization members" >$target

if [ $# -eq 0 ]; then
  # Register all
  for username in $usernames; do
    register_key $username $target
  done
elif [ $# -gt 0 ]; then
  # Register all
  for arg in $@; do
    registered=0
    for username in $usernames; do
      if [[ $arg == $username ]]; then
        register_key $username $target
        registered=1
      else
        continue
      fi
    done
    if [[ $registered == 0 ]]; then
      echo "$arg is invalid username" >&2
    fi
  done
fi

unset usernames
