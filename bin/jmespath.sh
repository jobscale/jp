#!/usr/bin/env bash
set -u

setArch() {
  UNAME=$(uname)
  UNAME=${UNAME,,}
  ARCH=$(uname -m)
  [[ "$ARCH" == x86_64 ]] && ARCH=amd64
}
setArch
JP_FNAME="jp-${UNAME}-${ARCH}"

installJmespath() {
  [[ ! -d "$HOME/.bin" ]] && mkdir "$HOME/.bin"
  curl -fsSLo "$HOME/.bin/${JP_FNAME}" "https://github.com/jmespath/jp/releases/download/$(
    git ls-remote --refs --tags https://github.com/jmespath/jp.git | sort -t '/' -k 3 -V | tail -1 | awk -F/ '{print $3}'
  )/${JP_FNAME}"
  chmod +x "$HOME/.bin/${JP_FNAME}"
}

[[ ! -x "$HOME/.bin/${JP_FNAME}" ]] && installJmespath

"$HOME/.bin/${JP_FNAME}" $@
