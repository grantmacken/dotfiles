#!/usr/bin/env bash
set -oue pipefail

printf "%b\n" "Normal"
printf "%b\n" "\033[1mBold\033[22m"
printf "%b\n" "\033[3mItalic\033[23m"
printf "%b\n" "\033[3;1mBold Italic\033[0m"
printf "%b\n" "\033[4mUnderline\033[24m"
printf "%b\n" "== === !== >= <= =>"
printf "%b\n" "契          勒 鈴 "
