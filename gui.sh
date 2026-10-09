#!/usr/bin/env bash
# Tamarin の対話型 GUI を起動する（ポート 3001 がブラウザに転送される）
# 使い方: ./gui.sh [spthy ファイルのあるディレクトリ]
set -euo pipefail
DIR="${1:-tamarin_toy_protocol}"
exec tamarin-prover interactive --interface='*4' --port=3001 "$DIR"
