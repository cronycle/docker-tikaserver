# Based on https://github.com/LogicalSpark/docker-tikaserver/blob/master/Dockerfile
FROM ubuntu:16.04
MAINTAINER eugene@jetruby.com

ENV TIKA_VERSION 1.17
ENV TIKA_SERVER_URL https://archive.apache.org/dist/tika/tika-server-$TIKA_VERSION.jar

RUN	apt-get update \
	&& apt-get -y install openjdk-8-jre-headless curl gdal-bin tesseract-ocr \
		tesseract-ocr-eng tesseract-ocr-ita tesseract-ocr-fra tesseract-ocr-spa tesseract-ocr-deu \
	&& curl -sSL https://people.apache.org/keys/group/tika.asc -o /tmp/tika.asc \
	&& gpg --import /tmp/tika.asc \
	&& curl -sSL "$TIKA_SERVER_URL.asc" -o /tmp/tika-server-${TIKA_VERSION}.jar.asc \
	&& curl -sSL "$TIKA_SERVER_URL" -o /tika-server-${TIKA_VERSION}.jar \
	&& apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 9998
ENTRYPOINT java -jar /tika-server-${TIKA_VERSION}.jar -h 0.0.0.0 -enableUnsecureFeatures -enableFileUrl
