import os,sys

os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'

virtenv =os.path.join(os.environ['HOME'],'webapps','suhails','myenv','bin','activate_this.py')
#virtualenv = os.path.join(virtenv, 'bin/activate_this.py')
try:
    execfile(virtenv, dict(__file__=virtenv))
except IOError:
    pass

from django.core.handlers.wsgi import WSGIHandler

application = WSGIHandler()