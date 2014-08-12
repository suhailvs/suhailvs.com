# [suhails.in](http://suhails.in) #

### Openshift credentials ###

+ username: `suhailvs@gmail.com`
+ clone: `git clone ssh://53a0d9e05973cad542000331@www-suhailvs.rhcloud.com/~/git/www.git/`
+ ssh: `53a0d9e05973cad542000331@www-suhailvs.rhcloud.com`

### export Openshift mysql Database ###

goto: `http://suhails.in/phpmyadmin` -> then export `blog,blog_tags,tag`

+ Export Method: Custom - display all possible options
+ Format-specific options: structure and data
+ Object creation options: Add CREATE PROCEDURE / FUNCTION / EVENT statement 

### Import to local mysql database:###

Import the file **backup_aug12.sql** to local mysql database:

    mysql -u <username> -p<pass> <dbname> < backup_aug12.sql
