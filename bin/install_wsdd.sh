#!/bin/bash
sudo cp ../src/wsdd /usr/local/bin/wsdd
sudo cp ../src/wsdd.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable wsdd.service
sudo systemctl start wsdd.service
