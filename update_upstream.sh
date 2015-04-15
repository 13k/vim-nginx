#!/bin/bash

if ! which hg > /dev/null 2>&1; then
  echo "hg is required"
  exit 1
fi

nginx_repository="http://hg.nginx.org/nginx"
checkout_dir=".nginx"
rev_file="REVISION"

if [[ ! -d "$checkout_dir" ]]; then
  hg clone "$nginx_repository" "$checkout_dir"
else
  hg -R "$checkout_dir" revert -a
  hg -R "$checkout_dir" update tip
fi

cp -af "$checkout_dir/contrib/vim"/* .
hg -R "$checkout_dir" identify > "$rev_file"
