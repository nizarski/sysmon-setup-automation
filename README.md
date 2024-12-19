# Fully Automated Sysmon Setup

This repository provides an automated setup for Sysmon, a powerful tool for monitoring and logging system activities on Windows. The setup includes configuring Sysmon logs and increasing log size to ensure better visibility into system events.

## Setup Instructions

1. **Run `Sysmon_setup.bat`**  
   This batch file automates the installation and configuration of Sysmon, setting up the necessary rules and log settings for monitoring.

2. **Run `YamatoSecurityConfigureWinEventLogs.bat`**  
   This script configures Windows Event Logs to optimize logging settings. It is a modified version based on the source from [Yamato-Security/EnableWindowsLogSettings](https://github.com/Yamato-Security/EnableWindowsLogSettings).

   The modifications in this version aim to improve log retention and increase the log size, ensuring a more efficient logging system for Windows event monitoring.

## Files in this Repository

- `Sysmon_setup.bat`: Automated Sysmon installation and configuration.
- `YamatoSecurityConfigureWinEventLogs.bat`: Configures and increases Windows Event Log retention and size based on the Yamato-Security configuration.

## Notes

- Ensure that you have the necessary administrator privileges to run these scripts on your machine.
- These scripts are intended for fast Sysmon setup on lab environments.
- Be cautious when applying these settings on production systems, as it could impact performance or logging behavior.
