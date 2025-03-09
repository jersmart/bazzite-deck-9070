FROM ghcr.io/ublue-os/bazzite-deck:stable

## Other possible base images include:
# FROM ghcr.io/ublue-os/bazzite:stable
# FROM ghcr.io/ublue-os/bluefin-nvidia:stable
# 
# ... and so on, here are more base images
# Universal Blue Images: https://github.com/orgs/ublue-os/packages
# Fedora base image: quay.io/fedora/fedora-bootc:41
# CentOS base images: quay.io/centos-bootc/centos-bootc:stream10

### MODIFICATIONS
## make modifications desired in your image and install packages by modifying the build.sh script
## the following RUN directive does all the things required to run "build.sh" as recommended.

COPY build.sh /tmp/build.sh
RUN chmod +x /tmp/build.sh

RUN mkdir -p /var/lib/alternatives && \
    rpm-ostree install kernel kernel-devel mesa-va-drivers mesa-vulkan-drivers mesa-libGL mesa-libEGL && \
    mkdir -p /etc/kernel/cmdline.d && \
    echo 'split_lock_detect=off' | tee -a /etc/kernel/cmdline.d/99-custom.conf && \
    /tmp/build.sh && \
    ostree container commit