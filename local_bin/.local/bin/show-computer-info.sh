#!/usr/bin/env bash
echo "======== show computer information ========"
for d in system-manufacturer system-product-name system-version bios-release-date bios-version processor-version
do
      echo "${d^} : " $(sudo dmidecode -s $d); 
done
