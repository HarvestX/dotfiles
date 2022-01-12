#!/usr/bin/env bash

target=$HOME/.ssh/authorized_keys

echo '# HarvestX members' > $target
for row in $(gh api /orgs/HarvestX/members | \
  jq -r '.[] | {type: .type, username: .login} | select( .type | contains("User")) | { username: .username } | @base64'
); do
  _jq() {
    echo ${row} | base64 --decode | jq -r ${1}
  }
  username=$(_jq '.username')
  echo "Add: $username"
  wget -qO- https://github.com/${username}.keys >> $target
done

unset target username row
