# icinga2

This repository contains the source for the [icinga2](https://www.icinga.org/icinga2/) [docker](https://www.docker.com) image.

It is only the client side. When used inside a priviledged container, you'll be able to monitor the whole machine with this image

This build is automated by push for the git-repo. Just crawl it via:

    docker pull bebehei/icinga2-client

## Image details

- icinga2 client image 

## Usage

    docker run --privileged bebehei/icinga2-client

## Environment variables Reference

| Environmental Variable | Default Value | Description |
| ---------------------- | ------------- | ----------- |
## Volume Reference

All these folders are configured and able to get mounted as volume. The bottom ones are not quite neccessary.

| Volume | ro/rw | Description & Usage |
| ------ | ----- | ------------------- |
| /etc/icinga2 | rw | Icinga2 configuration folder |
| /var/lib/icinga2 | rw | Icinga2 Data |
| /var/log/icinga2 | rw | logfolder for icinga2 (not neccessary) |
| /var/log/supervisor | rw | logfolder for supervisord (not neccessary) |
| /var/spool/icinga2 | rw | spool-folder for icinga2 (not neccessary) |
| /var/cache/icinga2 | rw | cache-folder for icinga2 (not neccessary) |
