FROM python:3.11
WORKDIR /app
COPY . /app
RUN apt-get update && apt-get install -y \
    libgdal-dev \
    && rm -rf /var/lib/apt/lists/*
ENV GDAL_CONFIG=/usr/bin/gdal-config
ENV GDAL_VERSION=3.7.3
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install -r requirements.txt
CMD python ./app.py