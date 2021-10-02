#!/usr/bin/env bash

shopt -s extglob

target="release"

[[ -d $target ]] && rm -rf "$target"
mkdir "$target"

common="/unsafe \
/optimize \
/platform:anycpu \
/target:winexe \
/out:\"release/deoldify.exe\" \
/r:System.Drawing.dll \
/r:System.Windows.Forms.dll"

src="$(echo src/*.cs)"

resources="$(echo src/resources/*.@(jpg|png|hmodel) | tr ' ' '\n' | sed -E 's/^/\/resource:/')"

csc $common $resources $src

read -rn 1
