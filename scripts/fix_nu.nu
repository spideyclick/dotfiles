#!/usr/bin/env nu

ls -a ~/dotfiles/config/.config/nushell/ | get name | each {|i|
  ln -sf $i ~/.config/nushell/($i | path parse | get stem).($i | path parse | get extension)
}
mkdir ~/.cargo; ln -s ~/dotfiles/config/.cargo/env.nu ~/.cargo/env.nu
