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


from django.contrib.sitemaps import GenericSitemap
from blog.models import Blog,Tag

info_dict = {
    'queryset': Blog.objects.all(),
    'date_field': 'created',
}

sitemaps = {    
    'blog': GenericSitemap(info_dict, priority=0.6),
}

urlpatterns += patterns('',
    # some generic view using info_dict
    # ...

    # the sitemap
    url(r'^sitemap\.xml$', 'django.contrib.sitemaps.views.sitemap',
        {'sitemaps': sitemaps}, name='django.contrib.sitemaps.views.sitemap'),
)