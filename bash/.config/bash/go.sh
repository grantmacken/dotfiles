#!/bin/bash

GO_HOME="${HOME}/go"

if [[ ! "$PATH" == *$GO_HOME/bin* ]]; then
  export PATH="$PATH:$GO_HOME/bin"
fi
