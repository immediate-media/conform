configure_git() {
  # Because some of our transitive JS depdencies reference git URLs directly,
  # which creates issues with SSH.
  git config --global url."https://".insteadOf git://

  print_success "Using HTTPS for git URLs"
}
