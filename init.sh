cd ..
echo this will overwrite the setting on this user .... 

read -p "ok? (y/N): " yn
case "$yn" in [yY]*) ;; *) echo "abort." ; exit ;; esac
	
ln -s akazsh/.gitconfig .gitconfig
 ln -s akazsh/.config .config
  ln -s akazsh/.tmux.conf.local .tmux.conf.local
  ln -s akazsh/.tmux.conf .tmux.conf
  ln -s akazsh/.zshrc .zshrc
  ln -s akazsh/.ssh .ssh

