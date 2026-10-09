# Tamarin Prover on GitHub Codespaces

[Tamarin Prover](https://tamarin-prover.com/) を GitHub Codespaces で使うための環境です。
演習用スクリプトとして [benjaminkiesl/tamarin_toy_protocol](https://github.com/benjaminkiesl/tamarin_toy_protocol) を使います。

## 構成

| ファイル | 内容 |
| --- | --- |
| `.devcontainer/Dockerfile` | Debian 13 (trixie) + Tamarin 1.12.0 + Maude 3.4 + Graphviz（amd64 / arm64 対応） |
| `.devcontainer/devcontainer.json` | Codespaces の設定（ポート 3001 を転送） |

## 使い方

1. このリポジトリの画面で **Code → Codespaces → Create codespace on main**
2. 初回はコンテナのビルドに数分かかります
3. 起動後、ターミナルで以下のコマンドを実行します

### インストールの確認

```bash
tamarin-prover test
```

最後に `All tests successful.` と表示されれば OK です。

### 演習用スクリプトの取得

```bash
git clone https://github.com/benjaminkiesl/tamarin_toy_protocol.git
```

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

## 手元の Mac / Windows で使う場合

Docker Desktop と VS Code の [Dev Containers 拡張](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) があれば、
このリポジトリを clone して VS Code で開き、**Reopen in Container** を選ぶと同じ環境が使えます。
Intel / AMD (x86_64) と Apple Silicon (arm64) のどちらでもネイティブに動きます。

## 補足

- Tamarin は公式リリースの Homebrew bottle (Linux 用) を使い、`patchelf` で Debian のローダを使うように書き換えています。
  x86_64 / arm64 はビルド時に自動判別します。
- Maude は Debian trixie の apt パッケージ (3.4) を使っています。
- Tamarin のバージョンは `Dockerfile` の `TAMARIN_VERSION` で変更できます。
- `tamarin_toy_protocol/` は各自で clone するものなので `.gitignore` に入れています。
