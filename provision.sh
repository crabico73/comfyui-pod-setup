#!/bin/bash

# === CONFIGURATION ===
# Hugging Face token (replace with your real token, or export it before calling)
HF_TOKEN="hf_your_token_here"

# models.txt location (downloaded from your GitHub repo)
MODELS_FILE="/workspace/models.txt"

# === FUNCTIONS ===

# Downloads a model using curl with authentication
download_model() {
    URL="$1"
    DEST="$2"

    echo "➡️ Downloading: $URL"
    echo "📁 Saving to: $DEST"
    mkdir -p "$(dirname "$DEST")"
    curl -L -H "Authorization: Bearer $HF_TOKEN" "$URL" -o "$DEST"

    # Check result
    if [ $? -ne 0 ]; then
        echo "❌ Failed to download $URL"
    else
        echo "✅ Downloaded $DEST"
    fi
}

# === MAIN LOOP ===

echo "🔍 Reading from $MODELS_FILE"
while IFS= read -r line || [[ -n "$line" ]]; do
    URL=$(echo "$line" | awk '{print $1}')
    DEST=$(echo "$line" | awk '{print $2}')
    if [[ -n "$URL" && -n "$DEST" ]]; then
        download_model "$URL" "/workspace/$DEST"
    fi
done < "$MODELS_FILE"

echo "✅ All requested models processed."
