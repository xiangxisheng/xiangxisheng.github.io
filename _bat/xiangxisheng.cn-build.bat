@echo off
title xiangxisheng.cn - jekyll build --incremental
cd /d %~dp0..
bundle exec jekyll build --incremental
pause
