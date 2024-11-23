# Fuzzing Setup for llama.cpp using AFL

## Description
This project provides a simple script to set up and run fuzzing on the `llama.cpp` project using the American Fuzzy Lop (AFL) fuzzer. The script allows you to easily select a model file and set up the fuzzing environment, all through an interactive process.

## Table of Contents
- [Installation](#installation)
- [Usage](#usage)
- [Prerequisites](#prerequisites)
- [Troubleshooting](#troubleshooting)
- [Contributions](#contributions)
- [License](#license)

## Installation

1. **Ensure you have the necessary dependencies**:
    This script requires several tools to be installed on your system. You can install them using the following commands:

    ```bash
    sudo apt-get update
    sudo apt-get install git afl make gcc g++
    ```

2. **Clone the repository**:
    Clone this repository to your local machine:

    ```bash
    git clone https://github.com/SubZ3r0-0x01/llama.cpp.Fuzz.git
    cd llama.cpp.Fuzz
    ```

## Usage

1. **Download the setup script**:
    In the project directory, download the `fuzzing_setup.sh` script:

    ```bash
    wget https://github.com/SubZ3r0-0x01/llama.cpp.Fuzz/raw/main/llama.sh
    ```

2. **Make the script executable**:
    Give execute permissions to the script:

    ```bash
    chmod +x llama.sh
    ```

3. **Run the setup script**:
    Execute the script to set up the fuzzing environment. The script will walk you through the process, including selecting a model file for fuzzing.

    ```bash
    ./llama.sh
    ```

    The script will:
    - Clone the `llama.cpp` repository if it's not already present.
    - Set up the AFL environment.
    - Compile the project with AFL.
    - Create directories for fuzzing inputs and outputs.
    - Let you select a model file from the available models.
    - Start fuzzing using AFL.

4. **Monitor the fuzzing process**:
    Once the fuzzing process starts, you can monitor the progress in the `fuzzing/out` directory.

## Prerequisites

- **llama.cpp repository**: The script will clone the `llama.cpp` repository if it's not already available.
- **Model files**: Ensure that model files are available in the `llama.cpp/models` directory for selection during fuzzing.
- **Permissions**: Make sure you have the necessary permissions to execute scripts and write to directories.

## Troubleshooting

- **Missing Dependencies**:
  If you encounter issues with missing tools, make sure the dependencies are installed by following the instructions in the [Installation](#installation) section.

- **Model Files Not Found**:
  The script expects model files in the `llama.cpp/models` directory. If no models are found, ensure the files are present and correctly named (e.g., `ggml-vocab-*.gguf`).

- **Compilation Issues**:
  If the `make` command fails during compilation, check the error message for missing dependencies or other issues related to your system configuration.

- **Permissions Issues**:
  Ensure you have permission to write to the directories you're working with. If needed, use `chmod` to modify file permissions.

## Contributions

Contributions are welcome! If you find bugs, have suggestions, or would like to add new features, feel free to:
1. Open an issue for reporting bugs or asking questions.
2. Fork the repository and submit a pull request with your changes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
