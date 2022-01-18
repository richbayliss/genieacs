#!/usr/bin/env bash

COMPONENTS=(
    "ui"
    "cwmp"
    "fs"
    "nbi"
);

for COMPONENT in "${COMPONENTS[@]}"; do
  # Swap `echo` for `nmap` to actually scan
  docker build -t "richbayliss/genieacs/$COMPONENT:latest" --target "$COMPONENT" .
done

