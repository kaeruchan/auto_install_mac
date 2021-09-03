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
unzip -d ~ ~/auto_initial/library/dotemacs.d.zip
ln -s ~/dotemacs.d/dotbash_profile .bash_profile
ln -s ~/dotemacs.d/dotbashrc .bashrc
source ~/.bash_profile
# change to bash as default shell
chsh -s /bin/bash
echo "export BASH_SILENCE_DEPRECATION_WARNING=1" >> .bash_profile
source ~/.bash_profile

## editor
clear
echo -e "Now installing editor ...\\nWhich editor would you want to install?\\n1) Emacs\\n2) Atom\\n3) Vscode\\n4) Don't install now, I'll manually install it later\\nPlease choose [1-4, otherwise skip]: \c"
read ANS
case $ANS in 
    [1]* )
    # emacs
    echo "Installing Emacs ...\n"
    brew install emacs --cask
    ln -s ~/dotemacs.d .emacs.d
    ;;
    [2]* ) 
    # atom
    echo "Installing Atom ... \n"
    brew install atom --cask
    ;;
    [3]* ) 
    # vscode
    echo "Installing Vscode ... \n"
    brew install visual-studio-code --cask
    # install dependencies
    # C/C++
    code --install-extension ms-vscode.cpptools
    # Python
    code --install-extension ms-python.python
    code --install-extension ms-python.vscode-pylance
    code --install-extension ms-toolsai.jupyter
    # syntax checker
    code --install-extension spellright
    # Latex
    code --install-extension James-Yu.latex-workshop
    code --install-extension valentjn.vscode-ltex
    # spell-check
    code --install-extension latex-support

    # font install -- ricky
    brew tap homebrew/cask-fonts
    brew install font-ricty-diminished --cask
    sudo cp -f ~/auto_initial/settings.json ~/Library/Application\ Support/Code/User/
    ;;
    * )
    # not install
    echo "Skipped ... \n"
esac

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

## Skim
echo "Now Installing Skim (PDF viewer)...\n"
brew install skim --cask

## pyenv
echo "Now Installing pyenv ... \n"

brew install pyenv

echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
echo 'if command -v pyenv 1>/dev/null 2>&1; then' >> ~/.bash_profile
echo '  eval "$(pyenv init --path)"' >> ~/.bash_profile
echo 'fi' >> ~/.bash_profile
source ~/.bash_profile

## pyenv initial

pyenv install 3.9.1
pyenv global 3.9.1

pip install numpy scipy matplotlib