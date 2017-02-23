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

| Environmental Variable | Default Value          | Description |
| ---------------------- | ---------------------- | ----------- |
| `ICINGA2_TICKET_SALT`  | *undefined*            | **required:** Container will stop without ticket-salt to process certificate request. |
| `ICINGA2_MASTER_HOST`  | mon                    | The hostname of icinga2
| `ICINGA2_MASTER_FQDN`  | *$ICINGA2_MASTER_HOST* | If your icinga2 master certs' FQDN does not match the hostname, define this in addition. If you set `ICINGA2_MASTER_HOST` correctly, you should not worry about this. |
| `ICINGA2_MASTER_PORT`  | 5665                   | Default port on the icinga2 master. |
| `ICINGA2_CLIENT_FQDN`  | *$(hostname --fqdn)*   | To request a certificate from your master, your requesting FQDN has to match the FQDN chained to your given ticket salt. If your hostname does not match the FQDN, defined this variable and set the value to the corresponding value of the master. |
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
