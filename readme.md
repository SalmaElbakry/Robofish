# Robofish Dataset

This repository contains experimental data files for Robofish experiments, stored in MATLAB `.mat` format. These files are large and managed using [Git Large File Storage (Git LFS)](https://git-lfs.github.com/). To properly download them, you must install Git LFS before cloning the repository.

---

## 📦 Contents

- `data/`: Contains `.mat` files such as:
  - `RIGID_flow_40_angle_20_fre_1_dist_7.mat`
  - `RIGID_flow_80_angle_20_fre_1_dist_7.mat`
- These are MATLAB v5 format files that can be loaded in MATLAB or GNU Octave.

---

## 🚀 How to Clone This Repository Correctly

### ✅ Step 1: Install Git LFS

Git LFS must be installed **before cloning** the repository.

### 🔹 Linux (Ubuntu/Debian)

```bash
sudo apt update
sudo apt install git-lfs
git lfs install

### 🔹macOS (with Homebrew)
```bash
brew install git-lfs
git lfs install

### 🔹 Windows

    Download Git LFS: https://git-lfs.github.com/

    Run the installer.

    Open Git Bash and run:

    ```bash
    git lfs install

### ✅ Step 2: Install Git LFS

Once Git LFS is installed, clone the repository and pull the actual .mat files:

    ```bash
    git clone https://github.com/your-username/Robofish.git
    cd Robofish
    git lfs pull

This replaces Git LFS pointer files with the actual binary .mat files.

### 🔍 Verifying That Files Were Downloaded Correctly
To confirm the .mat file is valid:

    ```bash
    file data/RIGID_flow_40_angle_20_fre_1_dist_7.mat

Expected output:

Matlab v5 mat-file (little endian)

If it says ASCII text, then the real file was not downloaded — you likely skipped git lfs pull.