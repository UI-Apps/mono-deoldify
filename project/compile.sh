#!/usr/bin/env bash

shopt -s extglob

target="release"

[[ -d $target ]] && rm -rf "$target"
mkdir "$target"

common=(/unsafe
    /optimize
    /platform:anycpu
    /target:exe \
    /out:release/deoldify.exe
    /r:System.Drawing.dll
    /r:System.Windows.Forms.dll)

for f in src/*.cs; do
    src+=("$f")
done

for r in src/resources/*.@(jpg|png|hmodel); do
    resources+=("$(echo "$r" | sed -E 's/^/\/resource:/')")
done

mcs "${common[@]}" "${resources[@]}" "${src[@]}"
