def dfls_profiles [] { ls -d --short-names  ~/dotfiles/profiles/ | get name }

export def install [
  --profile (-p): string@dfls_profiles
] {
  let path = (
    match $profile {
      null => "~/dotfiles/install.sh"
      _ => $"~/dotfiles/profiles/($profile)/install.sh"
    }
  )
  bash -c $path
  print "Dotfiles installation complete!"
}

export def add [
  --profile (-p): string@dfls_profiles
  path: path
] {
  if not ($path | path exists) {
    print $"File or folder not found: ($path)"
    return
  }
  let config_dir = (
    match $profile {
      null => "~/dotfiles/config/"
      _ => $"~/dotfiles/profiles/($profile)/config/"
    }
  )
  let target = (
    $config_dir | path join (
      $path | path expand | path relative-to ( $env.HOME | path expand )
    ) | path expand
  )
  if ($target | path exists) {
    print $"File or folder already exists in dotfiles: ($target)"
    return
  }
  match ($path | path type) {
    'file' => {
      let target_dir = $target | path dirname
      let source_file = ( $path | path expand )
      mkdir -v $target_dir
      print --no-newline 'copy '
      cp -v $source_file $target_dir
      rm -v $source_file
      print --no-newline 'link '
      ln -vs $target $source_file
    }
    'dir' => {
      print --no-newline 'copy '
      cp -vr ($path | path expand) $target
      rm -vr ($path | path expand)
      print --no-newline 'link '
      ln -vs $target ($path | path expand)
    }
    'symlink' => {
      print "target is already a symlink"
      print (ls --long ($path | path expand --no-symlink ) | select name target | first | to yaml)
    }
    _ => { print $"Unexpected path type found: ($path) is type ($path | path type)" }
  }
}

export def deploy [
  --profile (-p): string@dfls_profiles
  --dry-run (-d)
  --verbose (-v)
] {
  let config_dir = (
    match $profile {
      null => ("~/dotfiles/config/" | path expand)
      _ => ($"~/dotfiles/profiles/($profile)/config/" | path expand)
    }
  )
  # ls -af ...(glob $"($config_dir)/**/*") | where type == file | get name | each { |dotfiles_path|
  glob $"($config_dir)/**/*" | each { |dotfiles_path|
    if ( $dotfiles_path | path type ) == 'dir' { return }
    let user_path = ($env.HOME | path expand | path join ($dotfiles_path | path expand | path relative-to ( $config_dir | path expand )))
    match ($user_path | path type) {
      null => {
        print $"(ansi green)DEPLOY(ansi reset) ($user_path) -> ($dotfiles_path)"
        if $dry_run { return }
        mkdir --verbose ( $user_path | path dirname )
        ln -sf $dotfiles_path $user_path
      }
      "symlink" => {
        if ( ( readlink -n $user_path ) == $dotfiles_path ) {
          if $verbose { print $"✅ ($user_path) -> ($dotfiles_path)" }
          return
        }
        print $"(ansi green)UPDATE(ansi reset) ($user_path) -> ($dotfiles_path)"
        if $dry_run { return }
        mkdir --verbose ( $user_path | path dirname )
        ln -sf $dotfiles_path $user_path
      }
      "file" => { print $"(ansi yellow)SKIP(ansi reset) existing file ($user_path)" }
      "dir" => {}
      _ => { print $"(ansi red)ERROR(ansi reset) Path type of ($user_path) not recognized: ($user_path | path type)" }
    }
  }
  if $dry_run { print "Dry run - no files deployed" }

  # Step 2: Iterate over all files in config_blocks dir (including nested)
  # If file exists, print a warning and skip
  # If symlink exists, update

  # Step 3: Iterate over folders in config_folders dir
  # Or maybe whole folders don't make sense
}
