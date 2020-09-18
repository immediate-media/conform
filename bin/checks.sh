check_internet_connection() {
   # Note that we can't use ping as it's blocked when running through our VPN
   if ! curl -v www.google.com &>/dev/null; then
      print_error "Please check your internet connection"
      exit 1
   else
      print_success "Internet connection exists"
   fi
}

check_github_auth() {
   local domain=$1

   # Check if we're authenticated; wait for 10 seconds only in case we're not
   # connected to the VPN
   ssh -T -o ConnectTimeout=10 git@$domain &>/dev/null

   if [ $? == 1 ]; then
      return 0 # user is authenticated, but fails to open a shell with GitHub
   fi

   return 1 # user is not authenticated, or some other error
}

check_ssh_key() {
   local key=$HOME/.ssh/id_rsa.pub
   local ghe_domain=github.immediate.co.uk
   local gh_domain=github.com

   if ! [[ -f $key ]]; then
      if ask "No SSH key found at $key. Create one?" Y; then
         ssh-keygen -b 4096 -t rsa

         echo "SSH key created."

         if ask "Add it to Github Enterprise?" Y; then
            inform 'Public key copied! Paste into Github...'
            [[ -f $key ]] && cat "$key" | pbcopy
            open "https://$ghe_domain/account/ssh"
            read -r -p "   ✦  Press enter to continue..."
         fi

         print_success "SSH key created"
      fi
   else
      print_success "SSH key exists"
   fi

   if ! check_github_auth $ghe_domain; then
      print_warning "SSH authentication failed for ${ghe_domain}"
   fi

   if ! check_github_auth $gh_domain; then
      print_warning "SSH authentication failed for ${gh_domain}"
   fi
}

check_brews() {
   local other_brews=$(brew outdated | wc -l | xargs)

   if [ "$other_brews" -gt 0 ]; then
      # brews outside of the ones specified in the script
      print_warning "$other_brews other brews are outdated. Run 'brew upgrade' to upgrade them."
   fi

   if [[ ! ":$PATH:" == *":/usr/local/opt/grep/libexec/gnubin:"* ]]; then
      print_warning "Add missing \$PATH entry for 'grep': PATH=\"/usr/local/opt/grep/libexec/gnubin:\$PATH\""
   fi
}

check_casks() {
   local other_casks=$(brew outdated --cask | wc -l | xargs)

   if [ "$other_casks" -gt 0 ]; then
      # casks outside of the ones specified in the script
      print_warning "$other_casks other casks are outdated. Run 'brew upgrade --cask' to upgrade them."
   fi
}
