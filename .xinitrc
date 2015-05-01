if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?* ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi
xrdb ~/.Xresources
setxkbmap se
xsetroot -cursor_name left_ptr
sh ~/.fehbg
exec i3

