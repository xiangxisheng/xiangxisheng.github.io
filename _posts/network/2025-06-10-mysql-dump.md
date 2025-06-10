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


```
function Read-Input([string]$prompt, [string]$default) {
    Write-Host "$prompt [$default]:" -NoNewline
    $input = Read-Host
    if ([string]::IsNullOrWhiteSpace($input)) {
        return $default
    } else {
        return $input
    }
}

function Read-Password() {
    $passSecure = Read-Host "请输入密码" -AsSecureString
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($passSecure)
    $plainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
    return $plainPassword
}

# 主程序开始

$mysqlHost = Read-Input "请输入MySQL主机" "10.52.35.230"
$mysqlPort = Read-Input "请输入MySQL端口" "3306"
$mysqlUser = Read-Input "请输入用户名" "adm"
$mysqlPass = Read-Password
$mysqlParams = @(
    "-h", $mysqlHost,
    "-P", $mysqlPort,
    "-u", $mysqlUser,
    "--password=$mysqlPass"
)
$mysqldumpOptions = @(
    "--force",
    "--set-gtid-purged=OFF",
    "--default-character-set=utf8mb4",
    "--triggers",
    "--routines",
    "--events",
    "--single-transaction"
)
# 获取数据库列表
try {
    $databases = & ./mysql @mysqlParams --password="$mysqlPass" -N -e "SHOW DATABASES;" 2>$null
    if (-not $databases) {
        Write-Host "连接失败或未获取到数据库列表，请检查参数和权限。"
        exit 1
    }
} catch {
    Write-Host "? 执行失败：$_"
    exit 1
}

# 过滤系统数据库
$systemDbs = @()
$databases = $databases | Where-Object { $systemDbs -notcontains $_ }

$outputFolder = Read-Input "请输入导出文件夹" ".\databases"
if (-not (Test-Path -Path $outputFolder)) {
    New-Item -ItemType Directory -Path $outputFolder | Out-Null
}

# 逐个导出数据库
foreach ($db in $databases) {
    Write-Host "开始导出数据库：$db ..."
    $dumpFile = "$outputFolder\$db.sql"
	$errFile = "$outputFolder\$db.log"
	$arguments = @()
	$arguments += $mysqlParams
	$arguments += $mysqldumpOptions
	$arguments += $db
	Start-Process -FilePath ./mysqldump -ArgumentList $arguments -NoNewWindow -Wait -RedirectStandardOutput $dumpFile -RedirectStandardError $errFile
    if ($LASTEXITCODE -eq 0) {
        Write-Host "成功导出 $dumpFile"
    } else {
        Write-Host "导出 $db 失败"
    }
}

Write-Host "全部数据库导出完成。"
# 按任意键退出
Write-Host "`n按任意键退出..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
```
