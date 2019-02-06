echo now we will install brew . press N to skip 

read -p "ok? (y/N): " yn
case "$yn" in [yY]*) /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
;; *) echo "skip." ; ;; esac








cd ..
echo this will overwrite the setting on this user .... 

read -p "ok? (y/N): " yn
case "$yn" in [yY]*) ;; *) echo "abort." ; exit ;; esac

# linking diff_highlight to system . git should be from brew . this needs to be confirmed 
	sudo ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight
	
rm -r .gitconfig
rm -r .config	
rm -r .tmux.conf
rm -r .zshrc
rm -r .ssh	
rm -r .tigrc

ln -s akazsh/.gitconfig .gitconfig
 ln -s akazsh/.config .config
  ln -s akazsh/.tmux.conf.local .tmux.conf.local
  ln -s akazsh/.tmux.conf .tmux.conf
  ln -s akazsh/.zshrc .zshrc
  ln -s akazsh/.ssh .ssh
  ln -s akazsh/.tigrc .tigrc
