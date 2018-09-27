FROM ubuntu:18.04
# FROM python:3.7
WORKDIR /root
# COPY ./opencv ./opencv
RUN apt update && apt upgrade -y
RUN apt install git build-essential cmake pkg-config libjpeg-dev python3-dev python3-numpy libpng-dev -y && apt clean
# RUN pip install numpy
RUN git clone https://github.com/opencv/opencv.git && cd opencv && git checkout 3.4.0 && mkdir /root/opencv/build
WORKDIR /root/opencv/build
RUN cmake -D BUILD_TIFF=OFF \
-D BUILD_opencv_java=OFF \
-D WITH_CUDA=OFF \
-D BUILD_TESTS=OFF \
-D BUILD_PERF_TESTS=OFF \
-D CMAKE_BUILD_TYPE=RELEASE \
-D INSTALL_C_EXAMPLES=OFF \
-D BUILD_EXAMPLES=OFF \
-D BUILD_DOCS=OFF ../ && make && make install

RUN /bin/bash -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf' && ldconfig && cd /root && rm -rf /root/opencv