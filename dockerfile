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

# Create student user
RUN useradd -m -s /bin/bash student

# Create workspace directory and SSH directory with proper permissions
RUN mkdir -p /home/student/workspace && \
    mkdir -p /home/student/.ssh && \
    chown -R student:student /home/student && \
    chmod 700 /home/student/.ssh

USER student
WORKDIR /home/student/workspace

# Default command
CMD ["/bin/bash"]