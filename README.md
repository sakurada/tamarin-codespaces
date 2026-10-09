# Tamarin Prover on GitHub Codespaces

[Tamarin Prover](https://tamarin-prover.com/) を GitHub Codespaces で使うための環境です。
演習用スクリプトとして [benjaminkiesl/tamarin_toy_protocol](https://github.com/benjaminkiesl/tamarin_toy_protocol) を使います。

## 構成

| ファイル | 内容 |
| --- | --- |
| `.devcontainer/Dockerfile` | Ubuntu 24.04 + Tamarin 1.12.0 + Maude 3.5.1 + Graphviz |
| `.devcontainer/devcontainer.json` | Codespaces の設定（ポート 3001 を転送） |
| `.devcontainer/post-create.sh` | 作成時に `tamarin_toy_protocol` を clone し、`tamarin-prover test` を実行 |

## 使い方

1. このリポジトリの画面で **Code → Codespaces → Create codespace on main**
2. 初回はコンテナのビルドに数分かかります
3. 起動後、ターミナルで以下のコマンドを実行します

### コマンドラインで証明

`--prove` を付けると、ファイル内の全 lemma を自動で証明します。

```bash
tamarin-prover --prove tamarin_toy_protocol/toy_protocol_1.spthy
```

特定の lemma だけ証明する場合は `--prove=<lemma名>` を指定します。

```bash
tamarin-prover --prove=sk_secret_b tamarin_toy_protocol/toy_protocol_1.spthy
```

### GUI で証明

```bash
tamarin-prover interactive --interface='*4' tamarin_toy_protocol
```

`--interface='*4'` は Codespaces のポート転送で GUI にアクセスするために必要です
（指定しないと 127.0.0.1 でしか待ち受けないため、ブラウザから開けません）。
ポート 3001 が自動で転送され、ブラウザで Tamarin の GUI が開きます
（開かない場合は VS Code の「ポート」タブから 3001 の地球アイコンをクリック）。
終了は `Ctrl+C` です。

## 補足

- Ubuntu の apt で入る Maude 3.2 は Tamarin が非対応のため、Maude 公式リリースのバイナリを使っています。
- バージョンは `Dockerfile` の `TAMARIN_VERSION` / `MAUDE_VERSION` で変更できます。
- `tamarin_toy_protocol/` は Codespace 作成時に clone するため `.gitignore` に入れています。
