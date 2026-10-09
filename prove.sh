#!/usr/bin/env bash
# 全 lemma を自動証明する
# 使い方: ./prove.sh [spthy ファイル ...]（省略時は toy protocol 全て）
set -euo pipefail
if [ "$#" -eq 0 ]; then
  set -- tamarin_toy_protocol/*.spthy
fi
for f in "$@"; do
  echo "=== $f ==="
  tamarin-prover --prove "$f" | sed -n '/^summary of summaries:/,$p'
done
