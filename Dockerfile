FROM kalilinux/kali-rolling:latest
WORKDIR /root
#deps
RUN apt update && apt-get install -y icu-devtools locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8
ENV TIME_ZONE=America/Sao_Paulo
RUN echo "America/Sao_Paulo" > /etc/timezone

RUN apt update && apt full-upgrade -y
RUN apt install net-tools iputils-ping git curl zsh tmux -y
# tmux
RUN cd && \
    git clone https://github.com/gpakosz/.tmux.git && \
    ln -s -f .tmux/.tmux.conf && \
    cp .tmux/.tmux.conf.local . 
#asdf install
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.3 && \
    echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc && \  
    echo '. "$HOME/.asdf/asdf.sh"' >> ~/.zshrc && \  
    echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.bashrc && \
    echo 'fpath=(${ASDF_DIR}/completions $fpath)' >> ~/.zhrc && \    
    echo 'autoload -Uz compinit && compinit' >> ~/.zhrc
#asdf plugins
RUN ls -la
RUN .asdf/bin/asdf plugin add dotnet && \
    .asdf/bin/asdf plugin add nodejs && \
    .asdf/bin/asdf plugin add rust && \
    .asdf/bin/asdf plugin add julia && \
    .asdf/bin/asdf plugin add java

#install java
RUN .asdf/bin/asdf install java openjdk-19  && \
    .asdf/bin/asdf global java openjdk-19 

#install dotnet
RUN .asdf/bin/asdf install dotnet 7.0.202 && \
    .asdf/bin/asdf global dotnet 7.0.202
#install julia
RUN .asdf/bin/asdf install julia 1.8.5 && \
    .asdf/bin/asdf global julia 1.8.5
#rust
RUN .asdf/bin/asdf install rust 1.68.0 
RUN .asdf/bin/asdf global rust 1.68.0

CMD [ "/bin/bash" ]