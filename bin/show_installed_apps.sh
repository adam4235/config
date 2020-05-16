#!/bin/bash

#From https://unix.stackexchange.com/questions/190579/is-there-a-command-that-outputs-only-the-packages-explicitly-installed-by-the-us
#Note: Have to edit /etc/logrotate.d so that this shows the whole history, not just the last 12 months.
comm -23 <(apt-mark showmanual | sort -u) \
         <(gzip -dc /var/log/installer/initial-status.gz |
           sed -n 's/^Package: //p' | sort -u)

