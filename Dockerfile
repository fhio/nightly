FROM debian:stretch-slim                                            
MAINTAINER jerome <jerome@jerome.cc>

ENV DEBIAN_FRONTEND=noninteractive \
    DEBEMAIL="Jerome Pinguet <jerome@jerome.cc>"


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

RUN apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages --no-install-recommends \
        ca-certificates

RUN apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages --no-install-recommends \
        devscripts

RUN apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages --no-install-recommends \
        vim

RUN apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages --no-install-recommends \
        fakeroot \
        libdistro-info-perl

RUN apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages --no-install-recommends \
        libopencv-core-dev \
        libopencv-highgui-dev \
        libopencv-objdetect-dev \
        libdistro-info-perl \
        libquazip5-dev \
        libquazip5-headers \
        libquazip5-1 \
        libqt5xmlpatterns5-dev

ARG VERSION

WORKDIR /opt/git

RUN git clone https://github.com/FreeHealth/freehealth.git

RUN mkdir /opt/build

RUN chmod +x /opt/git/freehealth/scripts/source.sh

RUN /opt/git/freehealth/scripts/source.sh -p /opt/build

WORKDIR /opt/build

RUN tar xvzf /opt/build/*

RUN PROJECT_VERSION=`cat /opt/git/freehealth/buildspecs/projectversion.pri | grep "PACKAGE_VERSION" | cut -d = -s -f2 | tr -d ' '` && \
    git clone https://github.com/FreeHealth/debian.git /opt/build/freehealth-$PROJECT_VERSION/debian && \
    COMMIT=`git -C /opt/git/freehealth/ rev-parse HEAD` && \
    cd /opt/build/freehealth-$PROJECT_VERSION/debian && \
    dch -v ${PROJECT_VERSION}-1 '${COMMIT}' && \
    dch -r --distribution unstable ignored && \
    debuild -us -uc

#RUN qmake freehealth.pro -Wall -r "CONFIG+=debug debug_without_install"

#RUN make
