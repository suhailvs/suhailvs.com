from django.shortcuts import render
from blog.models import Blog,Tag

# Create your views here.
def home(request):
	blogs=Blog.objects.all()
	return render(request,'home.html',{'blogs':blogs})

def blog(request,pk):
	blog=Blog.objects.get(id=pk)
	return render(request,'blog.html',{'blog':blog})

def staticpages(request,page):
	return render(request,'{0}.html'.format(page))