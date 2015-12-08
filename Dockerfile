FROM ubuntu:14.04

MAINTAINER Rory McCune <rorym@mccune.org.uk>

#Java Install based on https://github.com/nimmis/docker-java/blob/master/oracle-8-jdk/Dockerfile

# disable interactive functions
ENV DEBIAN_FRONTEND noninteractive

# set default java environment variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle/

RUN apt-get update -y && \
	apt-get install -y software-properties-common

RUN add-apt-repository ppa:webupd8team/java -y && \
echo debconf shared/accepted-oracle-license-v1-1 select true |  debconf-set-selections && \
echo debconf shared/accepted-oracle-license-v1-1 seen true |  debconf-set-selections && \
apt-get update -y && \
apt-get install -y --no-install-recommends oracle-java8-installer && \
apt-get install -y --no-install-recommends oracle-java8-set-default && \
apt-get install -y libgtk2.0-0 libxtst6 && \
rm -rf /var/cache/oracle-jdk8-installer && \
apt-get --purge autoremove -y software-properties-common && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*

#Get Burp
RUN mkdir burp
WORKDIR /burp
RUN wget -q -O burpsuite.jar https://portswigger.net/DownloadUpdate.ashx?Product=Free


ENTRYPOINT ["java", "-jar", "/burp/burpsuite.jar"]
