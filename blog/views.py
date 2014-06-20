from django.shortcuts import render
from blog.models import Blog,Tag

# Create your views here.
def home(request):
	if 'tags' in request.GET:
		# get note list base on tags in post, only public notes
		#tags=request.GET.getlist('tags')
		blogs=Blog.objects.filter(tags__in=request.GET.getlist('tags')).order_by('-created')
		tags=Tag.objects.filter(id__in=request.GET.getlist('tags'))	
	else:
		blogs=Blog.objects.order_by('-created')
	return render(request,'home.html',{'blogs':blogs})

def blog(request,pk):
	blog=Blog.objects.get(id=pk)
	return render(request,'blog.html',{'blog':blog})

def staticpages(request,page):
	return render(request,'{0}.html'.format(page))