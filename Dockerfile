FROM ubuntu:18.04
WORKDIR /root
# COPY ./opencv ./opencv
RUN apt update && apt upgrade -y
RUN apt install git build-essential cmake pkg-config python3-dev python3-numpy libjpeg-dev libpng-dev -y && apt clean
RUN git clone https://github.com/opencv/opencv.git && cd opencv && git checkout 3.4.0 && mkdir /root/opencv/build
WORKDIR /root/opencv/build
RUN cmake cmake -D INSTALL_C_EXAMPLES=OFF -D BUILD_EXAMPLES=OFF -D BUILD_DOCS=OFF ../ && make && make install
RUN /bin/bash -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf' && ldconfig && rm -rf /root/opencv
