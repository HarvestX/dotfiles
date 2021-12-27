#!/usr/bin/env bash
set -ue

helpmsg() {
  command echo "Usage: $0 [--help | -h]" 0>&2
  command echo ""
}

ask() {
  while true; do
    read -p "$1 ([y]/n) " -r
    REPLY=${REPLY:-"y"}
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      echo 1
      break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
      echo 0
      break
    fi
  done
}


link_to_homedir() {
  local install_dir="$HOME/.config"
  local dotdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
  if [[ "$HOME" != "$dotdir" ]];then
    local dirs=`find $dotdir/* -maxdepth 0 -type d`
    for d in $dirs;
    do
      [[ `basename $d` == ".git" ]] && continue
      [[ `basename $d` == ".github" ]] && continue
      local installed_d=$install_dir/`basename $d`
      if [[ -L $installed_d ]];then
        command rm -rf "$installed_d"
      fi
      command ln -snf $d $install_dir
    done
  else
    command echo "same install src dest"
  fi
}

append_line() {
  set -e

  local update line file pat lno
  update="$1"
  line="$2"
  file="$3"
  pat="${4:-}"
  lno=""

  echo "Update $file:"
  echo "  - $line"
  if [ -f "$file" ]; then
    if [ $# -lt 4 ]; then
      lno=$(\grep -nF "$line" "$file" | sed 's/:.*//' | tr '\n' ' ')
    else
      lno=$(\grep -nF "$pat" "$file" | sed 's/:.*//' | tr '\n' ' ')
    fi
  fi
  if [ -n "$lno" ]; then
    echo "    - Already exists: line #$lno"
  else
    if [ $update -eq 1 ]; then
      [ -f "$file" ] && echo >> "$file"
      echo "$line" >> "$file"
      echo "    + Added"
    else
      echo "    ~ Skipped"
    fi
  fi
  echo
  set +e
}

update_shell() {
  shells="bash zsh fish"
  echo
  update_config=`ask "Do you want to update your shell configuration files?"`
  echo
  local prefix="$HOME/.config"
  for shell in $shells; do
    [[ "$shell" = fish ]] && continue
    [[ "$shell" = zsh ]] && continue
    [[ "$shell" = bash ]] && dest=~/.bashrc
    local target="${prefix}/${shell}rc.d/index.${shell}"
    append_line $update_config "[ -f ${target} ] && source ${target}" "${dest}" "${target}"
  done
}

while [ $# -gt 0 ];do
  case ${1} in
    --debug|-d)
      set -uex
      ;;
    --help|-h)
      helpmsg
      exit 1
      ;;
    *)
      ;;
  esac
  shift
done

link_to_homedir
update_shell

command echo -e "\e[1;36m Install completed 🍺\e[m"

