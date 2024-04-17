#!/usr/bin/env bash

date +'%_I:%_M%P' | awk '{$1=$1};1' | tr -d '\n'
