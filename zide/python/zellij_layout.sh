#!/usr/bin/env bash

if [ ! $(which zellij) ]; then
	echo "zide requires zellij to be installed"
	exit 1
fi

# zellij action new-tab --cwd $1 --layout default --name "zide"
# zellij action new-tab --cwd . --layout zide --layout-dir ~/.config/zellij/layouts

zellij action rename-tab "zide"
zellij action new-pane --direction left --close-on-exit -- hx .
zellij action resize left +
zellij action resize left +
zellij action resize right +
zellij action resize right +
zellij action resize right +

zellij action new-pane --name zync --cwd .
zellij action write-chars "zync . HOST TARGET"

zellij action new-pane --name git --cwd . --close-on-exit -- lazygit

if [ -f ./pytest.ini ]; then
	zellij action new-pane --name testing --start-suspended -- pytest .
fi
if [ -f ./cargo.toml ]; then
	zellij action new-pane --name test --start-suspended -- cargo test
	zellij action new-pane --name run -- cargo run
	zellij action new-pane --name clippy -- bacon clippy
fi

zellij action focus-next-pane
# zellij action new-pane --name ranger --cwd . --direction left --close-on-exit -- ranger .
zellij action focus-next-pane
zellij action focus-next-pane
ranger .
