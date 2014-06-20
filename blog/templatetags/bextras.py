from django import template
from django.utils.safestring import mark_safe
import markdown as mkdn
from blog.models import Blog,Tag
from django.core.urlresolvers import reverse
register = template.Library()

@register.filter
def markdown(value,smode=None):
    return mark_safe(mkdn.markdown(value))

@register.simple_tag
def create_tagmenu():
    tgs=Tag.objects.all()
    if not tgs:return '<li> no tags!</li>'
    taglist=[(Blog.objects.filter(tags=tg).distinct().count(),tg.pk,tg.name) for tg in tgs]    
    str_html=''
    turl=reverse('home')
    for tg in taglist:
        str_html+='<li><a href="{url}?tags={tag[1]}" class="post-tag">{tag[2]}</a><span class="item-multiplier"> x {tag[0]}</span></li>'.format(tag=tg,url=turl)
    return str_html
