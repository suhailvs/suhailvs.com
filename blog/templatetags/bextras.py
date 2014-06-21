from django import template
from django.utils.safestring import mark_safe
import markdown as mkdn
from blog.models import Blog,Tag
from django.core.urlresolvers import reverse
register = template.Library()

@register.filter
def markdown(value,smode=None):
    return mark_safe(mkdn.markdown(value))
