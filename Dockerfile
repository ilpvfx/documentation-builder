FROM alpine:3.7

RUN mkdir /tmp/install-tl-unx
WORKDIR /tmp/install-tl-unx
COPY texlive.profile .

RUN apk add --update \
    python-dev \
    python3 \
    python3-dev \
    py-pip \ 
    build-base \
    openjdk8-jre \
    perl \
    xz \
    wget \
    libpng-dev \
    freetype-dev \
  && rm -rf /var/cache/apk/* \
  && pip2 install --upgrade pip \
  && pip3 install --upgrade pip \
  && pip2 install virtualenv sphinx sphinx-rtd-theme sphinx-js numpy \
  && pip3 install virtualenv sphinx sphinx-rtd-theme breathe sphinx-js matplotlib numpy \
  && wget http://ftp.acc.umu.se/mirror/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz \
  && tar --strip-components=1 -xvf install-tl-unx.tar.gz \
  && ./install-tl --repository http://ftp.acc.umu.se/mirror/CTAN/systems/texlive/tlnet/ --profile=texlive.profile \
  && /usr/local/texlive/2019/bin/x86_64-linuxmusl/tlmgr install collection-latex collection-latexextra latexmk collection-fontsrecommended lato \
  && cd /tmp && rm -rf *

ENV PATH="/usr/local/texlive/2019/bin/x86_64-linuxmusl:${PATH}"

COPY plantuml plantuml.jar /usr/local/bin/
RUN chmod +x /usr/local/bin/plantuml
WORKDIR /workdir

VOLUME ["/workdir"]
