#!/bin/bash

CARGO_HOME="${HOME}/.cargo"

if [[ ! "$PATH" == *$CARGO_HOME/bin* ]]; then
  export PATH="$PATH:$CARGO_HOME/bin"
fi
