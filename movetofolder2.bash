#!/usr/bin/env bash

declare -A uniq

for files in *; do
  if [[ $files =~ ^(.*\(?[[:digit:]]{4}\)?)[\.[[:blank:]]]?(.+)$ ]]; then
    no_space=${BASH_REMATCH[1]// /.}
    uniq[$no_space]=1
    all_files+=("${BASH_REMATCH[0]}")
    first_part+=("${BASH_REMATCH[1]}")
  fi
done

for j in "${!uniq[@]}"; do
  mkdir -p "${j//[)(]}"
  dir+=("$j")
done

for i in "${!all_files[@]}"; do
  for k in "${dir[@]}"; do
  if [[ ${first_part[$i]// /.} == $k ]]; then
    mv -v  "${all_files[$i]}" "${k//[)(]}"
  fi
  done
done