FROM ubuntu:bionic

RUN apt-get update --yes && apt-get dist-upgrade --yes \
    && apt-get install --yes --no-install-recommends curl gnupg ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY src/llvm.list /etc/apt/sources.list.d/llvm.list
RUN curl --fail --show-error --silent --location https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -

RUN apt-get update --yes && apt-get dist-upgrade --yes \
    && apt-get install --yes --no-install-recommends clang-7 lld-7 \
    && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-7 1 && clang --version
RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-7 1 && clang++ --version
RUN update-alternatives --install /usr/bin/ld ld /usr/bin/lld-7 1 && ld --version

ENV CC clang
ENV CXX clang++
