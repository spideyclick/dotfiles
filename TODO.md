# TODO

- [ ] Config Section Manager
    ```sh
      #!/bin/bash
    # Define the start and end delimiters
    START_DELIMITER="### MANAGED BY MY_SCRIPT - START"
    END_DELIMITER="### MANAGED BY MY_SCRIPT - END"
    # Content to be managed
    MANAGED_CONTENT="export MY_VAR='my_value'"
    # Check if the delimiters exist in the file
    if grep -q "$START_DELIMITER" ~/.bashrc && grep -q "$END_DELIMITER" ~/.bashrc; then
        # Replace the existing managed content
        sed -i "/$START_DELIMITER/,/$END_DELIMITER/c\\$START_DELIMITER\n$MANAGED_CONTENT\n$END_DELIMITER" ~/.bashrc
    else
        # Insert the managed content if delimiters don't exist
        echo -e "\n$START_DELIMITER\n$MANAGED_CONTENT\n$END_DELIMITER" >> ~/.bashrc
    fi
    ```
- [ ] Managed .bashrc
- [ ] Managed .bash_profile
- [ ] Change init calls for zoxide & starship to trigger only if those commands are available
- [ ] Termux needs a lot of fixes/updates

## Archive

- [x] WayBar
  - [x] Fix Memory/CPU readouts
  - [x] Fix workspace switcher icon
  - [x] Fix broken icons
  - [x] Finish styling
  - [x] Style workspace switcher
- [x] Fix screen brighness
- [x] Fix sound
- [x] Home Manager
  - [x] Git config
- [x] Fix launch & shutdown menus
- [x] Make a project out of all configurations & dotfiles
- [x] Configuration for WSL
- [x] Change to ZSH + Zellij
  - [ ] Oh-my-zsh + autofill
- [ ] Change terminal from Kitty to WezTerm (rustify everything now that we are on Zellij)
- [ ] Animated wallpapers
- [ ] NixOS Flakes
  - [ ] Create flakes to fix Helix dependencies?
