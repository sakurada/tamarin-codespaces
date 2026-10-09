# Tamarin Prover on GitHub Codespaces

[Tamarin Prover](https://tamarin-prover.com/) を GitHub Codespaces で使うための環境です。
演習用スクリプトとして [benjaminkiesl/tamarin_toy_protocol](https://github.com/benjaminkiesl/tamarin_toy_protocol) を使います。

## 構成

| ファイル | 内容 |
| --- | --- |
| `.devcontainer/Dockerfile` | Ubuntu 24.04 + Tamarin 1.12.0 + Maude 3.5.1 + Graphviz |
| `.devcontainer/devcontainer.json` | Codespaces の設定（ポート 3001 を転送） |
| `.devcontainer/post-create.sh` | 作成時に `tamarin_toy_protocol` を clone し、`tamarin-prover test` を実行 |
| `prove.sh` | コマンドラインで全 lemma を自動証明 |
| `gui.sh` | 対話型 GUI（Web インターフェース）を起動 |

## 使い方

1. このディレクトリを GitHub リポジトリに push する
2. GitHub のリポジトリ画面で **Code → Codespaces → Create codespace on main**
3. 初回はコンテナのビルドに数分かかります

### コマンドラインで証明

```bash
./prove.sh                                            # toy protocol 全部
./prove.sh tamarin_toy_protocol/toy_protocol_1.spthy  # 1 ファイルだけ
```

### GUI で証明

```bash
./gui.sh
```

ポート 3001 が自動で転送され、ブラウザで Tamarin の GUI が開きます
（開かない場合は VS Code の「ポート」タブから 3001 の地球アイコンをクリック）。

## 補足

- Ubuntu の apt で入る Maude 3.2 は Tamarin が非対応のため、Maude 公式リリースのバイナリを使っています。
- バージョンは `Dockerfile` の `TAMARIN_VERSION` / `MAUDE_VERSION` で変更できます。
- `tamarin_toy_protocol/` は Codespace 作成時に clone するため `.gitignore` に入れています。
