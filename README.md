# dotfiles

my dotfiles

After a brief search on how best to organize my dotfiles
under git control, I set upon using stow

http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html


```apt-get install stow```

created a dotfiles repo on github and cloned in home

 ``````

created a bash dir under ```~/dotfiles``

    cd ~/ && git clone git@github.com:grantmacken/dotfiles.git
    cd dotfiles &&  mkdir bash
    cp ../.bashrc bash
    cp ../.profile bash
    cp ../.bash_logout bash


https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789

    touch  bash/.inputrc
    chmod --reference ~/.bashrc  bash/.inputrc
    # The behavior of line input editing and keybindings is stored in a .inputrc
    touch  bash/.bash_aliases
    # shortcuts for commands
    touch  bash/.bash_functions
    #
    touch  bash/.bash_env
    # Environment variables
    touch  bash/.bash_prompt
    # my prompt





https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789
https://github.com/webpro/awesome-dotfiles

http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
http://www.drbunsen.org/the-text-triumvirate/
