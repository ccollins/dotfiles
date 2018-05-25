#!/bin/sh
if test "$(which code)"; then
	if [ "$(uname -s)" = "Darwin" ]; then
		VSCODE_HOME="$HOME/Library/Application Support/Code"
	else
		VSCODE_HOME="$HOME/.config/Code"
	fi

	ln -sf "$DOTFILES/vscode/settings.json" "$VSCODE_HOME/User/settings.json"
	ln -sf "$DOTFILES/vscode/keybindings.json" "$VSCODE_HOME/User/keybindings.json"
	ln -sf "$DOTFILES/vscode/snippets" "$VSCODE_HOME/User/snippets"

	# from `code --list-extensions`
	modules="
CraigMaslowski.erb
Equinusocio.vsc-material-theme
James-Yu.latex-workshop
PeterJausovec.vscode-docker
QassimFarid.ejs-language-support
aaronthomas.vscode-snazzy-operator
arcticicestudio.nord-visual-studio-code
castwide.solargraph
codezombiech.gitignore
cometeer.spacemacs
dbaeumer.vscode-eslint
eamodio.gitlens
ecmel.vscode-html-css
formulahendry.auto-close-tag
gerane.Theme-Blackboard
gerane.Theme-PastelsonDark
humao.rest-client
idleberg.hopscotch
jansenfuller.crayon-vscode
kalitaalexey.vscode-rust
kumar-harsh.graphql-for-vscode
mauve.terraform
ms-python.python
ms-vscode.atom-keybindings
ms-vscode.cpptools
ms-vscode.Go
raashida.fixthecode-vs
rebornix.Ruby
redhat.java
robertohuertasm.vscode-icons
robinbentley.sass-indented
saviorisdead.RustyCode
sbrink.elm
thenikso.github-plus-theme
vsciot-vscode.vscode-arduino
vscjava.vscode-java-debug
vscjava.vscode-java-pack
vscjava.vscode-java-test
vscjava.vscode-maven
zhuangtongfa.Material-theme
"
	for module in $modules; do
		code --install-extension "$module" || true
	done
fi
