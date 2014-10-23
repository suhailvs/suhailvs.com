from django.shortcuts import render
from blog.models import Blog,Tag
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.db.models import Q
from django.http import HttpResponse
def limit_data(page,data,n=30):
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
		input_tags=request.GET.getlist('tags')
		print input_tags
		blogs=Blog.objects.filter(tags__id=input_tags[0]).order_by('-created')
		if len(input_tags)>1:
			#blogs=Blog.objects.filter(tags__in=request.GET.getlist('tags')).order_by('-created')
			for i in range(1,len(input_tags)):				
				blogs=blogs.filter(tags__id=input_tags[i])
			filtered_tags=Tag.objects.filter(id__in=input_tags)	
		else:			
			filtered_tags=Tag.objects.filter(id=input_tags[0])
	else:
		filtered_tags=False
		blogs=Blog.objects.order_by('-created')
	blogs=limit_data(request.GET.get('page'),blogs)
	return render(request,'home.html',{'blogs':blogs,'filtered_tags':filtered_tags})

def blog(request,pk):
	blog=Blog.objects.get(id=pk)
	return render(request,'blog.html',{'blog':blog})

def staticpages(request,page):
	return render(request,'{0}.html'.format(page))

def videos(request,fname):
	import os.path
	folder_url='http://d.suhails.in/suhails.in_videos/'
	fpath="/home/suhailvs/webapps/downloads/suhails.in_videos/{file}.mp4".format(file=fname)
	
	if os.path.isfile(fpath):
		return render(request,'video.html',{'url':folder_url,'file':fname})

	return HttpResponse("File doesn't exist in <a href='"+folder_url+"'>here.</a>")