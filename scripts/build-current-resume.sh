#!/usr/bin/env bash
set -euo pipefail

doc_path="${1:?root tex path is required}"
preview_dir="${2:?preview output directory is required}"
preview_name="${3:?preview pdf name is required}"
workspace="${4:?workspace path is required}"

case "$doc_path" in
  "$workspace"/*) rel_path="${doc_path#"$workspace"/}" ;;
  *) rel_path="$doc_path" ;;
esac

rel_path="${rel_path#./}"
rel_path="${rel_path%.tex}"
rel_path="${rel_path#versions/}"
target="$(printf '%s' "$rel_path" | tr '/' '-')"

case "$target" in
  zh_CN-*|en_US-*) ;;
  *)
    echo "Open a resume entry under versions/ before building: $doc_path" >&2
    exit 2
    ;;
esac

make "$target"
mkdir -p "$preview_dir"
cp "dist/$target.pdf" "$preview_dir/$preview_name.pdf"
