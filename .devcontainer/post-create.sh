#!/usr/bin/env bash
set -euo pipefail

# 演習用の Tamarin スクリプトを取得
if [ ! -d tamarin_toy_protocol ]; then
  git clone https://github.com/benjaminkiesl/tamarin_toy_protocol.git
fi

# 動作確認（Maude のバージョンチェック等が行われる）
tamarin-prover test || true
