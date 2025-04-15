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
