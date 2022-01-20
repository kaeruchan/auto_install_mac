## /usr/bash

## all application can run
sudo spctl --master-disable

## Homebrew install
if ! command -v brew &>/dev/null; then
    # unzip package
    unzip -d ~ ~/auto_initial/library/dotemacs.d.zip
    ln -s ~/dotemacs.d/dotbash_profile ~/.bash_profile
    ln -s ~/dotemacs.d/dotbashrc ~/.bashrc
    # change to bash as default shell
    chsh -s /bin/bash
    echo "export BASH_SILENCE_DEPRECATION_WARNING=1" >> .bash_profile
    source ~/.bash_profile
    if `uname -m` == 'x86_64'; then
        echo "Now installing Homebrew ...\n"
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' > ~/.bash_profile
        eval "$(/opt/homebrew/bin/brew shellenv)"
        source ~/.bash_profile
        brew update
        brew upgrade
        # relogin
        exec $SHELL -l
    else
        echo "Now installing Homebrew ...\n"
        # install rosetta2
        /usr/sbin/softwareupdate --install-rosetta --agree-to-license

        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' > ~/.bash_profile
        echo 'alias brew86="arch -x86_64 /usr/local/homebrew/bin/brew"' > ~/.bash_profile
        eval "$(/opt/homebrew/bin/brew shellenv)"
        source ~/.bash_profile
        brew update
        brew upgrade
        # relogin
        exec $SHELL -l
    fi
else
    echo "Homebrew is already installed... Skipped..."
fi


## iterm2

if ! open -Ra "iterm.app" &>/dev/null; then
    echo "Now installing iterm2 ...\n"
    brew install iterm2 --cask
    # relogin
    exec $SHELL -l
else
    echo "iterm2 is already installed ... Skipped ..."
fi


## editor
if [\( ! open -Ra "Emacs.app" &>/dev/null \) -a \( ! open -Ra "Atom.app" &>/dev/null \) -a \( ! open -Ra "Visual studio code.app" &> /dev/null \)]; then
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
else
    "Text editor is installed already (At least one of Emacs, Atom, Vscode)... Skipped ..."
fi


## Dropbox
if ! open -Ra "Dropbox.app" &>/dev/null; then
    echo "Installing Dropbox ..."
    brew install dropbox --cask
else
    echo "Dropbox is installed already ... Skipped ..."
fi

## Japanese-Ime
if ! brew list google-japanese-ime &>/dev/null; then
    echo "Installing Google Japanese Input ..."
    brew install google-japanese-ime --cask
else
    echo "Google Japanese Input is installed already ... Skipped ..."
fi

## Supermjograph
if ! open -Ra "Supermjograph.app" &>/dev/null; then 
    echo "Installing Supermjograph ..."
    brew install wget
    wget -P ~ https://sourceforge.net/projects/mjograph/files/SuperMjograph/SuperMjograph-0.17.1.zip
    unzip -d ~ ~/SuperMjograph-0.17.1.zip
    cp -r ~/SuperMjograph.app /Applications
    # clean
    rm -rf ~/SuperMjograph*
else 
    echo "Supermjograph is installed already ... Skipped ..."
fi

## LaTeX
if ! command -v tlmgr &>/dev/null; then  
    echo "Now Installing LaTeX (This may takes a long period)...\n"
    if [[ `uname -m` == 'x86_64']]; then
        brew install ghostscript
    else
        brew86 install ghostscript
    if
    brew install basictex --cask 
    sudo /usr/local/texlive/2021basic/bin/universal-darwin/tlmgr path add
    sudo tlmgr update --self --all
    sudo tlmgr install collection-langjapanese
    brew install latexit --cask

    exec $SHELL -l
else
    echo "LaTeX is installed already ... Skipped ..."
fi


## Skim
if ! open -Ra "Skim.app" &>/dev/null; then
    echo "Now Installing Skim (PDF viewer)...\n"
    brew install skim --cask

    exec $SHELL -l
else
    echo "Skim is installed already ... Skipped ..."
fi 


## pyenv
if ! brew list pyenv &>/dev/null; then
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

    exec $SHELL -l

else
    echo "pyenv is installed already ... Skipped ..."
fi
