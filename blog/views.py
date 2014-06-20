from django.shortcuts import render
from blog.models import Blog,Tag

# Create your views here.
def home(request):
	if 'tags' in request.GET:		
		blogs=Blog.objects.filter(tags__in=request.GET.getlist('tags')).order_by('-created')
		filtered_tags=Tag.objects.filter(id__in=request.GET.getlist('tags'))	
	else:
		filtered_tags=False
		blogs=Blog.objects.order_by('-created')
	return render(request,'home.html',{'blogs':blogs,'filtered_tags':filtered_tags})

def blog(request,pk):
	blog=Blog.objects.get(id=pk)
	return render(request,'blog.html',{'blog':blog})

def staticpages(request,page):
	return render(request,'{0}.html'.format(page))