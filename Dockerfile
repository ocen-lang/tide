FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update
RUN apt-get install -y git valgrind

ENTRYPOINT git clone https://github.com/ocen-lang/ocen /ocen/ \
    && cd /ocen/ \
    && mkdir build \
    && gcc bootstrap/stage0.c -o build/stage1 \
    && ./build/stage1 -d compiler/main.oc -o bootstrap/ocen \
    && cd /mnt/ \
    && exec bash

ENV OCEN_ROOT=/ocen/
ENV PATH=$PATH:/ocen/bootstrap/

### Usage
## Build the image
# docker build . --tag tide
## Run the image
# docker run --rm -it -v $(pwd):/mnt/ -w /mnt/ tide