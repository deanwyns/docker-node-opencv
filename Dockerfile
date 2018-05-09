FROM node:8-alpine

RUN echo -e '@edgunity http://nl.alpinelinux.org/alpine/edge/community\n@edge http://nl.alpinelinux.org/alpine/edge/main\n@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories

RUN apk update && apk upgrade && apk add --upgrade apk-tools@edge

RUN apk add --update \
  make \
  cmake \
  gcc \
  g++ \
  git \
  pkgconf \
  unzip \
  wget \
  build-base \
  gsl \
  libavc1394-dev \
  libtbb@testing \
  libtbb-dev@testing \
  libjpeg \
  libjpeg-turbo-dev \
  libpng-dev \
  jasper \
  libdc1394-dev \
  clang-dev \
  clang \
  tiff-dev \
  libwebp-dev \
  openblas-dev@edgunity \
  linux-headers \
  python-dev \
  vips-dev@testing \
  fftw-dev@testing
  
ENV CC /usr/bin/clang
ENV CXX /usr/bin/clang++

RUN cd /opt && \
  wget https://github.com/opencv/opencv/archive/3.4.1.zip && \
  unzip 3.4.1.zip && \
  cd /opt/opencv-3.4.1 && \
  mkdir build && \
  cd build && \
  cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_FFMPEG=NO \
  -D WITH_IPP=NO -D WITH_OPENEXR=NO .. && \
  make VERBOSE=1 && \
  make && \
  make install

RUN apk del \
  build-base \
  clang \
  clang-dev \
  cmake \
  git \
  pkgconf \
  wget \
  libtbb-dev \
  libjpeg-turbo-dev \
  libpng-dev \
  tiff-dev \
  jasper \
  python-dev \
  py-numpy-dev

RUN rm -rf /var/cache/apk/*