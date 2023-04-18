FROM ubuntu

RUN useradd -ms /bin/bash -G sudo opauser && \
    passwd -d opauser && \
    apt-get update && \
    apt-get install -y opam curl sudo openjdk-8-jre m4 zlib1g-dev && \
    curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - && \
    sudo apt-get install -y nodejs

USER opauser
WORKDIR /home/opauser

RUN sudo echo

RUN opam init --auto-setup && \
    opam switch 4.02.1 && \
    opam install -y ocamlbuild ulex camlzip ocamlgraph camlp4 && \
    eval `opam config env` && \
    git clone https://github.com/MLstate/opalang --depth 1 && \
    cd opalang/ && \
    ./configure && \
    make && \
    sudo make install

RUN sudo npm install -g opabsl.opp intl-messageformat intl

# ENTRYPOINT opa
