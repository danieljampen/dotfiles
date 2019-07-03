# Howto use:
easy, just run: 

```bash
git clone https://github.com/danieljampen/dotfiles.git
cd dotfiles
stow *
```

# Additional steps
## Run autorandr before starting LightDM
to load the autorandr profile before starting LightDM, edit the lightdm.conf file in /etc/lightdm and set:

```bash
....
[Seat:*]
...
display-setup-script=autorandr --change

# additonally, install numlockx and set the following line to auto enable numlock
greeter-setup-script=/usr/bin/numlockx on
...
```

autorandr is run as root and for some reason looks for the config files directly in the / folder. Therefore add a symlink to the config dir in /root. If someone knows how to set the config dir without symlinks, plz let me know :)

```bash
ln -s /home/$USER/.config /.config
```
