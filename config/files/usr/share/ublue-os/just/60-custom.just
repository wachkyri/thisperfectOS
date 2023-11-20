!include /usr/share/ublue-os/just/100-bling.just


# Install Homebrew for Linux
brew:
    echo "Installing homebrew ..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Remove Homebrew
brew-remove:
    echo "Removing homebrew ..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"

# Add Homebrew to shell rc files
brew-shell:
    #!/usr/bin/env bash
    set -euxo pipefail
    echo "Adding homebrew to shell configuration"
    touch $HOME/.zprofile
    touch $HOME/.bash_profile
    if grep -q "linuxbrew" $HOME/.zprofile
    then
      echo "Brew configuration already present in .zprofile"
    else 
      echo "Adding Brew configuration to .zprofile"
      echo 'eval "$(/var/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.zprofile
    fi
    if grep -q "linuxbrew" $HOME/.bash_profile
    then
      echo "Brew configuration already present in .bash_profile"
    else 
      echo "Adding Brew configuration to .bash_profile"
      echo 'eval "$(/var/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.bash_profile
    fi

# Switch to the zsh shell
zsh:
    sudo usermod $USER --shell /usr/bin/zsh 
    printf "${USER}'s shell is now %s." "$(cat /etc/passwd | grep ":$UID:" | cut '-d:' '-f7')"

# Enable docker on the system
docker:
    sudo systemctl enable --now docker
    sudo usermod -aG docker $USER
    newgrp docker