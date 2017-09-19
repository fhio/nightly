FROM debian:stretch-slim                                            
MAINTAINER jerome <jerome@jerome.cc>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update                                                              
RUN apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages --no-install-recommends \
        build-essential


RUN apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages --no-install-recommends \
        qt5-qmake

RUN apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages --no-install-recommends \
        libqt5core5a

RUN apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages --no-install-recommends \
        qt5-default

RUN apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages --no-install-recommends \
        libqt5svg5-dev 


RUN apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages --no-install-recommends \
        qtscript5-dev 

RUN apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages --no-install-recommends \
        qttools5-dev 

RUN apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages --no-install-recommends \
        zlib1g-dev 

RUN apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages --no-install-recommends \
        qtxmlpatterns5-dev-tools 

RUN apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages --no-install-recommends \
        git 

ARG version

WORKDIR /opt/git

RUN git clone https://github.com/FreeHealth/freehealth.git

RUN mkdir /opt/build

RUN /git/freehealth/scripts/source.sh -p /opt/build

WORKDIR /opt/build

RUN tar xvzf /opt/build/*

RUN PROJECT_VERSION=`cat $SOURCES_ROOT_PATH/buildspecs/projectversion.pri | grep "PACKAGE_VERSION" | cut -d = -s -f2 | tr -d ' '` && \
    git clone https://github.com/FreeHealth/debian.git /opt/build/freehealth-$PROJECT_VERSION/debian

#RUN qmake freehealth.pro -Wall -r "CONFIG+=debug debug_without_install"

#RUN make
