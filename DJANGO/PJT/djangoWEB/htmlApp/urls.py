from django.contrib import admin
from django.urls import path, include
from htmlApp import views

urlpatterns = [
    # http://localhost:8000/html/
    path("", views.index) ,
    # http://localhost:8000/html/grammer
    path("grammar/",  views.grammar) ,
    # http://localhost:8000/html/layout
    path("layout/" ,  views.layout) ,
    # http://localhost:8000/html/layout
    path("move/",     views.move),
    # http://localhost:8000/html/move
    path("list/",     views.list),
    # http://localhost:8000/html/table
    path("table/",    views.table),
    # http://localhost:8000/html/form
    path("form/",     views.form),
    # http://localhost:8000/html/login
    path("login/",    views.login),

]
