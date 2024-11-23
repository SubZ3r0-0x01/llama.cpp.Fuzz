#!/bin/bash

# Script to set up and run fuzzing on the llama.cpp project using AFL

# List of required commands
required_commands=("git" "afl-gcc" "afl-g++" "make" "gcc" "g++")

# Function to check for required dependencies
check_dependencies() {
    for cmd in "${required_commands[@]}"; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            echo "Error: $cmd is not installed."
            exit 1
        fi
    done
}

# Function to clone the repository if not already cloned
clone_repository() {
    if [ ! -d "llama.cpp" ]; then
        git clone https://github.com/ggerganov/llama.cpp.git
        if [ $? -ne 0 ]; then
            echo "Error: Failed to clone the repository."
            exit 1
        fi
    fi
}

# Function to set environment variables for AFL compilers
set_env() {
    export CC=afl-gcc
    export cc=afl-gcc
    export CXX=afl-g++
    export cxx=afl-g++
}

# Function to compile the project with AFL and ASan
compile_project() {
    cd llama.cpp
    AFL_USE_ASAN=1 make -j $(nproc)
    if [ $? -ne 0 ]; then
        echo "Error: Compilation failed."
        exit 1
    fi
    cd ..
}

# Function to set up fuzzing directories
setup_fuzzing() {
    mkdir -p fuzzing/in fuzzing/out
    if [ $? -ne 0 ]; then
        echo "Error: Failed to create fuzzing directories."
        exit 1
    fi
}

# Function to list and select a model file
select_model() {
    if [ ! -d "llama.cpp/models" ]; then
        echo "Error: models directory not found."
        exit 1
    fi

    models=($(ls llama.cpp/models/ggml-vocab-*.gguf 2>/dev/null))
    if [ ${#models[@]} -eq 0 ]; then
        echo "Error: No model files found in llama.cpp/models directory."
        exit 1
    fi

    echo "Available models:"
    for i in "${!models[@]}"; do
        filename=$(basename "${models[$i]}")
        echo "$i: $filename"
    done

    while true; do
        read -p "Enter the number corresponding to your choice: " choice
        if [[ $choice =~ ^[0-9]+$ ]] && [ $choice -lt ${#models[@]} ]; then
            break
        else
            echo "Invalid choice. Please enter a valid number."
        fi
    done

    selected_model=${models[$choice]}
    echo "Selected model: $(basename $selected_model)"
}

# Function to copy the selected model to the seed corpus directory
copy_model() {
    cp "$selected_model" fuzzing/in/
    if [ $? -ne 0 ]; then
        echo "Error: Failed to copy the selected model to the seed corpus directory."
        exit 1
    fi
}

# Function to start the fuzzing process
start_fuzzing() {
    cd fuzzing
    afl-fuzz -i in -o out -M 1 -- ../llama.cpp/llama-cli -n 1 -m @@
    if [ $? -ne 0 ]; then
        echo "Error: Fuzzing process failed."
        exit 1
    fi
}

# Main function to execute all steps
main() {
    check_dependencies
    clone_repository
    set_env
    compile_project
    setup_fuzzing
    select_model
    copy_model
    start_fuzzing
}

# Execute the main function
main
