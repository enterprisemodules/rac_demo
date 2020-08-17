#!/bin/bash

for i in 190 180 122; do
echo "Starting run for ${i}"
vagrant up ml-rac${i}a --no-provision && \
vagrant up ml-rac${i}b --no-provision && \
vagrant up ml-rac${i}a --provision && \
vagrant up ml-rac${i}b --provision && \
vagrant destroy ml-rac${i}a ml-rac${i}b
echo "Done"
done