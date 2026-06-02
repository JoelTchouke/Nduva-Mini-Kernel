# Use a stable, lightweight Linux base
FROM ubuntu:24.04

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install build tools and the AArch64 cross-compiler
RUN apt update && apt install -y \
    build-essential \
    gcc-aarch64-linux-gnu \
    make \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*


# Set the working directory inside the container
WORKDIR /workspace

# Default command keeps the container available or runs a build
CMD ["make"]
