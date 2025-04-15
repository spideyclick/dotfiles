def dfls_profiles [] {
  ls -d --short-names  ~/dotfiles/profiles/ | get name
}
def dfls_subcommands [] {
  [go install other]
}
export def main [
  --profile (-p): string@dfls_profiles
  sub_command: string@dfls_subcommands
  ...args
] {
  match $sub_command {
    'go' => { install --profile $profile }
    'add' => { add --profile $profile ($args | first) }
    _ => { print "other" }
  }
}

def install [
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

def add [
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
  let target = $config_dir | path join ($path | path expand | path relative-to '~' ) | path expand
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
    'dir' => { print "dir not implemented"; return }
    'symlink' => { print "symlink not implemented"; return }
    _ => { print $"Unexpected path type found: ($path) is type ($path | path type)" }
  }
  # $target
}
