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

dnf config-manager addrepo --from-repofile=https://developer.download.nvidia.com/compute/cuda/repos/fedora44/x86_64/cuda-fedora44.repo
dnf config-manager addrepo --from-repofile=https://resistor-build-yum-prod.s3.us-west-2.amazonaws.com/project-resistor-kernel.repo
rpm --import https://project-resistor-signed-logs-prod-us-west-2.s3.us-west-2.amazonaws.com/gpg-keys/gpg-signing-key.gpg

dnf -y install nvidia-open

# nvidia kmod package includes bad post scripts. redo depmod here until they are fixed.
verrel=$(rpm -q kernel --qf '%{VERSION}-%{RELEASE}.%{ARCH}')
/usr/sbin/depmod -aeF "/lib/modules/${verrel}/System.map" "${verrel}"
