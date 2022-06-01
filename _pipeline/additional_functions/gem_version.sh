#!/bin/bash

function gem_version {
  GEMSPEC=$1

  ruby -e "puts eval(File.read('$GEMSPEC'), TOPLEVEL_BINDING).version.to_s"
}
