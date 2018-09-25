FROM ubuntu:18.04
WORKDIR /root
COPY ./opencv ./opencv
# RUN git clone https://github.com/opencv/opencv.git --depth=1
RUN mkdir /root/opencv/build
RUN apt update && apt upgrade -y
RUN apt install git build-essential cmake pkg-config python3-dev python3-numpy libjpeg-dev libpng-dev -y && apt clean
WORKDIR /root/opencv/build
RUN cmake cmake -D INSTALL_C_EXAMPLES=OFF -D BUILD_EXAMPLES=OFF -D BUILD_DOCS=OFF ../ && make && make install
RUN /bin/bash -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf' && ldconfig
