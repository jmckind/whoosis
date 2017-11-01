from django.conf.urls import include, url
from django.contrib import admin

urlpatterns = [
    url(r'^', include('whoosis.web.urls')),
    url(r'^admin/', admin.site.urls),
]
