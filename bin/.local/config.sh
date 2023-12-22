#!/bin/bash
# Specify the directory containing your scripts
script_dir="/home/clack/dotfiles/configs/scripts"

Check if the directory exists
if [ ! -d "$script_dir" ]; then
  echo "Error: Directory $script_dir not found."
  exit 1
fi

# Loop through each file in the directory
for script_file in "$script_dir"/*; do
 if [ "$script_file" != "config.sh" ]; then
    script_name=$(basename "$script_file")
    echo $script_name
    
    chmod +x $script_file
    ln -s "$script_file" "/usr/bin/$script_name"

    # Print a message indicating the linking process
    echo "Linked $script_name to /usr/bin/"
 fi
done

echo "Script linking complete."
