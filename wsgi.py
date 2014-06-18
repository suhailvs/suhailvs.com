#!/usr/bin/python
import os,sys

# Activate the virtual env
virtenv = os.environ['OPENSHIFT_PYTHON_DIR'] + '/virtenv/'
virtualenv = os.path.join(virtenv, 'bin/activate_this.py')
try:execfile(virtualenv, dict(__file__=virtualenv))
except IOError:pass

# set the variable DJANGO_SETTINGS_MODULE="mysite.settings" to environ
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "mysite.settings")

# add OPENSHIFT_REPO_DIR(ie: '~/app-root/repo/www/') to system path
sys.path.append(os.environ['OPENSHIFT_REPO_DIR'])

# taken from django1.6 wsgi file
from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()