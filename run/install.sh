#!/bin/bash

echo CUZAO2

# Run the one time install if this is the first time we are running
if [ ! -f /etc/freepbx.conf ]; then
  pushd /usr/src/freepbx
  # Start an asterisk instance just for install
  ./start_asterisk start
  ./install -n --dbpass 34641747 --dbuser rodrigo --dbname asterisk --dbengine mysql --dbhost 10.11.40.3
  status=$?
  
  if [ $status -ne 0 ]; then
    echo "Failed to install FreePBX: $status"
    exit $status
  fi

  fwconsole chown
  fwconsole ma upgradeall
  fwconsole ma downloadinstall backup pm2

  fwconsole chown
  fwconsole ma refreshsignatures
  fwconsole reload 
  
  # Stop asterisk post install
  echo 'Done installing FreePBX'
  popd
fi
