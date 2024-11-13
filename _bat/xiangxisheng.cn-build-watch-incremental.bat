@echo off
title xiangxisheng.cn - jekyll build --watch --incremental
cd /d %~dp0..
start /b /wait bundle exec jekyll build --watch --incremental
pause
