from django.contrib import admin

# Register your models here.
from blog.models import Blog,Tag
admin.site.register(Blog)
admin.site.register(Tag)