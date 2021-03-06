from django.db import models
from django.core.urlresolvers import reverse

# Create your models here.
class Tag(models.Model):
	name=models.CharField(max_length=100)
	created = models.DateTimeField(auto_now_add=True)
	def __unicode__(self):
		return unicode(self.name)

class Blog(models.Model):
	title=models.CharField(max_length=200)
	tags=models.ManyToManyField(Tag)	
	content=models.TextField(blank=True)
	created = models.DateTimeField(auto_now_add=True)
	updated = models.DateTimeField(auto_now=True)
	def __unicode__(self):
		return unicode(self.title)
	def get_absolute_url(self):
		return '{url}{slug}/'.format(url=reverse('blog', args=(self.id,)), slug=self.title.replace(' ','-'))