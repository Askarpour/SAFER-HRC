FROM deibpolimi/zot
MAINTAINER Mehrnoosh Askarpour <mehrnoosh.askarpour@polimi.it>
ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="Politecnico di Milano" \
      org.label-schema.name="zot" \
      org.label-schema.version="HEAD" \
      org.label-schema.vcs-type="git" \
      org.label-schema.vcs-url="https://github.com/fm-polimi/zot" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0"

# Setting the environment
ENV USERHOME  /root
ENV DEBIAN_FRONTEND noninteractive
ENV USER root
ENV Z3_VERSION 4.5.0
ENV TMP_BUILD_DEPS ca-certificates \
	   gcc \
	   g++ \
	   make \
       unzip

ADD . /
WORKDIR /tmp
# Update the repos and install all the used packages
RUN apt-get -q update && apt-get install -y --no-install-recommends \
    $TMP_BUILD_DEPS \
    libgomp1 \
    sbcl \
    zlib1g-dev \
    python \
    python-dev \
    python-distribute \
    python-pip \ 
    python-tk \
    zlib1g-dev \
# dependencies needed for matplotlib
     apt-get build-dep -y --force-yes python-matplotlib && \
    && rm -rf /var/lib/apt/lists/* \  
# install python libs
    && pip install matplotlib \
    && pip install prettytable \
    && pip install numpy \
    && pip install termcolor \
    && pip install tables \
# remove build deps
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false $TMP_BUILD_DEPS \
    && rm -rf /tmp