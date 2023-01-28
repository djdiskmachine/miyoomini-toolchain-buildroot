FROM debian:buster-slim
ENV DEBIAN_FRONTEND noninteractive

ENV TZ=Sweden/Stockholm
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get -y update && apt-get -y install \
	bc \
    build-essential \
	wget \
	cmake \
	cmake-curses-gui \
	make \
    bzip2 \
	unzip \
	rsync \
	libncurses5-dev \
	file

RUN mkdir -p /root/workspace
WORKDIR /root

COPY support .
RUN ./setup-buildroot.sh
RUN cat ./setup-buildroot-env.sh >> .bashrc

VOLUME /root/workspace
WORKDIR /root/workspace

CMD ["/bin/bash"]