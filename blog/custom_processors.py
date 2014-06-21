from blog.models import Blog,Tag
def all_tags(request):
	tgs=Tag.objects.all()
	#[(count,pk,name)......]
	taglist=[(Blog.objects.filter(tags=tg).distinct().count(),tg.pk,tg.name) for tg in tgs]
	return {'tags':taglist,}