from django.conf.urls import url
from whoosis.web import views


urlpatterns = [
    url(r'^/?$',
        views.WhoosisList.as_view(),
        name='web.list'),

    url(r'^hello/?$',
        views.HelloView.as_view(),
        name='web.hello'),

    url(r'^new/?$',
        views.WhoosisNew.as_view(),
        name='web.new'),

    url(r'^status/?$',
        views.StatusView.as_view(),
        name='web.status'),

    url(r'^(?P<pk>[^/]+)/?$',
        views.WhoosisUpdate.as_view(),
        name='web.update'),

    url(r'^(?P<pk>[^/]+)/delete/?$',
        views.WhoosisDelete.as_view(),
        name='web.delete'),
]
