#!/bin/bash

echo "Uninstalling nitch\n"
yay -Rs nitch --noconfirm
rm ./nitch

echo "Building Nitch\n"
nimble build
clear
echo "Linking the binary to /usr/local/bin/"
ls -s nitch /usr/local/bin/
