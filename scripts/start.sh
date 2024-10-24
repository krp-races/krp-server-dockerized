#!/bin/bash
./install_wine_mono.sh
source setup_xvfb.sh
./install_krp_server.sh
./start_krp_server.sh