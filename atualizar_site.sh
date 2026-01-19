#!/bin/bash
git remote set-url origin git@github.com:survivalcartola/survivalcartola.github.io.git
git add .
git commit -m "${1:-Atualização automática}"
git push -u origin main
