#assuming fresh install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install gnupg yubikey-personalization hopenpgp-tools ykman pinentry-mac wget grep

#have gpg create ~/.gnupg/
gpg --list-keys
cd ~/.gnupg ; wget https://raw.githubusercontent.com/drduh/config/master/gpg.conf
chmod 600 gpg.conf

#changing because venv is preffered
brew install python
