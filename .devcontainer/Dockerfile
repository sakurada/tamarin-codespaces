# Debian 13 (trixie) ベースの Dev Container イメージ (amd64 / arm64 対応)
FROM mcr.microsoft.com/devcontainers/base:trixie

ARG TAMARIN_VERSION=1.12.0

# Tamarin は出力に非ASCII文字 (∃ や ¬ など) を含むため UTF-8 ロケールを指定
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

# 1. 依存パッケージ (Maude 3.4, Graphviz, GMP, zlib) とダウンロード用ツール
#    trixie の Maude 3.4 は Tamarin の対応バージョン
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
       maude graphviz libgmp10 zlib1g curl ca-certificates patchelf \
    && rm -rf /var/lib/apt/lists/*

# 2. GitHub リリースの Homebrew bottle (Linux 用) から Tamarin を取得
#    x86_64 / arm64 (aarch64) を自動判別する
#    bottle 内のバイナリはローダのパスが Homebrew 用のプレースホルダになっているため、
#    patchelf で Debian のローダに差し替える
RUN set -eux; \
    case "$(uname -m)" in \
        x86_64)  BOTTLE_ARCH=x86_64; LOADER=/lib64/ld-linux-x86-64.so.2 ;; \
        aarch64) BOTTLE_ARCH=arm64;  LOADER=/lib/ld-linux-aarch64.so.1 ;; \
        *) echo "Unsupported architecture: $(uname -m)" >&2; exit 1 ;; \
    esac; \
    mkdir -p /tmp/tamarin; \
    curl -fsSL "https://github.com/tamarin-prover/tamarin-prover/releases/download/${TAMARIN_VERSION}/tamarin-prover-${TAMARIN_VERSION}.${BOTTLE_ARCH}_linux.bottle.tar.gz" \
      | tar -xz -C /tmp/tamarin; \
    install -m 755 "/tmp/tamarin/tamarin-prover/${TAMARIN_VERSION}/bin/tamarin-prover" /usr/local/bin/tamarin-prover; \
    patchelf --set-interpreter "$LOADER" --remove-rpath /usr/local/bin/tamarin-prover; \
    rm -rf /tmp/tamarin; \
    tamarin-prover --version
