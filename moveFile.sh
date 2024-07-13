#!/bin/bash

# Define directories
declare -A file_types=(
    ["jpg"]="image"
    ["jpeg"]="image"
    ["png"]="image"
    ["gif"]="image"
    ["pdf"]="pdf"
    ["zip"]="zip"
    ["tar"]="zip"
    ["ppt"]="slide"
    ["pptx"]="slide"
    ["mp4"]="video"
    ["avi"]="video"
    ["mkv"]="video"
    ["docx"]="docs"
    ["doc"]="docs"
    ["json"]="json"
    ["txt"]="text"
    ["svg"]="image"
    ["html"]="html"
    ["xlsx"]="excel"
    ["cpp"]="code"
    ["torrent"]="torrent"
    ["vcf"]="contacts"
    ["kt"]="code"
    ["xml"]="xml"
    ["mhtml"]="html"
    ["csv"]="csv"
    ["js"]="code"
    ["opus"]="audio"
    ["pub"]="docs"
    ["py"]="code"
    ["md"]="docs"
    ["drawio"]="docs"
    ["epub"]="ebooks"
   
)

# Function to move files based on their extension
move_files() {
    for file in *.*; do
        if [ -f "$file" ]; then
            file_ext="${file##*.}"  # Get the file extension
            file_ext_lower=$(echo "$file_ext" | tr '[:upper:]' '[:lower:]')  # Convert extension to lowercase
            dest_dir="${file_types[$file_ext_lower]}"
            
            if [ -n "$dest_dir" ]; then
                mkdir -p "$dest_dir"
                mv "$file" "$dest_dir/"
                echo "Moved '$file' to '$dest_dir/'"
            else
                echo "No target directory found for '$file', skipping."
            fi
        fi
    done
}

# Main script 
cd ~/Downloads || exit 1 

move_files

echo "File organization completed!"
