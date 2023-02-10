#!/usr/bin/env sh

docker build -f Dockerfile -t talentpitchv2-php74op . --platform linux/amd64;
docker tag talentpitchv2-php74op paulpwo/talentpitchv2-php74op:amd64;
docker push  paulpwo/talentpitchv2-php74op:amd64;
