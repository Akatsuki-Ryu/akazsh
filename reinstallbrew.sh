cd `brew --prefix`
rm -rf Cellar
brew prune
rm -rf Library .git .gitignore bin/brew README.md share/man/man1/brew
rm -rf ~/Library/Caches/Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"