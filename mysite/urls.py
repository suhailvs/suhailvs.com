from django.conf.urls import patterns, include, url

from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
     url(r'^$', 'blog.views.home', name='home'),
     url(r'^(\d{1,5})/', 'blog.views.blog', name='blog'),
    # url(r'^blog/', include('blog.urls')),
    url(r'^(aboutme|projects)$', 'blog.views.staticpages', name='static_pages'),
    url(r'^admin/', include(admin.site.urls)),
)
