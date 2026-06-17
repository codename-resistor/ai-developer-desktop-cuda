---
name: "Pre-built NVIDIA Open Kernel Modules"
status: "stable"
---

NVIDIA open kernel modules pre-installed and signed, eliminating post-installation driver compilation and the reliability issues of DKMS/akmods.

## Status and Fedora Plans

Ready to use. Cannot be shipped in Fedora due to current policy prohibiting out-of-tree kernel modules.

The Nova in-tree GPU driver is expected to render this work unnecessary later in 2026, at which point NVIDIA support will be available in stock Fedora.

The code signing infrastructure used to build these modules is functional and available for other projects interested in secure kernel module builds.

## Technical Details

Uses pre-built kernel modules from Project Resistor's secure build infrastructure with AWS KMS signing. Modules are built in a controlled environment and tested before deployment.

## Usage

Drivers are active immediately after installation on supported NVIDIA hardware. Users must install the Project Resistor signing certificate in their MOK.
