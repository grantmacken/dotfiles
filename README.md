# dotfiles

my dotfiles

After a brief search on how best to organize my dotfiles
under git control, I set upon using stow



http://mywiki.wooledge.org/DotFiles

```apt-get install stow```

created a dotfiles repo on github and cloned in home

created a bash dir under ```~/dotfiles``

    cd ~/ && git clone git@github.com:grantmacken/dotfiles.git


    touch  bash/.inputrc
    chmod --reference ~/.bashrc  bash/.inputrc

##bash



##tmux


#stow
http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html
http://spin.atomicobject.com/2014/12/26/manage-dotfiles-gnu-stow/
http://taihen.org/managing-dotfiles-with-gnu-stow/
https://www.youtube.com/watch?v=zhdO46oqeRw
https://github.com/gotbletu/shownotes/blob/master/stow.txt

#dotfiles
https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789
https://github.com/webpro/awesome-dotfiles

http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
http://www.drbunsen.org/the-text-triumvirate/
