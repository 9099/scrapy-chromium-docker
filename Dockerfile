# Python support can be specified down to the minor or micro version
# (e.g. 3.6 or 3.6.3).
# OS Support also exists for jessie & stretch (slim and full).
# See https://hub.docker.com/r/library/python/ for all supported Python
# tags from Docker Hub.
FROM python:alpine

# If you prefer miniconda:
#FROM continuumio/miniconda3

LABEL Name=scrapy-chromium Version=0.0.1

ENV USER=chromium
ENV GROUP=chromium

WORKDIR /app
VOLUME [ "/app" ]
RUN apk add --no-cache gcc musl-dev libffi-dev openssl-dev libxml2-dev libxslt-dev\
    && apk add --no-cache chromium chromium-chromedriver\
    && rm -rf /var/cache/apk/*
RUN python3 -m pip install selenium==3.141.0 Twisted==18.9.0 scrapy==1.6.0
RUN addgroup  $USER && adduser --disabled-password $USER -G $GROUP 

USER $USER

CMD [ "python3" ]