#!/bin/bash

# === CONFIGURATION ===
HF_TOKEN="${HF_TOKEN:-}"

if [ -z "$HF_TOKEN" ]; then
  echo "❌ Error: HF_TOKEN is not set."
  echo "Please export HF_TOKEN in your provision script or environment."
  exit 1
fi

MODELS_FILE="/workspace/models.txt"

# === FUNCTIONS ===

download_model() {
    URL="$1"
    DEST="$2"

    echo "➡️ Downloading: $URL"
    echo "📁 Saving to: $DEST"
    mkdir -p "$(dirname "$DEST")"
    curl -L -H "Authorization: Bearer $HF_TOKEN" "$URL" -o "$DEST"

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
