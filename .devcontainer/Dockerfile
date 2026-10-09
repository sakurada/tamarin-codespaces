FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

ARG TAMARIN_VERSION=1.12.0
ARG MAUDE_VERSION=3.5.1

# Tamarin は UTF-8 の記号（∃ など）を出力するため UTF-8 ロケールにする
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

# グラフ描画用の Graphviz
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
       graphviz ca-certificates curl unzip \
    && rm -rf /var/lib/apt/lists/*

# Maude（apt 版の 3.2 は Tamarin 非対応のため公式バイナリを使う）
RUN curl -fsSL -o /tmp/maude.zip \
      "https://github.com/maude-lang/Maude/releases/download/Maude${MAUDE_VERSION}/Maude-${MAUDE_VERSION}-linux-x86_64.zip" \
    && mkdir -p /opt/maude \
    && unzip -q /tmp/maude.zip -d /opt/maude \
    && chmod +x /opt/maude/maude \
    && ln -s /opt/maude/maude /usr/local/bin/maude \
    && rm /tmp/maude.zip
ENV MAUDE_LIB=/opt/maude

# Tamarin prover 本体（公式リリースのビルド済みバイナリ）
RUN curl -fsSL "https://github.com/tamarin-prover/tamarin-prover/releases/download/${TAMARIN_VERSION}/tamarin-prover-${TAMARIN_VERSION}-linux64-ubuntu.tar.gz" \
      | tar -xz -C /usr/local/bin tamarin-prover \
    && chmod +x /usr/local/bin/tamarin-prover
