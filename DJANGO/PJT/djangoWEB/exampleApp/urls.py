from django.contrib import admin

from django.urls import path, include
from exampleApp import views

# http://localhost:800/greeting/
urlpatterns = [
    ## http://localhost:800/greeting/index
    path("index/" , views.index)
]