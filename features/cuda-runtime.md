---
layout: feature
name: "CUDA Runtime"
status: "stable"
---

NVIDIA CUDA runtime libraries pre-installed for GPU-accelerated computing and deep learning frameworks.

## Status and Fedora Plans

Not intended for upstreaming to Fedora. Available in this image for developer convenience.

Note: This includes the CUDA runtime libraries only, not the full CUDA toolkit. The CUDA toolkit includes developer tools (nvcc compiler, etc.) that are not licensed for redistribution.

## Technical Details

Includes CUDA runtime libraries and cuDNN for deep learning acceleration. Configured to work with containerized AI frameworks.

## Usage

CUDA runtime is available system-wide and in containers. PyTorch, TensorFlow, and other frameworks automatically detect and utilize GPU acceleration. For CUDA development requiring the full toolkit (nvcc, etc.), install the toolkit separately or use NVIDIA's official container images.
