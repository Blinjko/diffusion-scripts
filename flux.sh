#!/bin/bash
apt update
apt install -y git git-lfs tmux vim htop nvtop

#comfyui shit
pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu121
cd /workspace
git clone https://github.com/comfyanonymous/ComfyUI.git
cd ComfyUI
pip install -r requirements.txt
cd custom_nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager.git
cd ..

# get needed models to run flux
huggingface-cli login

git lfs install
GIT_LFS_SKIP_SMUDGE=1 git clone https://huggingface.co/black-forest-labs/FLUX.1-dev

cd FLUX.1-dev

git lfs pull --include "ae.safetensors"
git lfs pull --include "flux1-dev.safetensors"

cd ../models/vae/
ln -s ../../FLUX.1-dev/ae.safetensors

cd ../unet/
ln -s ../../FLUX.1-dev/flux1-dev.safetensors

cd ../clip/
wget "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp16.safetensors"
wget "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors"
wget "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp8_e4m3fn.safetensors"
