-- phpMyAdmin SQL Dump
-- version 4.0.10.2
-- http://www.phpmyadmin.net
--
-- Host: 127.10.200.130:3306
-- Generation Time: Oct 09, 2014 at 03:40 AM
-- Server version: 5.5.37
-- PHP Version: 5.3.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `www`
--

-- --------------------------------------------------------

--
-- Table structure for table `blog_blog`
--

CREATE TABLE IF NOT EXISTS `blog_blog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `content` longtext NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

--
-- Dumping data for table `blog_blog`
--

INSERT INTO `blog_blog` (`id`, `title`, `content`, `created`, `updated`) VALUES
(1, 'A minimal Django file upload example', 'Start a Django Project\r\n======================\r\n\r\n**1). Create a project: django-admin.py startproject sample**\r\n\r\nnow a folder(**sample**) is created::\r\n	\r\n	sample/\r\n		manage.py\r\n		sample/\r\n			__init__.py\r\n			settings.py\r\n			urls.py\r\n			wsgi.py	\r\n\r\n**2). On setting.py add:**::\r\n	\r\n	MEDIA_ROOT = os.path.join(BASE_DIR, ''media'')\r\n	MEDIA_URL = ''/media/''\r\n\r\n**4). `urls.py` add:**::\r\n\r\n	...<other imports>...\r\n	from django.conf import settings\r\n	from django.conf.urls.static import static\r\n	\r\n	urlpatterns = patterns('''',\r\n		url(r''^upload/$'', ''uploader.views.home'', name=''imageupload''),\r\n		...<other url patterns>...\r\n	)+ static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)\r\n\r\nCreate a Django App\r\n===================\r\n\r\n**5). Create an app: `python manage.py startapp uploader`**\r\n\r\n**6). Now a folder(`uploader`) with these files are created:**\r\n::\r\n\r\n	uploader/\r\n		__init__.py\r\n		models.py\r\n		admin.py\r\n		tests.py\r\n		views.py			\r\n		\r\n\r\n**7). On `setting.py` -> `INSTALLED_APPS` add `''uploader'',`, ie:**\r\n::\r\n\r\n	INSTALLED_APPS = (\r\n		...\r\n		''uploader'',\r\n		...\r\n	)\r\n\r\n\r\n**8) update `models.py`**\r\n::\r\n\r\n	from django.db import models\r\n	from django.forms import ModelForm\r\n\r\n	class Upload(models.Model):\r\n	    pic = models.ImageField("Image", upload_to="images/")    \r\n	    upload_date=models.DateTimeField(auto_now_add =True)\r\n\r\n	# FileUpload form class.\r\n	class UploadForm(ModelForm):\r\n		class Meta:\r\n			model = Upload\r\n\r\n\r\n**9) update `views.py`**\r\n::\r\n\r\n	from django.shortcuts import render\r\n	from uploader.models import UploadForm,Upload\r\n	from django.http import HttpResponseRedirect\r\n	from django.core.urlresolvers import reverse\r\n	# Create your views here.\r\n	def home(request):\r\n		if request.method=="POST":\r\n			img = UploadForm(request.POST, request.FILES)		\r\n			if img.is_valid():\r\n				img.save()	\r\n				return HttpResponseRedirect(reverse(''imageupload''))\r\n		else:\r\n			img=UploadForm()\r\n		images=Upload.objects.all()\r\n		return render(request,''home.html'',{''form'':img,''images'':images})\r\n\r\n\r\n**10). Create a folder `templates` and create a file `home.html`:**\r\n::\r\n\r\n	<div style="padding:40px;margin:40px;border:1px solid #ccc">\r\n		<h1>picture</h1>\r\n		<form action="#" method="post" enctype="multipart/form-data">\r\n			{% csrf_token %} {{form}} \r\n			<input type="submit" value="Upload" />\r\n		</form>\r\n		{% for img in images %}\r\n			{{forloop.counter}}.<a href="{{ img.pic.url }}">{{ img.pic.name }}</a>\r\n			({{img.upload_date}})<hr />\r\n		{% endfor %}\r\n	</div>\r\n\r\n\r\nFinal Project tree:\r\n===================\r\n::\r\n\r\n	sample/\r\n		manage.py\r\n		sample/\r\n			__init__.py\r\n			settings.py\r\n			urls.py\r\n			wsgi.py				\r\n		uploader/\r\n			__init__.py\r\n			models.py\r\n			views.py			\r\n			templates/\r\n				home.html \r\n\r\n\r\n11). Syncronize database and runserver:\r\n=======================================\r\n::\r\n\r\n	python manage.py syncdb\r\n	python manage.py runserver\r\n\r\n	visit <http://localhost.com:8000>', '2014-06-19 07:00:59', '2014-06-19 07:00:59'),
(2, 'Mail setup on django using Gmail', '###First Create an Application specific password\r\n\r\n1. Visit your [Google Account security page](https://www.google.com/settings/security).\r\n2. In the `2-Step Verification` box, click `Settings`(if there is no settings link, you may want to create a new one. you can skip step 3 & 4).\r\n3. Click the tab for `App-specific passwords`.\r\n4. Click `Manage your application specific passwords`.\r\n5. Under the `Application-specific passwords` section, enter a descriptive name for the application you want to authorize, such as "Django gmail" then click `Generate application-specific password` button.\r\n6. note down the password. for example: `smbumqjiurmqrywn` ![password][1]\r\n\r\n### Then add the appropriate values to settings.py:\r\n\r\n    EMAIL_HOST = ''smtp.gmail.com''\r\n    EMAIL_HOST_USER = ''your-username@gmail.com''\r\n    EMAIL_HOST_PASSWORD = ''Application spectific password(for eg: smbumqjiurmqrywn)''\r\n    EMAIL_PORT = 587\r\n    EMAIL_USE_TLS = True\r\n\r\n\r\n### You can use the shell to test it:\r\n\r\n    python manage.py shell\r\n    >>> from django.core.mail import send_mail\r\n    >>> send_mail(''Test'', ''This is a test'', ''your@email.com'', [''toemail@email.com''],\r\n         fail_silently=False)\r\n\r\n\r\n  [1]: http://i.stack.imgur.com/fNxSx.png', '2014-06-21 03:26:43', '2014-06-21 03:26:43'),
(3, 'Publish pages in Github', '\r\n###1) Get out of current repo and make a fresh clone:\r\n    \r\n    cd ..\r\n    git clone https://github.com/danielfpedro/simple-modal.git simple-modal-webpage\r\n\r\n### 2) Create a gh-pages branch(without any parents) and remove all content from the working directory and index:\r\n\r\n    cd simple-modal-webpage\r\n    git checkout --orphan gh-pages\r\n    git rm -rf . \r\n\r\n### 3) Add content and push\r\n\r\n    echo "My GitHub Page" > index.html\r\n    git add index.html\r\n    git commit -a -m "First pages commit"\r\n    git push origin gh-pages\r\n\r\nAfter your push to the `gh-pages` branch, your Project Page will be available at `danielfpedro.github.io/simple-modal`\r\n\r\n###4) Delete the cloned folder(`simple-modal-webpage`) and pull the branch `gh-pages` in original repo(`simple-modal`):\r\n\r\n    cd ..\r\n    rm -r simple-modal-webpage\r\n    cd simple-modal\r\n    git fetch   \r\n\r\n### 5) that is it, now you have 1 more branch `gh-pages`. use it to commit changes for github webpage:\r\n\r\n    git checkout gh-pages\r\n    <make changes to documentation>\r\n    git add .\r\n    git commit -m "documentation improvements"\r\n    git push -u origin gh-pages\r\n    \r\n    \r\n', '2014-06-21 03:28:28', '2014-07-03 05:56:58'),
(4, 'Merge two commits into one.', 'This is an update of the [stackoverflow_answer](http://stackoverflow.com/a/2568581/2351696)\r\n\r\nSay your history is\r\n\r\n    $ git log --pretty=oneline\r\n    a931ac7c808e2471b22b5bd20f0cad046b1c5d0d c\r\n    b76d157d507e819d7511132bdb5a80dd421d854f b\r\n    df239176e1a2ffac927d8b496ea00d5488481db5 a\r\n\r\nThat is, a was the first commit, then b, and finally c.\r\n\r\nRunning `git rebase --interactive HEAD~2` gives you an editor with\r\n\r\n    pick b76d157 b\r\n    pick a931ac7 c\r\n\r\n    # Rebase df23917..a931ac7 onto df23917\r\n    #\r\n    # Commands:\r\n    #  p, pick = use commit\r\n    #  r, reword = use commit, but edit the commit message\r\n    #  e, edit = use commit, but stop for amending\r\n    #  s, squash = use commit, but meld into previous commit\r\n    #  f, fixup = like "squash", but discard this commit''s log message\r\n    #\r\n    # If you remove a line here THAT COMMIT WILL BE LOST.\r\n    # However, if you remove everything, the rebase will be aborted.\r\n   \r\n\r\n**Note:**You cannot change the newest commit(b''s) `pick` to `squash`.\r\nYou squash old commits(for eg: c),ie:\r\n\r\n    pick b76d157 b\r\n    s a931ac7 c\r\n\r\nand save-quitting your editor, you''ll get another editor whose contents are\r\n\r\n    # This is a combination of 2 commits.\r\n    # The first commit''s message is:\r\n\r\n    b\r\n\r\n    # This is the 2nd commit message:\r\n\r\n    c\r\n\r\nWhen you save and quit, the contents of the edited file become commit message of the new combined commit:\r\n\r\n    $ git log --pretty=oneline\r\n    18fd73d3ce748f2a58d1b566c03dd9dafe0b6b4f b and c\r\n    df239176e1a2ffac927d8b496ea00d5488481db5 a', '2014-06-21 03:46:06', '2014-07-03 06:53:45'),
(5, 'Creating a Custom TEMPLATE_CONTEXT_PROCESSORS in Django.', '### a sample TEMPLATE_CONTEXT_PROCESSORS\r\n\r\nadd a file say `custom_processors.py` to any of your app with these codes:\r\n\r\n    def greetings(request):\r\n        from datetime import datetime	\r\n        curtime=datetime.today()\r\n	\r\n        if curtime.hour < 12:\r\n            msg= "Good Morning!"\r\n        elif curtime.hour >= 12 and curtime.hour < 18:\r\n            msg= "Good AfterNoon!"\r\n        else:\r\n            msg= "Good Evening!"\r\n\r\n        return {\r\n                ''say_hello'':msg,\r\n                ''say_bye'':"Good Bye",\r\n            }\r\n\r\nadd it to `settings.py` `TEMPLATE_CONTEXT_PROCESSORS` like:\r\n\r\n    TEMPLATE_CONTEXT_PROCESSORS=(\r\n        ...\r\n        ''<appname>.custom_processors.greetings'',\r\n    )\r\n\r\nif there isn''t any `TEMPLATE_CONTEXT_PROCESSORS` variable in `settings.py` then import and append it:\r\n\r\n    from django.conf.global_settings import TEMPLATE_CONTEXT_PROCESSORS\r\n    TEMPLATE_CONTEXT_PROCESSORS += (''<appname>.custom_processors.greetings'',)\r\n\r\nNow you can use `{{say_hello}}` or `{{say_bye}}` in any of your template. It just output `Good Morning/AfterNoon/Evening` (based on server time) , and output `Good Bye` for second **context**.', '2014-06-22 02:44:12', '2014-09-19 01:08:16'),
(6, 'Generate special mathematical symbols and formulae in HTML.', 'Today I am going to write about how to put mathematical formulas into html.\r\n\r\nI found most people solve this problem by create images of the formulas and put that image in appropriate places by tag `<img>`. \r\n\r\nThat is a bad approach, since \r\n\r\n+ it is hard to store images.\r\n+ Loading time will be very slow\r\n+ hard to edit the formulas\r\n\r\nSo I searched and find a wonderful java-script library  [**Mathjar**](http://www.mathjax.org/).\r\n\r\nHere a basic [jsfiddel demo](http://jsfiddle.net/sgJ59/)', '2014-06-29 12:58:19', '2014-06-29 12:58:19'),
(8, 'simple jquery SELECT2 ajax example', 'please refer: [this](http://www.southcoastweb.co.uk/jquery-select2-ajax-tutorial/) and [this so answer](http://stackoverflow.com/a/18497409/2351696)\r\n\r\n## urls.py\r\n\r\n    url(r''^ajax/(pincodes)/$'',''ajax_requests''),\r\n\r\n## view.py\r\n\r\n    def ajax_requests(request,param):\r\n        if param==''pincodes'':\r\n            q=request.GET[''q'']\r\n            resp=[dict(id=c.pk,text=c.code_postal) for c in Pincode.objects.filter(code_postal__contains=q)[:10]]\r\n            return HttpResponse(json.dumps(resp), content_type="application/json")    \r\n\r\n## template.html\r\n\r\n    <link rel="stylesheet" type="text/css" href="{% static "select2/select2.css" %}">\r\n    <script src="{% static "select2/select2.js" %}"></script>\r\n\r\n    <script type="text/javascript"> \r\n    $(document).ready(function () {\r\n      var $cmb_multi = $(''#id_code_postal_immo'');  \r\n      $cmb_multi.removeClass(''form-control'');  \r\n      $cmb_multi.select2({\r\n        multiple: true,\r\n        placeholder: "Pick Postal codes",\r\n        minimumInputLength: 2,\r\n        ajax: {\r\n          url: "/frontprop/ajax/pincodes/",\r\n          dataType: ''json'',\r\n          data: function (term, page) {\r\n            return { q: term};\r\n          },\r\n          results: function (data, page) {\r\n            return { results: data };\r\n          }\r\n        }\r\n      });\r\n    });\r\n    </script>', '2014-07-02 18:20:33', '2014-07-02 18:20:33'),
(9, 'git add files to last commit', 'If you ever find that you accidentally left something out of your last commit, be it a file or an extra change to a file that you just committed, don''t worry. It can easily be fixed\r\n\r\nAll you have to do is stage the extra changes like you would for a normal commit:\r\n\r\n    git add .\r\n\r\nAnd then just commit with the `--amend` argument.\r\n\r\n    git commit --amend\r\n\r\nYou will be prompted with the previous commit message as a default. save-quitting your editor, You''re done.\r\n\r\nyou can check git graphical tools(like `gitg` or `gitk`) to see your amended commit with the extra changes.', '2014-07-03 07:01:02', '2014-07-03 07:01:02'),
(10, 'Call External Shell Commands in Python using the subprocess Module', 'The subprocess module allows you to spawn new processes, connect to their input/output/error pipes, and obtain their return codes.\r\nThe recommended way to launch `subprocesses` is to use the following convenience functions.\r\n\r\n## Call \r\n\r\nTo run an external command without interacting with it, Use the call() function. This module intends to replace `os.system`.\r\n\r\n    >>> import subprocess\r\n    >>> subprocess.call([''ls'', ''-1''])\r\n    Bioinformatics.pdf\r\n    bitbucket\r\n    blender-doc.pdf\r\n    ...\r\n\r\n## Popen\r\n\r\nThe underlying process creation and management in this module is handled by the Popen class. It offers a lot of flexibility so that developers are able to handle the less common cases not covered by the convenience functions.\r\nThis is intended as a replacement for `os.popen`.\r\n\r\n    >>> subprocess.Popen([''ls'',''-l''])', '2014-07-04 03:18:02', '2014-07-04 03:49:01'),
(11, 'Django messages: A user-to-user messaging system for Django', '## Introduction\r\n\r\n[Django-messages](https://github.com/arneb/django-messages) enables your users to send private messages to each other. \r\n\r\nEvery user has an\r\n\r\n* Inbox\r\n* Compose Message\r\n* Outbox\r\n* Trash \r\n\r\nMessages can be composed and there is an easy, url-based approach to preloading the compose-form with the recipient-user, which makes it extremely easy to put "send xyz a message" links on a profile-page.\r\n\r\n## Using django-messages\r\n\r\nsee [this commit](https://github.com/suhailvs/django-messages/commit/2a7879148a4df557e4978440bd5c49f999822689) to take a quick look.\r\n\r\n**Install it:**\r\n\r\n    pip install django-messages\r\n\r\n**Add `django_messages` to the `INSTALLED_APPS` in settings.py:**\r\n\r\n    INSTALLED_APPS = (\r\n        ...\r\n        ''django_messages'',\r\n        ...\r\n    )\r\n\r\n**Add urls to `urls.py`**\r\n\r\n    urlpatterns = patterns(''''\r\n        ...\r\n        (r''^messages/'', include(''django_messages.urls'')),\r\n        ...\r\n    )\r\n\r\n**Templates:**\r\nYou must have base template with the name `base.html` which defines a `block content` and a `block sidebar`. for eg :\r\n\r\n`../templates/base.html`:\r\n\r\n    {% block content %}\r\n    {% endblock %}\r\n    <hr>\r\n    {% block sidebar %}\r\n    {% endblock %}\r\n\r\nthat''s it now you can vist **http://localhost:8000/messages/inbox**\r\n\r\n## Examples\r\n\r\nHere is a very [Basic example](https://github.com/suhailvs/django-messages/tree/master/basic_example). ', '2014-07-11 03:10:50', '2014-07-11 03:10:50'),
(12, 'Openshift django site hosting and RHC Tool usage: a beginners guide.', '\r\n## rhc setup using multiple accounts.\r\n\r\n    rhc setup -l username1\r\n    rhc app create <appname> <cartridge>    \r\n    rhc account logout\r\n    rhc setup -l username2\r\n    rhc app create mysite python-2.7\r\n\r\n## to see the log\r\n\r\n    rhc tail <appname>\r\n\r\n## a basic rhc `wgi.py` file:\r\n\r\n    #!/usr/bin/python\r\n    import os,sys\r\n    os.environ[''DJANGO_SETTINGS_MODULE''] = ''poynting.settings''\r\n    sys.path.append(os.path.join(os.environ[''OPENSHIFT_REPO_DIR''],''odesk_poynting''))\r\n\r\n    virtenv = os.environ[''OPENSHIFT_PYTHON_DIR''] + ''/virtenv/''\r\n    virtualenv = os.path.join(virtenv, ''bin/activate_this.py'')\r\n    try:\r\n        execfile(virtualenv, dict(__file__=virtualenv))\r\n    except IOError:\r\n        pass\r\n    #\r\n    # IMPORTANT: Put any additional includes below this line.  If placed above this\r\n    # line, it''s possible required libraries won''t be in your searchable path\r\n    #\r\n    from django.core.handlers import wsgi\r\n    application = wsgi.WSGIHandler()\r\n\r\n## serve static files:\r\n \r\nadd `static_root` in settings.py::\r\n\r\n    STATIC_ROOT = os.path.join(BASE_DIR,<django_app_foldername>,''static_root'')\r\n\r\nin `urls.py` add:\r\n\r\n    from django.conf.urls.static import static\r\n    from django.conf import settings\r\n    urlpatterns = patterns('''',\r\n    .......\r\n    )+ static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)\r\n\r\nthen run `python mange.py collectstatic`', '2014-07-13 03:02:01', '2014-07-13 03:05:35'),
(13, 'List of Hypertext Transfer Protocol (HTTP) response status codes.', '# 2xx Success \r\n\r\n### 200 OK ###\r\n\r\nThis class of status codes indicates the action requested by the client was received, understood, accepted and processed successfully.\r\n\r\n### 201 Created ###\r\n\r\nThe request has been fulfilled and resulted in a new resource being created.\r\n\r\n### 202 Accepted ###\r\n\r\nThe request has been accepted for processing, but the processing has not been completed. The request might or might not eventually be acted upon, as it might be disallowed when processing actually takes place.\r\n\r\n### 203 Non-Authoritative Information ###\r\n\r\nThe server successfully processed the request, but is returning information that may be from another source.\r\n\r\n### 204 No Content ###\r\n\r\nThe server successfully processed the request, but is not returning any content. Usually used as a response to a successful delete request.\r\n\r\n### 205 Reset Content ###\r\n\r\nThe server successfully processed the request, but is not returning any content. Unlike a 204 response, this response requires that the requester reset the document view.\r\n\r\n# 3xx Redirection\r\n\r\n### 300 Multiple Choices\r\n\r\nIndicates multiple options for the resource that the client may follow. \r\n\r\n### 301 Moved Permanently\r\n\r\nThe requested page has moved to a new URL \r\n\r\n### 302 Found\r\n\r\nThe requested page has moved temporarily to a new URL \r\n\r\n# 4xx Client Error\r\n\r\n### 400 Bad Request\r\n\r\nThe request cannot be fulfilled due to bad syntax.\r\n\r\n### 401 Unauthorized\r\n\r\nSimilar to ''''403 Forbidden'''', but specifically for use when authentication is required and has failed or has not yet been provided. \r\n\r\n### 403 Forbidden\r\n\r\nThe request was a valid request, but the server is refusing to respond to it. \r\n\r\n### 404 Not Found\r\n\r\nThe requested page could not be found but may be available again in the future\r\n\r\n# 5xx: Server Error\r\n\r\n### 500 Internal Server Error\r\n\r\nA generic error message, given when no more specific message is suitable\r\n\r\n## 501 Not Implemented\r\n\r\nThe server either does not recognize the request method, or it lacks the ability to fulfill the request. ', '2014-07-13 22:38:53', '2014-07-13 22:56:19'),
(14, 'Installing Django on Arvixe web hosting', 'Arvixe web hosting don''t support `mod-python`, `mod-wsgi`, `fast-cgi`...etc. The only way is using `cgi`:\r\n\r\n# ssh into the server #\r\n\r\nOpen up a terminal(`alt+ctrl+t`) and log into the server:\r\n\r\n    $ ssh username@yoursite.com\r\n\r\n# Install python #\r\n\r\nWe have a bunch of things to do here: install python, install django, optionally install virtualenv, create the cgi script. First off, we need to get a newer version of python installed to work with Django. Create a folder `projects` to store our stuffs. I like to put my downloaded software in a directory called `projects/downloads`.\r\n\r\n    $ mkdir projects\r\n    $ cd projects\r\n    $ mkdir downloads\r\n    $ cd downloads\r\n    $ wget https://www.python.org/ftp/python/2.7.8/Python-2.7.8.tgz --no-check-certificate\r\n    $ tar -xzf Python-2.7.8.tgz\r\n    $ cd Python-2.7.8\r\n    $ ./configure\r\n    $ make altinstall prefix=~ exec-prefix=~\r\n    $ cd ~/bin\r\n    $ ln -s python2.7 python\r\n    $ cd\r\n    $ echo "alias python=''~/bin/python''" >> .profile\r\n\r\nThis installs python in your home directory.\r\n\r\n# Install Django & Virtualenv#\r\n\r\n## install virtualenv ##\r\n\r\n    $ cd ~/projects/downloads\r\n    $ wget https://pypi.python.org/packages/source/v/virtualenv/virtualenv-1.11.6.tar.gz\r\n    $ tar -xzf virtualenv-1.11.6.tar.gz \r\n    $ cd virtualenv-1.11.6\r\n    $ python2.7 setup.py install\r\n\r\n## create a virtualenv & install Django ##\r\n\r\n    $ cd ~/projects\r\n    $ mkdir Envs\r\n    $ cd Envs/\r\n    $ virtualenv myenv\r\n    $ source myenv/bin/activate\r\n    $ pip install django\r\n\r\n# Make the cgi application #\r\n\r\nOk, now that we are done installing things, we need to tell Apache how to find your web application. For this example, I''m going to assume that we already have a working django application located in the directory:\r\n\r\n    /home/username/projects/repos/mydjangoapp/\r\n    # or you can create a new django project(directory repos) by run:\r\n    # django-admin.py startproject mydjangoapp\r\n\r\nYour web app most likely uses static files, so we make a static directory to hold them. \r\n\r\n    $ cd ~/public_html\r\n    $ mkdir static\r\n\r\nNext, get the cgi script for django and put it in your cgi-bin directory and make it executable.\r\n\r\n    $ cd ~/public_html/cgi-bin\r\n    $ wget https://code.djangoproject.com/raw-attachment/ticket/2407/django.cgi\r\n    $ chmod +x django.cgi\r\n\r\nOpen it up in a text editor and change the following lines to tell it where to find your python installation and django application\r\n\r\n    #!/home/username/bin/python\r\n    sys.path.append("/home/username/projects/repos/mydjangoapp")\r\n    os.environ[''DJANGO_SETTINGS_MODULE''] = ''mydjangoapp.settings''\r\n   \r\n    # activate the virtualenv\r\n    virtualenv="/home/username/projects/Envs/myenv/bin/activate_this.py"\r\n    execfile(virtualenv, dict(__file__=virtualenv))\r\n\r\n# Configure Apache #\r\n\r\nCreate a `.htaccess` file in the `~/public_html/` directory with your favorite editor and add the following contents:\r\n\r\n    AddHandler cgi-script .cgi\r\n    RewriteEngine On\r\n    RewriteRule ^/(static.*)$ /$1 [QSA,L,PT]\r\n    RewriteRule ^/(cgi-bin.*)$ /$1 [QSA,L,PT]\r\n    RewriteCond %{REQUEST_FILENAME} !-f\r\n    RewriteRule ^(.*)$ /cgi-bin/django.cgi/$1 [QSA,L]\r\n\r\nThe last line tells the server to redirect all requests to the django.cgi script. However, we still want static request to go to the static directory.\r\n\r\nSo that should be it. Visit your your website in a browser.', '2014-08-15 18:25:10', '2014-08-17 12:43:57'),
(15, 'A beginners guide to angularjs.', '# Level 1: Getting Started(Directive, Module, Expressions) #\r\n\r\n## Module ##\r\n\r\nNothing but Javascript Angular codes\r\n\r\nfor eg:\r\n	\r\n	var myapp=angular.module(''store'',[]);\r\n\r\n## Directive ##\r\n\r\nA Directive is a marker on an HTML tag that tells Angular to run or reference some Javascript Code.\r\n\r\nfor eg `ng-app`:\r\n	\r\n	<html ng-app="store">\r\n\r\n*this `ng-app` directive creates an angular application by running Javascript Angular module `store`*\r\n\r\n\r\n## Expressions ##\r\n\r\n	{{3+4+5}}\r\n\r\n\r\n## full example ##\r\n\r\n[live demo jsbin](http://jsbin.com/fegiwofeyoge/1/edit)\r\n\r\n	<html ng-app="store">\r\n	<!-- load angular via CDN -->\r\n	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.25/angular.min.js"></script>\r\n\r\n	<script type="text/javascript">\r\n		var myapp=angular.module(''store'',[]);\r\n	</script>\r\n\r\n	{{3+4+5}}\r\n	</html>\r\n', '2014-10-09 02:14:56', '2014-10-09 02:18:53');

-- --------------------------------------------------------

--
-- Table structure for table `blog_blog_tags`
--

CREATE TABLE IF NOT EXISTS `blog_blog_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `blog_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `blog_id` (`blog_id`,`tag_id`),
  KEY `blog_blog_tags_7894a4cc` (`blog_id`),
  KEY `blog_blog_tags_5659cca2` (`tag_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=75 ;

