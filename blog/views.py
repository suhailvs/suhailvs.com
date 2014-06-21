from django.shortcuts import render
from blog.models import Blog,Tag
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger

def limit_data(page,data,n=10):
	paginator = Paginator(data,n) # Show 10 notes per page
	try:
		p_data = paginator.page(page)
	except PageNotAnInteger:
		# If page is not an integer, deliver first page.
		p_data = paginator.page(1)
	except EmptyPage:
		# If page is out of range (e.g. 9999), deliver last page of results.
		p_data = paginator.page(paginator.num_pages)
	return p_data


# Create your views here.
def home(request):
	if 'tags' in request.GET:		
		blogs=Blog.objects.filter(tags__in=request.GET.getlist('tags')).order_by('-created')
		filtered_tags=Tag.objects.filter(id__in=request.GET.getlist('tags'))	
	else:
		filtered_tags=False
		blogs=Blog.objects.order_by('-created')
	blogs=limit_data(request.GET.get('page'),blogs,1)
	return render(request,'home.html',{'blogs':blogs,'filtered_tags':filtered_tags})

def archive(request,year,month):
	filtered_by='Year:{0}, Month:{1}'.format(year,month)
	blogs=Blog.objects.filter(created__year=year,created__month=month).order_by('-created')
	blogs=limit_data(request.GET.get('page'),blogs,1)
	return render(request,'archive.html',{'blogs':blogs,'filtered_by':filtered_by})
def blog(request,pk):
	blog=Blog.objects.get(id=pk)
	return render(request,'blog.html',{'blog':blog})

def staticpages(request,page):
	return render(request,'{0}.html'.format(page))