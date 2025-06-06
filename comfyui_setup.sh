#!/bin/bash

set -e

echo "🔧 Starting custom provisioning for ComfyUI..."

# 1. Activate the Python virtual environment (if it exists)
if [ -f "/workspace/ComfyUI/venv/bin/activate" ]; then
    source /workspace/ComfyUI/venv/bin/activate
else
    echo "⚠️  Virtual environment not found. Skipping activation."
fi

# 2. Install essential Python packages (if needed)
echo "📦 Installing missing Python packages..."
pip install --upgrade pip
pip install safetensors torch torchvision torchaudio torchsde

# 3. Download your custom workflow JSON
mkdir -p /workspace/ComfyUI/workflows
curl -L "https://example.com/vace_v2v_example_workflow.json" -o /workspace/ComfyUI/workflows/vace_v2v_example_workflow.json

# 4. Clone essential custom nodes
cd /workspace/ComfyUI/custom_nodes

echo "🔌 Installing ComfyUI-Manager..."
git clone https://github.com/ltdrdata/ComfyUI-Manager.git || echo "Already exists."

# Add more nodes here as needed:
# git clone https://github.com/<your-preferred-node>.git

# 5. Optional: Download models (placeholders)
mkdir -p /workspace/ComfyUI/models/checkpoints
# curl -L "https://huggingface.co/some-model.ckpt" -o /workspace/ComfyUI/models/checkpoints/your_model.ckpt

# 6. Final message
echo "✅ Custom provisioning complete. You can now launch ComfyUI."

# Optional: launch ComfyUI automatically
# python /workspace/ComfyUI/main.py --listen 0.0.0.0 --port 7861 --highvram
