#!/bin/bash

# Check if folder name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <folder_name>"
  exit 1
fi

FOLDER_NAME=$1
TAR_FILE="${FOLDER_NAME}.tar"
GPG_FILE="${TAR_FILE}.gpg"

# Step 1: Compress the folder into a tar archive
echo "Compressing folder '$FOLDER_NAME'..."
tar -cvf "$TAR_FILE" "$FOLDER_NAME"

# Step 2: Encrypt the tar archive using gpg
echo "Encrypting the archive '$TAR_FILE'..."
gpg -c "$TAR_FILE"

# Step 3: Remove the unencrypted tar file
echo "Removing unencrypted tar file '$TAR_FILE'..."
rm "$TAR_FILE"

echo "Folder '$FOLDER_NAME' has been encrypted into '$GPG_FILE'."

# Ask if the user wants to decrypt the file
read -p "Do you want to decrypt and extract the file now? (y/n): " choice

if [ "$choice" = "y" ]; then
  # Step 4: Decrypt the gpg file
  echo "Decrypting '$GPG_FILE'..."
  gpg "$GPG_FILE"

  # Step 5: Extract the decrypted tar archive
  echo "Extracting '$TAR_FILE'..."
  tar -xvf "$TAR_FILE"

  # Optional: remove decrypted tar file after extraction
  echo "Removing decrypted tar file '$TAR_FILE'..."
  rm "$TAR_FILE"

  echo "Decryption and extraction complete."
else
  echo "You can decrypt the file later using: gpg $GPG_FILE"
fi

