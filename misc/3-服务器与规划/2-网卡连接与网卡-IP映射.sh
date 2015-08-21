#!/bin/bash
rm -f ../../book/3-服务器与规划/image/diag-*.png ../../book/3-服务器与规划/image/2-网卡连接与网卡-IP映射.png

asciidoctor -r asciidoctor-diagram -o ../../book/3-服务器与规划/image/2-网卡连接与网卡-IP映射.html 2-网卡连接与网卡-IP映射.adoc

rm -f ../../book/3-服务器与规划/image/2-网卡连接与网卡-IP映射.html ../../book/3-服务器与规划/image/*.png.cache

mv ../../book/3-服务器与规划/image/diag-*.png ../../book/3-服务器与规划/image/2-网卡连接与网卡-IP映射.png
