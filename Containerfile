################################################################################
##################### File modified from original fork #########################
################################################################################

ARG IMAGE_NAME="${IMAGE_NAME:-kinoite}"
ARG SOURCE_IMAGE="${SOURCE_IMAGE:-kinoite}"
ARG BASE_IMAGE="quay.io/fedora-ostree-desktops/${SOURCE_IMAGE}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-37}"

FROM ${BASE_IMAGE}:${FEDORA_MAJOR_VERSION} AS builder

ARG IMAGE_NAME="${IMAGE_NAME}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION}"



ADD build.sh /tmp/
ADD packages.json /tmp/
RUN /tmp/build.sh

ADD flatpaks.txt /tmp/
ADD install-flatpaks.sh /tmp/
RUN /tmp/install-flatpaks.sh

RUN rm -rf /tmp/* /var/*
RUN ostree container commit
RUN mkdir -p /var/tmp && chmod -R 1777 /var/tmp