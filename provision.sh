#!/bin/bash

# Download models.txt
wget https://raw.githubusercontent.com/crabico73/comfyui-pod-setup/main/models.txt -O /workspace/models.txt

# Download secure_model_download.sh
wget https://raw.githubusercontent.com/crabico73/comfyui-pod-setup/main/secure_model_download.sh -O /workspace/secure_model_download.sh
chmod +x /workspace/secure_model_download.sh

# Run it with your Hugging Face token
HF_TOKEN="hf_XXXXXXXXXXXXXXXXXXXXXXXX" /workspace/secure_model_download.sh
