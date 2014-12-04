from django.conf import settings
from django.conf.urls import patterns, include, url
from django.conf.urls.static import static
from django.contrib import admin

# Uncomment the next two lines to enable the admin:
from core import views

admin.autodiscover()


urlpatterns = patterns('',
    url(r'^$', views.ProfileListView.as_view(), name='profile-list'),
    url(r'^app/$', views.IndexPageView.as_view(), name='index'),
    url(r'^layout1/$', views.Index1PageView.as_view(), name='index1'),
    url(r'^layout2/$', views.Index2PageView.as_view(), name='index2'),
    url(r'^layout3/$', views.Index3PageView.as_view(), name='index3'),
    url(r'^layout4/$', views.Index4PageView.as_view(), name='index4'),
    url(r'^layout5/$', views.Index5PageView.as_view(), name='index5'),
    url(r'^layout6/$', views.Index6PageView.as_view(), name='index6'),
    url(r'^layout7/$', views.Index7PageView.as_view(), name='index7'),
    url(r'^layout8/$', views.Index8PageView.as_view(), name='index8'),
    url(r'^layout9/$', views.Index9PageView.as_view(), name='index9'),
    url(r'^layout10/$', views.Index10PageView.as_view(), name='index10'),
    url(r'^layout11/$', views.Index11PageView.as_view(), name='index11'),
    url(r'^layout12/$', views.Index12PageView.as_view(), name='index12'),
    url(r'^apiv1/', include('core.urls', namespace='apiv1')),
    url(r'^admin/', include(admin.site.urls,)),
    url(r'^profile/(?P<id>\d+)/$', views.ProfileView.as_view(), name='profile'),
)  + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
