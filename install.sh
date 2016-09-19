#!/bin/sh

cp -rf extra $1/package
cp -rf luci/* $1/feeds/luci/applications
cp -rf theme/* $1/feeds/luci/themes
