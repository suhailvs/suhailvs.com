from django.conf.urls import patterns, include, url

from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('blog.views',
    # Examples:
    url(r'^$', 'home', name='home'),
    url(r'^(\d{1,5})/', 'blog', name='blog'),
    # url(r'^blog/', include('blog.urls')),
    url(r'^(aboutme|projects)$', 'staticpages', name='static_pages'),
    url(r'^admin/', include(admin.site.urls)),
)
