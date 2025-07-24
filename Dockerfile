FROM ubuntu:20.04

# Install essentials and GoTTY dependencies
RUN apt-get update && \
    apt-get install -y wget curl net-tools nano iputils-ping && \
    apt-get install -y openssh-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and install GoTTY (web terminal)
RUN wget https://github.com/yudai/gotty/releases/download/v0.2.0/gotty_linux_amd64.tar.gz && \
    tar -xzf gotty_linux_amd64.tar.gz && \
    mv gotty /usr/local/bin && \
    chmod +x /usr/local/bin/gotty && \
    rm gotty_linux_amd64.tar.gz

# Create a fake user to run terminal safely
RUN useradd -m webuser

# Set working directory
WORKDIR /home/webuser

# Expose GoTTY's web port
EXPOSE 8080

# Run bash shell in safe mode using GoTTY
CMD ["gotty", "--port", "8080", "--permit-write", "--reconnect", "bash"]
