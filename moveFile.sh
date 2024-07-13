#!/bin/bash

# Define directories
IMAGE_DIR="image"
PDF_DIR="pdf"
ZIP_DIR="zip"
SLIDE_DIR="slide"
VIDEO_DIR="video"
DOCS_DIR="docs"

# Function to create directories if they don't exist
create_directories() {
    for dir in "$IMAGE_DIR" "$PDF_DIR" "$ZIP_DIR" "$SLIDE_DIR" "$VIDEO_DIR" "$DOCS_DIR"; do
        if [ ! -d "$dir" ]; then
            mkdir "$dir"
        fi
    done
}

# Function to move files based on their type
move_files() {
    for file in *; do
        if [ -f "$file" ]; then
            if file "$file" | grep -q "image data"; then
                # Check if filename contains "WhatsApp"
                if echo "$file" | grep -q "WhatsApp"; then
                    # Move to WhatsApp folder in IMAGE_DIR
                    whatsapp_dir="$IMAGE_DIR/WhatsApp"
                    if [ ! -d "$whatsapp_dir" ]; then
                        mkdir -p "$whatsapp_dir"
                    fi
                    mv "$file" "$whatsapp_dir/"
                else
                    # Move to general IMAGE_DIR
                    mv "$file" "$IMAGE_DIR/"
                fi
            elif file "$file" | grep -q "PDF document"; then
                mv "$file" "$PDF_DIR/"
            elif file "$file" | grep -q "Zip archive"; then
                mv "$file" "$ZIP_DIR/"
            elif file "$file" | grep -q "Microsoft PowerPoint"; then
                mv "$file" "$SLIDE_DIR/"
            elif file "$file" | grep -q "MPEG-4"; then
                mv "$file" "$VIDEO_DIR/"
            elif file "$file" | grep -q "Composite Document File V2 Document"; then
                mv "$file" "$DOCS_DIR/"
            elif file "$file" | grep -q "Microsoft Word"; then
                mv "$file" "$DOCS_DIR/"
            elif file "$file" | grep -q "POSIX tar archive"; then
                mv "$file" "$ZIP_DIR/"
            fi
        fi
    done
}

# Main script 
cd ~/Downloads  

create_directories
move_files

echo "Files organized!"
