#!/usr/bin/env bash

kill `pgrep waybar`
nohup waybar &
