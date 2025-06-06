#!/bin/bash

set -e

echo "🔧 Starting custom provisioning for ComfyUI..."

# 1. Activate the Python virtual environment (if it exists)
if [ -f "/workspace/ComfyUI/venv/bin/activate" ]; then
    source /workspace/ComfyUI/venv/bin/activate
else
    echo "⚠️  Virtual environment not found. Skipping activation."
fi

# 2. Install essential Python packages
echo "📦 Installing missing Python packages..."
pip install --upgrade pip
pip install safetensors torch torchvision torchaudio torchsde xformers

# 3. Clone essential custom nodes
cd /workspace/ComfyUI/custom_nodes

echo "🔌 Installing ComfyUI-Manager..."
git clone https://github.com/ltdrdata/ComfyUI-Manager.git || echo "Already exists."

echo "🔌 Installing AnimateDiff Evolved..."
git clone https://github.com/Animator-Anon/ComfyUI-AnimateDiff-Evolved.git || echo "Already exists."

echo "🔌 Installing IPAdapter Plus..."
git clone https://github.com/comfyanonymous/ComfyUI_IPAdapter_plus.git || echo "Already exists."

# 4. Ensure models folder exists
mkdir -p /workspace/ComfyUI/models/checkpoints

# (Optional) Example placeholder for downloading a model
# cd /workspace/ComfyUI/models/checkpoints
# wget -O example_model.safetensors https://your-model-url-here.safetensors

# 5. Download the user's workflow
mkdir -p /workspace/ComfyUI/workflows
wget https://raw.githubusercontent.com/crabico73/comfyui-pod-setup/main/vace_v2v_example_workflow.json -O /workspace/ComfyUI/workflows/vace_v2v_example_workflow.json

# 6. Final message
echo "✅ Provisioning complete. Ready to launch ComfyUI."

# Optional: auto-launch ComfyUI (commented out for now)
# python /workspace/ComfyUI/main.py --listen 0.0.0.0 --port 7861 --highvram
