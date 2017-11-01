from django.conf import settings
from django.http import HttpResponse
from django.urls import reverse_lazy
from django.views.generic import ListView
from django.views.generic.base import TemplateView, View
from django.views.generic.edit import CreateView, UpdateView, DeleteView
from whoosis.web.models import Whoosis
import os, pkg_resources


class HelloView(View):
    def get(self, *args, **kwargs):
        hostname = os.environ.get('HOSTNAME')
        response = HttpResponse("Hello from {0}".format(hostname))
        response['Content-Type'] = 'text/plain'
        return response


class StatusView(TemplateView):
    template_name = "web/status.html"

    def get_context_data(self, **kwargs):
        context = super(StatusView, self).get_context_data(**kwargs)
        context['hostname'] = os.environ.get('HOSTNAME')
        context['version'] = pkg_resources.require("whoosis")[0].version
        return context


class WhoosisList(ListView):
    model = Whoosis


class WhoosisNew(CreateView):
    model = Whoosis
    fields = ['name']
    success_url = reverse_lazy('web.list')


class WhoosisUpdate(UpdateView):
    model = Whoosis
    fields = ['name']


class WhoosisDelete(DeleteView):
    model = Whoosis
    success_url = reverse_lazy('web.list')
