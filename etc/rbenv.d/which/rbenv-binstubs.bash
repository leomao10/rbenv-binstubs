#!/usr/bin/env bash

check_for_binstubs()
{
  local root
  root="$PWD"
  while [ -n "$root" ]; do
    if [ -e "$root/Gemfile" ]; then
      local bin_file=$(ruby -e 'require "rubygems";require "bundler"; puts Bundler.bin_path if Bundler.respond_to?(:bin_path);')
      if [ -d "$bin_file" ] && [ -x "$bin_file/$RBENV_COMMAND" ]; then
  RBENV_COMMAND_PATH="$bin_file/$RBENV_COMMAND"
      fi
      root=""
    fi
    root="${root%/*}"
  done
}

if [ -z "$DISABLE_BINSTUBS" ]; then
  check_for_binstubs
fi