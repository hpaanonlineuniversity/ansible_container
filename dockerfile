FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    openssh-client \
    sshpass \
    curl \
    git \
    iputils-ping \
    && pip3 install ansible

# Create devops user
RUN useradd -m -s /bin/bash devops

# Create workspace directory and SSH directory with proper permissions
RUN mkdir -p /home/devops/workspace && \
    mkdir -p /home/devops/.ssh && \
    chown -R devops:devops /home/devops && \
    chmod 700 /home/devops/.ssh

USER devops
WORKDIR /home/devops/workspace

# Default command
CMD ["/bin/bash"]