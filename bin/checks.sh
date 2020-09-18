check_internet_connection() {
   if ! ping -c1 google.com &>/dev/null; then
      print_error "Please check your internet connection"
      exit 1
   else
      print_success "Internet connection exists"
   fi
}

check_ssh_key() {
   key=$HOME/.ssh/id_rsa.pub

   if ! [[ -f $key ]]; then
      if ask "No SSH key found at $key. Create one?" Y; then
         ssh-keygen -b 4096 -t rsa

         echo "SSH key created."

         if ask "Add it to Github Enterprise?" Y; then
            inform 'Public key copied! Paste into Github...'
            [[ -f $key ]] && cat "$key" | pbcopy
            open 'https://github.immediate.co.uk/account/ssh'
            read -r -p "   ✦  Press enter to continue..."
         fi

         print_success "SSH key created"
      fi
   else
      print_success "SSH key exists"
   fi
}

check_brews() {
   local other_brews=$(brew outdated | wc -l | xargs)


   if [ "$other_brews" -gt 0 ]; then
      # brews outside of the ones specifed in the script
      print_warning "$other_brews other brews are outdated. Run 'brew upgrade' to upgrade them."
   fi

   if [[ ! ":$PATH:" == *":/usr/local/opt/grep/libexec/gnubin:"* ]]; then
      print_warning "Add missing \$PATH entry for 'grep': PATH=\"/usr/local/opt/grep/libexec/gnubin:\$PATH\""
   fi
}

check_casks() {
   local other_casks=$(brew outdated --cask | wc -l | xargs)

   if [ "$other_casks" -gt 0 ]; then
      # casks outside of the ones specifed in the script
      print_warning "$other_casks other casks are outdated. Run 'brew upgrade --cask' to upgrade them."
   fi
}
