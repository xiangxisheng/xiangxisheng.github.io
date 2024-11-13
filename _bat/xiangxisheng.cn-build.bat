@echo off
title xiangxisheng.cn - jekyll build
cd /d %~dp0..
start /b /wait bundle exec jekyll build
pause
