#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

rpm -ivh https://codeberg.org/gordonmessmer/nvidia-open-kmod/releases/download/610.43.02-1/kmod-nvidia-open-610.43.02-1.fc44.x86_64.rpm https://codeberg.org/gordonmessmer/nvidia-open-kmod/releases/download/610.43.02-1/nvidia-open-kmod-610.43.02-1.fc44.x86_64.rpm

dnf config-manager addrepo --from-repofile=https://developer.download.nvidia.com/compute/cuda/repos/fedora/x86_64/cuda-fedora.repo

dnf5 -y install nvidia-open

#### Example for enabling a System Unit File

systemctl enable podman.socket
