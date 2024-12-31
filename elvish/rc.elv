cd
eval (starship init elvish)
eval (zoxide init elvish --cmd cd | slurp)
echo "Welcome to Elvish!\nEnjoy your stay :3"
#---Git aliases---#
fn gc {|@a| e:git commit -a $@a }
fn git {|@a| e:hub $@a }
fn gl {|@a| e:git log --oneline --all --graph --decorate $@a }
fn gf {|@a| e:git pull $@a }
fn gp {|@a| e:git push $@a }
fn gco {|@a| e:git checkout $@a }
fn gs {|@a| e:git stash $@a }
fn gd {|@a| e:git diff $@a }
fn gr {|@a| e:git reset --hard HEAD $@a}
#---General aliases---#
fn ls {|@a| e:lsd -A $@a }
fn brew {|@a| e:/home/linuxbrew/.linuxbrew/bin/brew $@a }
fn man {|@a| e:batman $@a }
fn velvish {|@a| e:vi ~/.config/elvish/rc.elv $@a }
fn vifoot {|@a| e:vi ~/.config/foot/foot.ini $@a}
fn yeet {|@a| e:yay -Rcns $@a }
fn ce {|@a| e:clear; exec elvish $@a }
fn nerdfetch {|@a| e:nerdfetch -c $@a }
fn cbl {|@a| e:cbonsai -l $@a }
fn shit {|@a| e:fuck -y $@a }
fn whatbroke {|@a| e:sudo systemctl list-units --failed $@a }
fn mkexec {|@a| e:chmod +x $@a }
fn lookfor {|@a| e:yay -Q | rg $@a }
fn visudo {|@a| e:sudo vi /etc/doas.conf $@a }
fn pow {|@a| e:math:pow $@a}
fn rr {|@a| e:rm -rf $@a}
fn update {|@a| e:yay --noconfirm; flatpak update $@a}
fn eshell {|@a| e:emacs -nw --no-splash -f eshell $@a}
