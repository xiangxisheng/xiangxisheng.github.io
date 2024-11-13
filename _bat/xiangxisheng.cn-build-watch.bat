@echo off
title xiangxisheng.cn - jekyll build --watch --incremental
cd /d %~dp0..
bundle exec jekyll build --watch --incremental
pause
