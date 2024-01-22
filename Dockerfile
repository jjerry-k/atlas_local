FROM mongodb/atlas:latest as base_image

LABEL maintainer "Jerry Kim"

RUN yum -y update
RUN yum -y install vim make mongodb-database-tools

WORKDIR /srv