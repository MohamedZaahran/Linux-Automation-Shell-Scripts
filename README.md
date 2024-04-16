# Linux-Automation-Shell-Scripts
Discover 6 crafted shell scripts tailored to automate a variety of mundane and time-consuming tasks within the Linux environment. Streamlining the workflow and boosting productivity.

### 1. [add-local-user.sh](Scripts/add-local-user.sh)
**Description:** Adds users to the Linux system as the script is executed on. It prompts you to enter the *USERNAME*, *COMMENT*, and *PASSWORD* to supply.

**Case Scenario:** Imagine that you are a Linux administrator and are constantly being interrupted by the help desk calling you to create new Linux accounts for all the people in the company. This script will save you!

**Usage:** `./add-local-user.sh`

---
### 2. [add-new-local-user.sh](Scripts/add-new-local-user.sh)
**Description:** Enhanced shell script that adds users to the Linux system, and has an *automatic generation of random passwords* and *supplying the **`USERNAME`** and **`COMMENT`** as arguments in the command line* as the script is executed.

**Case Scenario:** Imagine that you must assign a unique password to each account you create. Or assign the same password to all the accounts. So those running the script won't have to even think about passwords any longer.

**Usage:** `./add-new-local-user.sh USER_NAME [COMMENT]...`

---
### 3. [generate-password.sh](Scripts/generate-password.sh)
**Description:** Generates random passwords. Users can specify the length with ***`-l LENGTH`*** and choose to include a special character with ***`-s`***. Verbose mode is available for additional output with ***`-v`***. It uses cryptographic methods to create secure passwords.

**Usage:** `./generate-password.sh [-vs] [-l LENGTH]`

---
### 4. [disable-local-user.sh](Scripts/disable-local-user.sh)
**Description:** Disables, deletes, and/or archives users on the local system. Administrators can specify options to disable or delete ***`-d`*** user accounts with the possibility of removing associated home directories ***`-r`***. Additionally, the script provides an option to create archives of user home directories ***`-a`*** for data backup purposes.

**Case Scenario:** Imagine that you are a Linux administrator and are constantly being interrupted by the help desk calling you to periodically disable/delete Linux accounts for some users. Instead of manually performing these tasks one by one, which can be time-consuming and error-prone. This script allows you to automate the process of disabling, deleting, or archiving multiple user accounts in a single execution, saving you valuable time and ensuring consistency in user management operations across the system.

**Usage:** `./disable-local-user.sh [-dra] USER [USERN]...`

---
### 5. [run-everywhere.sh](Scripts/run-everywhere.sh)
**Description:** Enables the execution of a specified command across multiple servers from an admin server. By default, it reads server names from a predefined file, but you can override this behavior with the ***`-f`*** option. Other options include ***`-n`*** for dry run mode (which displays the command without executing it), ***`-s`*** for executing the command with sudo, and ***`-v`*** for verbose mode (which displays the server name before executing the command).

**Case Scenario:** The number of systems you manage is growing and you need a way to quickly execute the exact same command on all of your systems. Because it takes too much of your time to type the same command on every single system you manage, you decide to use that script that will do this for you.
<br>Let's say you need to update the software packages on all servers. Instead of logging into each server individually and running the update command, you can use this script. By specifying the update command along with the appropriate options, you can execute it across all servers with a single command.
<br>This not only saves you time but also reduces the risk of human error, making server management more streamlined and reliable.

**Usage:** `./run-everywhere.sh [-nsv] [-f FILE] COMMAND`

---
### 6. [show-attackers.sh](Scripts/show-attackers.sh)
**Description:** This script analyzes syslog data to identify failed login attempts by IP address. It generates a CSV file listing IP addresses with more than 10 failed attempts along with their respective locations.

**Case Scenario:** Imagine you're a security administrator responsible for monitoring login activity on a network of servers. Each day, you receive syslog files containing login data from multiple servers. Your task is to analyze this data to identify potential security threats, such as brute-force login attempts. Without automation, analyzing these syslog files manually would be a tedious and time-consuming process. This script automates that painful process, streamlining the analysis process, and allowing you to quickly pinpoint suspicious activity and take appropriate action to enhance network security.

**Usage:** `./show-attackers.sh FILE_NAME`

---
### 7. [extract-open-ports.sh](Scripts/extract-open-ports.sh)
**Description:** Displays the open network ports on a system, sorting them in ascending order. By default, it shows all open TCP and UDP ports. Optionally, you can provide the ***`-4`*** to limit the output to TCPv4 ports only.

**Case Scenario:** Imagine you are a system administrator responsible for managing multiple servers, you can quickly identify which network ports are currently open on a server and identify potential security vulnerabilities.

**Usage:** `./extract-open-ports.sh [-4]`
