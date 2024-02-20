FROM mongodb/atlas:v1.14.3 as base_image

LABEL maintainer "Jerry Kim"

RUN yum -y update
RUN yum -y install vim make mongodb-database-tools

WORKDIR /srv