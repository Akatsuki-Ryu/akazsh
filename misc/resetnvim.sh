# required , move the old nvim folder to nvim.bak
# rm -r ~/.config/nvim.bak
# mv ~/.config/nvim{,.bak}

# delete the bak folders
rm -r ~/.local/share/nvim.bak
rm -r ~/.local/state/nvim.bak
rm -r ~/.cache/nvim.bak

# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
