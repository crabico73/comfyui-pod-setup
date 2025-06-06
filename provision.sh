#!/bin/bash

echo "Starting custom provisioning..."

# Update system and install dependencies
apt update && apt install -y wget git

cd /workspace/ComfyUI

# Activate virtual environment
source ./venv/bin/activate

# Upgrade pip
pip install --upgrade pip

# Install missing Python packages
pip install torchsde torchaudio

# Optional: Install any custom nodes or repos
cd /workspace/ComfyUI/custom_nodes

# Clone your favorite nodes (examples)
git clone https://github.com/ltdrdata/ComfyUI-Manager.git
git clone https://github.com/comfyanonymous/ComfyUI_IPAdapter_plus.git
git clone https://github.com/Animator-Anon/ComfyUI-AnimateDiff-Evolved.git

# Optional: Download models (you can expand this)
mkdir -p /workspace/ComfyUI/models/checkpoints
cd /workspace/ComfyUI/models/checkpoints
# Example model (replace with your own .safetensors link if needed)
wget -O example_model.safetensors https://your-model-url-here.safetensors

echo "Provisioning complete."
