---
name: "CUDA Toolkit"
status: "stable"
---

NVIDIA CUDA toolkit pre-installed and configured for GPU-accelerated computing and deep learning frameworks.

## Status and Fedora Plans

Not intended for upstreaming to Fedora. Available in this image for developer convenience.

## Technical Details

Includes CUDA libraries, nvcc compiler, and cuDNN for deep learning acceleration. Configured to work with containerized AI frameworks.

## Usage

CUDA is available system-wide and in containers. PyTorch, TensorFlow, and other frameworks automatically detect and utilize GPU acceleration.
