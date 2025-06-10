---
layout: post
categories: network
slug: mysql-dump
title: MySQL导出所有数据
date: 2025-06-10 19:33:00 +07:00
---
```
@echo off
set dumpfile=mysqldump-10.52.35.230-all.sql
title %dumpfile%
mysqldump --version
mysqldump --force --set-gtid-purged=OFF --default-character-set=utf8mb4 -h10.52.35.230 -uadm -p --all-databases --triggers --routines --events --single-transaction > %dumpfile%
pause
```
