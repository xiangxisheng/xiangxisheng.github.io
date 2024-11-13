---
layout: post
title: 如何在Windows下安装Jekyll
categories: windows/setup
date: 2024-09-13 09:26:48 +0800
author: 'zhangtao'
tags:
- 个人博客搭建
- iis
- windows server
- jekyll
- 自建博客

---
16年就备案了域名，手写了个简单的网站就一直没管。这年年续费也费得我心痛 啊，本着不浪费的原则 ，我也弄一个稍微成型一点的网站。

前面也是一直想自己写，无奈根本没有学习Web开发的时间，所以转向静态网站生成器。

这里我主要了解了一下hexo和jekyll，最终选择了jekyll，因为看到有一些MVP的大佬也在用。

<br />

因为官方是推荐Linux搭建吧，所以我第一次搭建也是花了点时间查资料的，这里做个总结，给后面有需要的小伙伴做个参考。

<br />

**1.首先安装ruby**

访问[Downloads](https://rubyinstaller.org/downloads/ "Downloads")，在这里可以下载到**ruby** 的**Windows**安装包。

需要注意是，这里要选择带开发包(**DEVKIT**)的安装包

[https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-3.1.2-1/rubyinstaller-devkit-3.1.2-1-x64.exe](https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-3.1.2-1/rubyinstaller-devkit-3.1.2-1-x64.exe "https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-3.1.2-1/rubyinstaller-devkit-3.1.2-1-x64.exe")

<br />

![]({{site.baseurl}}/images/posts/windows/setup-jekyll/1731512614892.png)

<br />

<br />

<br />

**下载速度比较慢，下载完成后，执行安装。**

<br />

![]({{site.baseurl}}/images/posts/windows/setup-jekyll/1731512620408.png)

<br />

**这一步的添加到环境变量默认钩上，不要取消。否则后面会找不到ruby的执行路径，还得手动加。**

<br />

<br />

![]({{site.baseurl}}/images/posts/windows/setup-jekyll/1731512621841.png)

前面我下载的是不带开发包的安装包，那个安装包是没有画红线这个选项的，结果后面怎么都执行不成功。

<br />

<br />

<br />

![]({{site.baseurl}}/images/posts/windows/setup-jekyll/1731512626648.png)

**安装完成后，这里这个钩不要取消，直接点Finish，会安装msy32**

<br />

<br />

![]({{site.baseurl}}/images/posts/windows/setup-jekyll/1731512628209.png)

**输入1，回车**

<br />

<br />

<br />

![]({{site.baseurl}}/images/posts/windows/setup-jekyll/1731512689550.png)

**这里我更新密钥的时候好像都超时失败了，不过好像也不影响，不是做ruby开发的，也没有深入去了解啥原因了。**

<br />

<br />

<br />

![]({{site.baseurl}}/images/posts/windows/setup-jekyll/1731512692291.png)

**显示安装成功了，关闭窗口**

<br />

**2.然后下载rubygems，这是ruby的包管理器。**

[Download RubyGems \| RubyGems.org \| your community gem host](https://rubygems.org/pages/download "Download RubyGems | RubyGems.org | your community gem host")

[https://rubygems.org/rubygems/rubygems-3.3.25.zip](https://rubygems.org/rubygems/rubygems-3.3.25.zip "https://rubygems.org/rubygems/rubygems-3.3.25.zip")

**下载完成后，解压出来，可以直接双击运行，因为前面已经注册了.rb扩展名，会直接调用ruby打开。**

<br />

![]({{site.baseurl}}/images/posts/windows/setup-jekyll/1731512700592.png)

<br />

<br />

<br />

**打开后会执行安装，安装完成后会自动关闭。打开cmd，输入gem，查看是否安装成功**

<br />

![]({{site.baseurl}}/images/posts/windows/setup-jekyll/1731512704695.png)

<br />

**安装成功后，安装jekyll，打开cmd，输入以下指令**

```
gem install jekyll bundler
```

<br />

![]({{site.baseurl}}/images/posts/windows/setup-jekyll/1731512715651.png)

<br />

**安装完成后，执行jekyll查看是否安装成功**

<br />

![]({{site.baseurl}}/images/posts/windows/setup-jekyll/1731512716546.png)

<br />

**在D:\\myblog创建一个jekyll站点**

```
1 jekyll new D:\myblog
```

<br />

<br />

![]({{site.baseurl}}/images/posts/windows/setup-jekyll/1731512719777.png)

<br />

<br />

<br />

**切换到D:\\myblog目录，**

<br />

![]({{site.baseurl}}/images/posts/windows/setup-jekyll/1731512724828.png)

<br />

<br />

<br />

**运行服务器**

```
1 bundle exec jekyll serve --port 10240
```

**后面的port参数是指定端口，默认是4000，我一开始没有指定端口，而我电脑上的4000端口已经被占用了，所以一直在报错。**

<br />

![]({{site.baseurl}}/images/posts/windows/setup-jekyll/1731512746950.png)

<br />

<br />

<br />

![]({{site.baseurl}}/images/posts/windows/setup-jekyll/1731512747464.png)

<br />

**服务器运行成功，可以输入localhost:10240查看站点**

<br />

![]({{site.baseurl}}/images/posts/windows/setup-jekyll/1731512747773.png)

<br />

<br />

至此jekyll就安装成功了

后面我也要再了解了解主题是如何用的，以及如何加入自己的内容和启用https

一开始配置的时候看官方文档上面说要安装GCC和MAKE，我折腾了好久，后面才发现，在Windows环境下只需要一个安装包就可以了，就是我前面说的带devkit的安装包。因为里面带了msy32，msy32又包含了这些。
