# [dev site on webfaction](http://myblog.suhailvs.webfactional.com) #

## Webfactional stuffs ##

+ username: `suhailvs`
+ appname: `suhails`
+ database name: `myblog`

## export mysql Database ##

goto: webfaction database: `myblog` -> then export `blog,blog_tags,tag`

+ Export Method: Custom - display all possible options
+ Format-specific options: structure and data
+ Object creation options: Add CREATE PROCEDURE / FUNCTION / EVENT statement 

### Import to mysql database:###

+ goto: webfaction create an new database.
+ Import the file **backup.sql** to that databse.
+ ssh to webfaction and run `python manage.py syncdb` to create other django tables.