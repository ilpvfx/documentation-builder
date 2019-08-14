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
  && pip3 install --upgrade pip \
  && pip3 install virtualenv Sphinx==1.8.4 sphinx-rtd-theme==0.4.1 matplotlib==2.2.3 docopt==0.6.2 breathe==4.10.0 sphinx-js==2.7 \
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
