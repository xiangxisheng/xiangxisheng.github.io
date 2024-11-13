@echo off
title xiangxisheng.cn - jekyll build --watch
cd /d %~dp0..
start /b /wait bundle exec jekyll build --watch
pause
