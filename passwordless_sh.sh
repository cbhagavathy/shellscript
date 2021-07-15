#!/bin/sh

echo "Generating the public key in source machine"
ssh-keygen -t rsa

echo "Generating .ssh directory in destination machine"
ssh integrate@`hostname` mkdir -p .ssh

echo "Copying the source machine public key in destination machine"
cat .ssh/id_rsa.pub | ssh integrate@`hostname` 'cat >> .ssh/authorized_keys'

echo "Modifying the properties of .ssh/authorized_keys at destination"
ssh integrate@`hostname` "chmod 700 .ssh; chmod 640 .ssh/authorized_keys"
