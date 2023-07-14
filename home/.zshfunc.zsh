# OpenConnect VPN client (Cisco Anyconnect Protocol)
export VPN_HOST=vpn.example.at
export VPN_USER=exampleuser

function vpnup() {
  if [[ -z $VPN_HOST ]]
  then
    echo "Environment variable VPN_HOST not set."
    return
  fi
  echo "Connecting to $VPN_HOST ..."
  sudo openconnect --background --user=$VPN_USER $VPN_HOST
}

# Stop/Disconnect OpenConnect VPN client
function vpndown() {
  sudo kill -2 `pgrep openconnect`
}

# unmount all manually mounted volumes
function umountall() {
  mountpoints=$(ls $mntdir)
  for m in "${mountpoints[@]}"
    do umount -f $mntdir/$m
  done
}