--
-- Dumping data for table `blog_blog_tags`
--

INSERT INTO `blog_blog_tags` (`id`, `blog_id`, `tag_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 2, 3),
(5, 2, 4),
(23, 3, 5),
(24, 3, 6),
(25, 3, 7),
(26, 4, 7),
(68, 5, 1),
(67, 5, 8),
(12, 6, 9),
(13, 6, 10),
(14, 6, 11),
(15, 6, 12),
(22, 8, 15),
(20, 8, 16),
(21, 8, 17),
(27, 9, 7),
(34, 10, 18),
(35, 10, 19),
(36, 10, 20),
(37, 11, 1),
(38, 11, 3),
(43, 12, 1),
(44, 12, 19),
(45, 12, 20),
(46, 12, 21),
(51, 13, 22),
(52, 13, 23),
(62, 14, 1),
(61, 14, 24),
(72, 15, 9),
(73, 15, 26),
(74, 15, 27);

-- --------------------------------------------------------

--
-- Table structure for table `blog_tag`
--

CREATE TABLE IF NOT EXISTS `blog_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=28 ;

--
-- Dumping data for table `blog_tag`
--

INSERT INTO `blog_tag` (`id`, `name`, `created`) VALUES
(1, 'django', '2014-06-19 06:52:04'),
(2, 'django-forms', '2014-06-19 06:52:09'),
(3, 'email', '2014-06-21 03:26:25'),
(4, 'google', '2014-06-21 03:26:40'),
(5, 'github', '2014-06-21 03:28:03'),
(6, 'github-pages', '2014-06-21 03:28:14'),
(7, 'git', '2014-06-21 03:28:21'),
(8, 'django-templates', '2014-06-22 02:44:01'),
(9, 'html', '2014-06-29 12:47:17'),
(10, 'mathematics', '2014-06-29 12:47:26'),
(11, 'latex', '2014-06-29 12:47:43'),
(12, 'mathjar', '2014-06-29 12:48:02'),
(13, 'fifa_worldcup_2014', '2014-07-01 09:08:44'),
(14, 'videos', '2014-07-01 09:08:50'),
(15, 'select2', '2014-07-02 18:18:07'),
(16, 'multiselect', '2014-07-02 18:18:16'),
(17, 'jquery', '2014-07-02 18:18:23'),
(18, 'python', '2014-07-04 03:17:22'),
(19, 'shell', '2014-07-04 03:17:54'),
(20, 'os', '2014-07-04 03:17:57'),
(21, 'openshift', '2014-07-13 02:58:24'),
(22, 'http', '2014-07-13 22:38:11'),
(23, 'status_codes', '2014-07-13 22:38:27'),
(24, 'Arvixe', '2014-08-15 18:12:55'),
(25, 'css', '2014-08-23 12:38:01'),
(26, 'angularjs', '2014-10-09 02:14:20'),
(27, 'javascript', '2014-10-09 02:14:31');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `blog_blog_tags`
--
ALTER TABLE `blog_blog_tags`
  ADD CONSTRAINT `blog_id_refs_id_e0390e6d` FOREIGN KEY (`blog_id`) REFERENCES `blog_blog` (`id`),
  ADD CONSTRAINT `tag_id_refs_id_153d8859` FOREIGN KEY (`tag_id`) REFERENCES `blog_tag` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
