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

# 5. Download the user's workflow
mkdir -p /workspace/ComfyUI/workflows
wget https://raw.githubusercontent.com/crabico73/comfyui-pod-setup/main/vace_v2v_example_workflow.json -O /workspace/ComfyUI/workflows/vace_v2v_example_workflow.json

# 6. Download models from models.txt
echo "⬇️ Downloading models listed in models.txt..."
MODEL_LIST_URL="https://raw.githubusercontent.com/crabico73/comfyui-pod-setup/main/models.txt"
MODEL_LIST_TMP="/tmp/models.txt"

wget -O "$MODEL_LIST_TMP" "$MODEL_LIST_URL"

while read -r url path; do
    # Skip empty lines and comments
    [[ -z "$url" || "$url" =~ ^# ]] && continue
    mkdir -p "$(dirname "/workspace/$path")"
    wget -O "/workspace/$path" "$url"
done < "$MODEL_LIST_TMP"

# 7. Final message
echo "✅ Provisioning complete. Ready to launch ComfyUI."

# Optional: auto-launch ComfyUI (commented out for now)
# python /workspace/ComfyUI/main.py --listen 0.0.0.0 --port 7861 --highvram
