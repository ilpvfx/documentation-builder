FROM alpine:3.7

RUN mkdir /tmp/install-tl-unx
WORKDIR /tmp/install-tl-unx
COPY texlive.profile .

RUN apk add --update \
    python3 \
    python3-dev \
    py-pip \ 
    build-base \
    openjdk8-jre \
    perl \
    xz \
    wget \
  && pip2 install --upgrade pip \
  && pip3 install --upgrade pip \
  && pip2 install virtualenv \
  && pip3 install virtualenv \
  && pip2 install sphinx \
  && pip3 install sphinx \
  && rm -rf /var/cache/apk/* \
  && wget http://ftp.acc.umu.se/mirror/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz \
  && tar --strip-components=1 -xvf install-tl-unx.tar.gz \
  && ./install-tl --repository http://ftp.acc.umu.se/mirror/CTAN/systems/texlive/tlnet/ --profile=texlive.profile \
  && /usr/local/texlive/2019/bin/x86_64-linuxmusl/tlmgr install collection-latex collection-latexextra \
  && cd /tmp && rm -rf *

ENV PATH="/usr/local/texlive/2019/bin/x86_64-linuxmusl:${PATH}"

COPY plantuml plantuml.jar /usr/local/bin/
RUN chmod +x /usr/local/bin/plantuml
WORKDIR /workdir

VOLUME ["/workdir"]