FROM qqzsc/myfont:0.0.1 AS downloader

FROM sharelatex/sharelatex:5.1.1
SHELL ["/bin/bash", "-cx"]

# 设置 TeX Live 镜像为清华大学镜像，并更新 tlmgr 自身
RUN tlmgr option repository https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/tlnet && \
    tlmgr update --self

# 安装 LaTeX 的完整方案
RUN tlmgr install scheme-full && tlmgr update --all

COPY --from=downloader /myfont /usr/share/fonts/myfont
RUN fc-cache -fv /usr/share/fonts/myfont && fc-cache -fv 

# recreate symlinks
RUN tlmgr path add && apt-get update && apt-get upgrade -y

# install minted dependency
RUN apt-get install python3-pygments inkscape lilypond -y

# enable shell-escape by default:
RUN TEXLIVE_FOLDER=$(find /usr/local/texlive/ -type d -name '20*') \
    && echo % enable shell-escape by default >> /$TEXLIVE_FOLDER/texmf.cnf \
    && echo shell_escape = t >> /$TEXLIVE_FOLDER/texmf.cnf












