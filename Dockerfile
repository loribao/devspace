FROM kalilinux/kali-rolling:latest
WORKDIR /root
#deps
RUN apt update 
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
RUN  .asdf/bin/asdf plugin add dotnet && \
    .asdf/bin/asdf plugin add nodejs && \
    .asdf/bin/asdf plugin add elixir && \
    .asdf/bin/asdf plugin add erlang && \
    .asdf/bin/asdf plugin add rust && \
    .asdf/bin/asdf plugin add julia && \
    .asdf/bin/asdf plugin add java

CMD [ "/bin/bash" ]