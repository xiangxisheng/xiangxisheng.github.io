@echo off
title www.xiangxisheng.cn - jekyll serve
cd /d %~dp0..
bundle exec jekyll serve --port 443 --host www.xiangxisheng.cn --ssl_cert _bat/xiangxisheng.cn.cer --ssl-key _bat/xiangxisheng.cn.key
pause
