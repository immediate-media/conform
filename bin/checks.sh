check_internet_connection() {
   if ! ping -c1 google.com &>/dev/null; then
      print_error "Please check your internet connection"
      exit 1
   else
      print_success "Internet connection"
   fi
}

check_ssh_key() {
   key=$HOME/.ssh/id_rsa.pub

   if ! [[ -f $key ]]; then
      if ask "No SSH key found. Create one?" Y; then
         ssh-keygen -b 4096 -t rsa

         if ask "SSH key created. Add it to Github?" Y; then
            inform 'Public key copied! Paste into Github...'
            [[ -f $key ]] && cat "$key" | pbcopy
            open 'https://github.immediate.co.uk/account/ssh'
            read -r -p "   ✦  Press enter to continue..."
         fi

         print_success "SSH key"
      fi
   else
      print_success "SSH key"
   fi
}
