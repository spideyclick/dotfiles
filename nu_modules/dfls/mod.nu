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
    'go' => {
      print "go!"
      install --profile $profile
    }
    _ => {
      print "other"
    }
  }
}

export def install [
  --profile (-p): string@dfls_profiles
] {
  $profile
}
