#!/bin/bash
rm -f ../../book/2-服务器与规划/images/diag-*.png ../../book/2-服务器与规划/images/2-网卡连接与网卡-IP映射.png

asciidoctor -r asciidoctor-diagram   -o ../../book/2-服务器与规划/images/2-网卡连接与网卡-IP映射.html 2-网卡连接与网卡-IP映射.adoc

rm -f ../../book/2-服务器与规划/images/2-网卡连接与网卡-IP映射.html ../../book/2-服务器与规划/images/*.png.cache

mv ../../book/2-服务器与规划/images/diag-*.png ../../book/2-服务器与规划/images/2-网卡连接与网卡-IP映射.png
