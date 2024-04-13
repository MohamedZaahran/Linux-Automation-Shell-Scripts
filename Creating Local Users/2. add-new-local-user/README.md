# Creating Local Users
An enhanced shell script to the previous *add-new-user.sh* version that adds users to the same Linux system with `automatic generation of passwords` and `supplying the username and comments as arguments in the command line` as the script is executed on.

## Case Scenario for using this script
The *add-local-user.sh* is amazing as it automates creating new accounts. However, there are a couple of things that can be made to enhance that script.
Imagine that you must assign a unique password to each account you create. Or assign the same password to all the accounts. It would be great if the **`script automatically generates a password for each new account`**. So those running the script won't have to even think about passwords any longer.

Also, it would be little more efficient if you could just **`specify the account name and account comments on the command line instead of being prompted for them`**. You already know what you are going to type so you would just rather type it all in at one time.
