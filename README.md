# Linux-Automation-Shell-Scripts
Discover 6 crafted shell scripts tailored to automate a variety of mundane and time-consuming tasks within the Linux environment. Streamlining the workflow and boosting productivity.

### 1. [add-local-user.sh](Scripts/add-local-user.sh)
**Description:** Adds users to the Linux system as the script is executed on. It prompts to enter the *USERNAME*, *COMMENT*, and *PASSWORD* to supply.<br>
**Case Scenario:** Imagine that you are a Linux administrator and are constantly being interrupted by the help desk calling you to create new Linux accounts for all the people in the company. This script will save you!

**Usage:** `./add-local-user.sh`

---
### 2. [add-new-local-user.sh](Scripts/add-new-local-user.sh)
**Description:** Enhanced shell script that adds users to the Linux system, and has an *automatic generation of random passwords* and *supplying the USERNAME and COMMENT as arguments in the command line* as the script is executed.<br>
**Case Scenario:** Imagine that you must assign a unique password to each account you create. Or assign the same password to all the accounts. So those running the script won't have to even think about passwords any longer.

**Usage:** `./add-local-user.sh USER_NAME [COMMENT]...`

---
### 3. [generate-password.sh](Scripts/generate-password.sh)
**Description:** Generates random passwords. Users can specify the length with *-l LENGTH* and choose to include a special character with *-s*. Verbose mode is available for additional output with *-v*. It uses cryptographic methods to create secure passwords.<br>

**Usage:** `./generate-password.sh [-vs] [-l LENGTH]`

---
### 4. [extract-open-ports.sh](Scripts/extract-open-ports.sh)
**Description:** Displays the open network ports on a system, sorting them in ascending order. By default, it shows all open TCP and UDP ports. Optionally, you can provide the *-4* to limit the output to TCPv4 ports only.<br>
**Case Scenario:** Imagine you are a system administrator responsible for managing multiple servers, you can quickly identify which network ports are currently open on a server and identify potential security vulnerabilities.

**Usage:** `./extract-open-ports.sh [-4]`
