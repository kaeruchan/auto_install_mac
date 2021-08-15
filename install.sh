## /usr/bash

## all application can run
sudo spctl --master-disable

## Xcode
echo "Now installing Xcode (This needs long period)...\n"
sudo softwareupdate --list
sudo softwareupdate --install xcode
sudo xcode-select --install

## Homebrew install
echo "Now installing Homebrew ...\n"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew upgrade

## iterm2
echo "Now installing iterm2 ...\n"
brew install iterm2 --cask
# unzip package
unzip -d ~ dotemacs.d.zip
ln -s ~/dotemacs.d/dotbash_profile .bash_profile
ln -s ~/dotemacs.d/dotbashrc .bashrc
source ~/.bash_profile
# change to bash as default shell
chsh -s /bin/bash
echo "export BASH_SILENCE_DEPRECATION_WARNING=1" >> .bash_profile
source ~/.bash_profile

## editor
clear
echo -e "Now installing editor ...\\nWhich editor would you want to install?\\n1) Emacs\\n2) Atom\\n3) Vscode\\n4) Don't install now, I'll manually install it later\\nPlease choose [1-4]: \c"
read ANS
if $ANS -eq 1; then
    # emacs
    echo "Installing Emacs ...\n"
    brew install emacs --cask
    ln -s ~/dotemacs.d .emacs.d
elif $ANS -eq 2; then
    # atom
    echo "Installing Atom ... \n"
    brew install atom --cask
elif $ANS -eq 3; then
    # vscode
    echo "Installing Vscode ... \n"
    brew install visual-studio-code --cask
else
    # not install
    echo "Skipped ... \n"
fi

## Dropbox
echo "Installing Dropbox ..."
brew install dropbox --cask

## Japanese-Ime
echo "Installing Google Japanese Input ..."
brew install google-japanese-ime --cask

## Supermjograph
echo "Installing Supermjograph ..."
wget -P ~ https://sourceforge.net/projects/mjograph/files/SuperMjograph/SuperMjograph-0.17.1.zip
unzip -d ~ ~/SuperMjograph-0.17.1.zip
cp -r ~/SuperMjograph.app /Applications
# clean
rm -rf ~/SuperMjograph*

## LaTeX
echo "Now Installing LaTeX (This may takes a long period)...\n"
brew install ghostscript
brew install basictex --cask 
sudo /usr/local/texlive/2021basic/bin/universal-darwin/tlmgr path add
sudo tlmgr update --self --all
sudo tlmgr install collection-langjapanese
brew install latexit --cask

