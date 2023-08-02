#!/usr/bin/env bash

cd $(dirname $0)

cp ../home_manager/* ~/.config/home-manager/
home-manager switch

