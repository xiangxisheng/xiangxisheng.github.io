---
layout: page
title: About(关于)
description: 打码改变世界
keywords: Xiang Xisheng, 项希盛
comments: true
menu: About
permalink: /about/
---

Hello everyone, I'm an 80s-born programming enthusiast, born in 1988 and graduated in 2009. On my journey in programming, I've been continuously exploring, learning, and growing, with the hope of becoming an accomplished programmer.

In 2017, I founded Wenzhou Fei'er Cloud to provide cloud hosting services. Throughout this process, I gained extensive knowledge in cloud computing and network technology and connected with many like-minded friends. The philosophy behind Fei'er Cloud is to offer high-quality cloud computing services, making the convenience of cloud technology accessible to more people.

I believe programming is an exciting and challenging profession. Through programming, we can create a wide range of useful tools and applications that make people's lives more convenient and efficient.

As a programmer, I always keep a mindset of learning and exploration, constantly working to improve my coding skills and professional expertise. I believe that only through continuous learning and innovation can we keep pace with the times and face future challenges. Thank you for taking the time to read my introduction, and I look forward to opportunities to discuss, learn, and grow together with you all.

<br />

大家好，我是一名热爱编程的85后，出生于1988年，毕业于2009年。我在编程的道路上不断探索、学习和进步，希望能成为一名优秀的程序员。

2017年，我创立了温州飞儿云，提供云主机服务。在这个过程中，我学习了很多关于云计算和网络技术的知识，也结识了很多志同道合的朋友。飞儿云的理念是为用户提供高品质的云计算服务，让更多的人享受到云计算的便利。

我相信，编程是一项有趣而且充满挑战的工作。通过编程，我们可以创造出各种有用的工具和应用程序，让人们的生活更加便捷和高效。

作为一名程序员，我一直保持着学习和探索的心态，不断提高自己的编程能力和专业水平。我相信只有持续不断地学习和创新，才能跟上时代的步伐，迎接未来的挑战。感谢您花时间阅读我的个人介绍，期待能有机会与大家共同探讨、学习和成长。

<br />

## Contacts(联系方式)

<ul>
{% for website in site.data.contacts %}
<li>{{website.sitename }}：<a href="{{ website.url }}" target="_blank">{{ website.name }}</a></li>
{% endfor %}
</ul>
