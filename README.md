# 🥭 Mango-NIX Development Environment for WSL 2 (Ubuntu Edition)

Welcome to the Mango-NIX Development Environment!
This project aims to make setting up a consistent and hassle-free development environment on WSL 2 (Ubuntu) a breeze.
Follow the instructions below to get started. 🚀

## 📝 Table of Contents

- [Update Environment](#update-environment)
- [Setup](#setup)
  - [Install Nix](#install-nix)
  - [Allow nix-command and flakes](#allow-nix-command-and-flakes)
  - [Add home-manager](#add-home-manager)

## 🔄 Update Environment

Once you have everything set up, you can easily update your development environment by running:

```bash
home-manager switch --flake ./mango-nix -b backup
```

## 🛠️ Setup

### 📦 Install Nix

Start your journey by installing Nix:

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

After restarting your shell, verify that the installation was successful:
```bash
nix --version
```

### 🧪 Allow nix-command and flakes

Enable experimental features to allow the use of nix-command and flakes:

```bash
mkdir -p ~/.config/nix
touch ~/.config/nix/nix.conf
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
```

### 🏡 Add home-manager

Home Manager helps you manage your user environment. Add it by running:

```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix run home-manager/master -- init --switch
```

That's it! You're now ready to take advantage of the Mango-NIX Development Environment. Happy coding! 🎉
