# Automatic Discord Update

This repository contains a Bash script and a service file to automatically update Discord on Linux systems.

## Usage

### Download and Installation

1. Copy the bash script wherever you want, I recommend in the /opt directory, which is designed for this purpose. 

2. Modify the service file to make it execute the script you've copied with the correct path.

3. Copy the service file to /etc/systemd/system/


### Service Activation

You can enable the updater with the following command:

```bash
sudo systemctl enable update-discord.service
```

### Starting the Service

You can also manually start the service with the following command:

```bash
sudo systemctl restart update-discord.service
```

### Stopping the Service

If necessary, you can stop the service with the following command:

```bash
sudo systemctl stop update-discord.service
```

### Disabling the Service

If you wish to disable the service, use the following command:

```bash
sudo systemctl disable update-discord.service
```
