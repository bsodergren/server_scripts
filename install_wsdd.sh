#!/bin/bash
sudo cp wsdd /usr/local/bin/wsdd
sudo cp wsdd.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable wsdd.service
sudo systemctl start wsdd.service
