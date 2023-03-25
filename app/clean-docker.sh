#!/bin/bash
#
#
docker stop $(docker ps) && docker rm $(docker ps)
docker image rm -f $(docker images)
#
#
exit 0
