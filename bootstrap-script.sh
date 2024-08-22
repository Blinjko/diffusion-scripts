#!/bin/bash
apt update
apt -y install python3.11 python3.11-venv nvidia-cuda-toolkit libgl1-mesa-glx tmux vim
cd /workspace
git clone --branch=release https://github.com/bghira/SimpleTuner.git
cd SimpleTuner
python3.11 -m venv .venv
source .venv/bin/activate

pip install -U poetry pip
poetry install --no-root
pip uninstall -y deepspeed bitsandbytes
pip uninstall diffusers
pip install git+https://github.com/huggingface/diffusers
pip install optimum-quanto

mkdir datasets
mv ../anime-test-01 datasets/
mv ../config.env config/
mv ../multidatabackend.json config/

echo "Exiting script, dont forget to source venv, log into huggingface, create a termux session with tmux new -s simple-tuner"
