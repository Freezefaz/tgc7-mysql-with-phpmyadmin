# Insructions to install PhpMyAdmin

Demonstrate how to use PhpMyAdmin with a project created from the code institute Gitpod Template.

The commands are found in `install.sh` - the file is now automatically run as part of the `init_tasks.sh` script inside the `.theia` folder. If you are interested in just install PHPMyAdmin for an existing GitPod instance, you can just copy the script over in a .sh file (and be sure to set the executable permission with `chmod -u=rwx` on the file first!).

You still need to do one manual step to configure PHPMyAdmin correctly:

To setup PHPMyAdmin for GitPod:

1. Find the file `public/phpmyadmin/config.inc.php`
2. Look for the string `AllowNoPassword`
3. Change the line to read: `$cfg['Servers'][$i]['AllowNoPassword'] = true;` and *remember to save*
4. Start apache with `apachectl start` and when the pop-up appears, click `Open Browser`
5. At the browser, add `/phpmyadmin` to the end of the URL in the address bar
6. Login with user `root` and no password.

# Creating table in PHPMyAdmin

The primary key must be "unsigned" (under attributes), "auto increment" (chec)

# Using command prompt

1. Log in with "mysql -u root"

2. Switch database, if not create it:
    "create database pet_owners"
    once created, we switch to "use pet_hospital"

3. to quit mysql> exit

4. Have to install the py file -> pip3 install .py in the specific folder

5. To execute command python3 .py

6. To import new database -> mysql -u root < .sql