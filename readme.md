## 分析镜像

```bash

## 覆盖容器的默认入口点，直接进入 bash
sudo docker run -it --entrypoint bash sharelatex/sharelatex
# sudo docker exec -it sharelatex bash

## 查看系统的名称
cat /etc/os-release  # 可以发现采用的是ubuntu 22.04
## 还可以查看 latex 的版本信息
latex --version
## 5.1.1 版本,采用的是 ubuntu 22.04, latex 为 pdfTeX 3.141592653-2.6-1.40.26 (TeX Live 2024)

```

```bash
root@a53dc8bac7cd:/overleaf# latex --version
pdfTeX 3.141592653-2.6-1.40.26 (TeX Live 2024)
kpathsea version 6.4.0
Copyright 2024 Han The Thanh (pdfTeX) et al.
There is NO warranty.  Redistribution of this software is
covered by the terms of both the pdfTeX copyright and
the Lesser GNU General Public License.
For more information about these matters, see the file
named COPYING and the pdfTeX source.
Primary author of pdfTeX: Han The Thanh (pdfTeX) et al.
Compiled with libpng 1.6.43; using libpng 1.6.43
Compiled with zlib 1.3.1; using zlib 1.3.1
Compiled with xpdf version 4.04

```

## 看镜像大小和网上说的, 镜像不完整缺包, 缺中文

进入容器

```bash
#永久改为 清华镜像
tlmgr option repository https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/tlnet

# 缺少中文字体
# cd /usr/share/fonts/
# mkdir myfont  # 创建一个目录

#拷贝
sudo docker cp myfont sharelatex:/usr/share/fonts/myfont
## 物理机上也拷贝一份
# sudo cp -r myfont /usr/share/fonts/
# 进入容器
# 更新字体缓存
fc-cache -fv
#查看字体
fc-list
# latexmk -xelatex main.tex
```

### 提交给腾讯云 和 docker hub

- 字体来源: qqzsc/myfont:0.0.1

```bash
git remote add mygithub git@github.com:zoushucai/sharelatex.git
git push mygithub main
```
