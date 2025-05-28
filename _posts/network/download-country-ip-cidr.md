---
layout: post
categories: network
filename: download-country-ip-cidr
name: download-country-ip-cidr
title: 下载某个国家所有的IP地址CIDR
date: 2025-05-28 20:42:00 +07:00
---
一般需要限制某个国家访问时需要的一个IP地址列表\
首先下载免费数据库https://db-ip.com/db/lite.php

第一步：按国家拆分 IP 范围文件
```
<?php

$inputFile = 'dbip/dbip-country-lite-2025-05.csv';
$inputFile = 'dbip/ip2country-v4.tsv';
$tmpDir = __DIR__ . '/country-ipv4-range';

if (!is_dir($tmpDir)) mkdir($tmpDir);

// 把 IP 范围按国家写入临时文件
$fp = fopen($inputFile, 'r');
while (($line = fgets($fp)) !== false) {
	$line = trim($line);
	if ($line === '' || str_starts_with($line, 'ip_start')) continue;

	[$startIp, $endIp, $country] = str_getcsv($line);
	if (!filter_var($startIp, FILTER_VALIDATE_IP) || !filter_var($endIp, FILTER_VALIDATE_IP)) continue;

	if (!filter_var($startIp, FILTER_VALIDATE_IP, FILTER_FLAG_IPV4) || 
    !filter_var($endIp, FILTER_VALIDATE_IP, FILTER_FLAG_IPV4)) continue;

	$file = "$tmpDir/$country.txt";
	file_put_contents($file, "$startIp,$endIp\n", FILE_APPEND);
}
fclose($fp);
echo "阶段一完成：已按国家拆分 IP 范围文件。\n";
```

第二步：处理IP数据，用最少的CIDR数量表示该国家的所有IP
```
<?php

function ipToLong($ip) {
	return sprintf('%u', ip2long($ip));
}

// Correct algorithm for finding largest possible CIDR blocks
function rangeToCidrs($startIp, $endIp) {
	$start = ipToLong($startIp);
	$end = ipToLong($endIp);
	$result = [];
	
	if ($start === false || $end === false || $start > $end) {
		error_log("Invalid IP range: $startIp - $endIp");
		return $result;
	}
	
	while ($start <= $end) {
		// Find the size of the largest block that fits
		$prefix = 32;
		$bit = 0;
		
		// Find how many bits we can include
		while ($bit < 32) {
			// Try to flip this bit to 1
			$mask = 1 << $bit;
			$next_start = $start | $mask;
			
			// If flipping makes it greater than end or changes the network portion
			if ($next_start > $end || ($start & $mask) != 0) {
				break;
			}
			
			$bit++;
		}
		
		// Calculate the prefix length
		$max_size = $bit;
		$mask_length = 32 - $max_size;
		
		// Find the correct prefix based on network alignment
		for ($i = 0; $i <= $max_size; $i++) {
			$mask = ~((1 << $i) - 1) & 0xFFFFFFFF;
			
			// If the start address is aligned on this prefix boundary
			if (($start & $mask) == $start) {
				$mask_length = 32 - $i;
			} else {
				break;
			}
		}
		
		// Add the CIDR notation
		$result[] = long2ip($start) . "/$mask_length";
		
		// Move to the next address block
		$start += 1 << (32 - $mask_length);
	}
	
	return $result;
}

// Compare function for sorting CIDR blocks numerically
function compareCidr($a, $b) {
	// Extract IP and prefix from CIDR notation
	list($ipA, $prefixA) = explode('/', $a);
	list($ipB, $prefixB) = explode('/', $b);
	
	// Convert IPs to long integers for numeric comparison
	$ipALong = ipToLong($ipA);
	$ipBLong = ipToLong($ipB);
	
	// First compare by IP address
	if ($ipALong != $ipBLong) {
		return $ipALong - $ipBLong;
	}
	
	// If same IP, compare by prefix length
	return $prefixA - $prefixB;
}

// Only execute main code if this file is directly called
if (basename($_SERVER['SCRIPT_FILENAME']) == basename(__FILE__)) {
	$tmpDir = __DIR__ . '/country-ipv4-range';
	$outDir = __DIR__ . '/country-ipv4-cidr';
	
	// Check if source directory exists
	if (!is_dir($tmpDir)) {
		die("Error: Source directory not found: $tmpDir\n");
	}
	
	// Create output directory if it doesn't exist
	if (!is_dir($outDir)) {
		if (!mkdir($outDir, 0755, true)) {
			die("Error: Failed to create output directory: $outDir\n");
		}
	}
	
	$fileCount = 0;
	$files = glob("$tmpDir/*.txt");
	if (empty($files)) {
		die("Error: No input files found in $tmpDir\n");
	}
	
	foreach ($files as $filePath) {
		$country = basename($filePath, '.txt');
		$cidrs = [];
	
		// Check if file is readable
		if (!is_readable($filePath)) {
			echo "Warning: Cannot read file $filePath, skipping...\n";
			continue;
		}
	
		$fp = fopen($filePath, 'r');
		if ($fp === false) {
			echo "Warning: Could not open file $filePath, skipping...\n";
			continue;
		}
	
		while (($line = fgets($fp)) !== false) {
			$line = trim($line);
			if (empty($line)) continue;
			
			$parts = explode(',', $line);
			if (count($parts) < 2) {
				error_log("Invalid line format in $filePath: $line");
				continue;
			}
			
			[$startIp, $endIp] = $parts;
			$cidrs = array_merge($cidrs, rangeToCidrs($startIp, $endIp));
		}
		fclose($fp);
	
		// Remove duplicates
		$cidrs = array_unique($cidrs);
		
		// Sort CIDRs numerically instead of lexicographically
		usort($cidrs, 'compareCidr');
	
		// Write output file
		if (file_put_contents("$outDir/$country.txt", implode("\n", $cidrs)) === false) {
			echo "Warning: Failed to write to $outDir/$country.txt\n";
			continue;
		}
		
		echo "Completed $country: " . count($cidrs) . " CIDR entries\n";
		$fileCount++;
	}
	
	echo "Stage 2 complete: Exported CIDR data for $fileCount countries.\n";
}
```

