#!/usr/bin/env sh

docker build -f Dockerfile -t talentpitchv2-php74 . --platform linux/amd64;
docker tag talentpitchv2-php74 paulpwo/talentpitchv2-php74:amd64;
docker push  paulpwo/talentpitchv2-php74:amd64;
