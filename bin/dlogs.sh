#!/usr/bin/env bash

docker logs -ft "$1" 2>&1 | lnav

