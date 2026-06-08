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

FEDORA=$(rpm -E %fedora)
dnf config-manager addrepo --from-repofile=https://developer.download.nvidia.com/compute/cuda/repos/fedora${FEDORA}/x86_64/cuda-fedora${FEDORA}.repo
dnf config-manager addrepo --from-repofile=https://project-resistor.codeberg.page/static/project-resistor-kernel.repo

# https://project-resistor-signed-logs-prod-us-west-2.s3.us-west-2.amazonaws.com/gpg-keys/gpg-signing-key.gpg
rpm --import - <<EOF
-----BEGIN PGP PUBLIC KEY BLOCK-----

mQINBGouZ+QBEACq2+lpCwvRHpVo2aBIBQYWwObJCoT6+V55iS2vsp8AOmOkQNDB
YniJBpcsVXJWL2wIbFRNmF7jd8d8cOOTtwihdmWXNFGbVcFSdVohRAzvVrR9WvB9
utNYM8pIQj3zg3QEYKUew0ih8H7Td/NqYuLDo5om+bFZvWYelzL/Q7dDfh2olfLZ
uG759aFfRRb+5DFm+Vgwtkjq7+H+02bd65byhWlsmHaCAAoTSMXy4FuYxZCqTFoZ
QE2GgfkE4XDqq7W2Tozju8OcN5MLvHU6mZeP49s+FH9eXjgL7H/76Vmk+FYwi3TP
y7brrfBVsHGMEG6MZ8DG18faMAV6Zk5hP+NDLrUKC0lXgwl3MpOvn7FPOHnXp5C+
BZMiDDW66sMnUnziIWz3IG8ViLY3a0bCzKGF0T8937I9a0sm/Wj0ERFfMbB3/K6T
PK4Gve2tKGRhQYWAKYUBo+VKccSkljsOQVfcI1y2VX095rxyGKEeCWU0+0iPu7wb
KjhHwMO9IO5iQgp3bH8bW7AwMbvTRBocnKduEQmB1hYp7iuVdAePfYGdv8jusoZV
+y9IqrX0MZZ7XT6Uq8g5pXdNtw1hOxsG2neAPWEAla95HD/bMwTy8MBLaq51oggP
/HI/BZigtqP+ULcEFq81yf/0PSL1z80SO0PHOBshEEBOqZp9kv4BAFY9/wARAQAB
tDtQcm9qZWN0IFJlc2lzdG9yIFJQTSBTaWduaW5nIDxzaWduaW5nQHByb2plY3Qt
cmVzaXN0b3Iub3JnPokCUgQTAQoAPBYhBHluOQLIvFd6tlIOufO67YfhqxYBBQJq
LmfkAxsvBAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgAAKCRDzuu2H4asWARp+
EACVXpBqkkrTCa6S8c1CAM/s+d9FQ/+oJnWxZvVnVB1lVx9T9gmq3BwuTq59gfh6
/TDkkqP2hs8DTYyeROElUfvUEdz9ILSJtd999zjvOYOxU7G7k2PDa1xvQHTrqPxu
AWQz7SkQXxtS9SCxTucGYXcU0C07o+EzZjqnHY6TWnRLyaB2BiocHQ10JcJJbitm
HyI3gWbazeVPi64fiuOHPs971VMVBs9jOH5tHaLy5q3mBZfV34ZT2zydQ1mPXnis
duUVDySk77/lw3wucXDGOTY4ckHb1XoqhwxmOl04MR1TbWRESK1AsE31NG+Q+Hrr
kT1Wx4JtNDZU5F7dLhOgK1qUg64ZBM406cvd9gj50k7gli3gEPDvHhA9WKcmbTTR
4O2ZfrCASJzgqPvl/5t6V37QctyA3DeHxbNKGpYV+ZovysLeKRFYy8HGYsuHU3fn
+n6gx5s/fzFm5DLNsG/uWEDEa+EVT5skQhBRra/yyomOd39tq8xkTCsFuXLlQ4dg
U/njpCmUXZN+A0Fj+D6y0mwloam524HMpFffCI7PfA6rSaPzwkT5JVecIU4rb0p1
Tz6e/miLFxHMoojRRNgMGrtC07DAhpCrRT4+fS9tLdLNz8f0pnPgSpjMy7dIuGtH
m1uETBnDrzB1nnQAzB0zsNqlkAI57Gcm44ewOQo6vewcWw==
=/lE/
-----END PGP PUBLIC KEY BLOCK-----
EOF

dnf install -y nvidia-open-kmod kmod-nvidia-open nvidia-driver nvidia-open

# nvidia kmod package includes bad post scripts. redo depmod here until they are fixed.
verrel=$(rpm -q kernel --qf '%{VERSION}-%{RELEASE}.%{ARCH}')
/usr/sbin/depmod -aeF "/lib/modules/${verrel}/System.map" "${verrel}"
