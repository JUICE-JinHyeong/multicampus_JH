from django.urls import path, include
from cssApp import views

# http://localhost:800/css/
urlpatterns = [
    ## http://localhost:800/css
    path("", views.index),
    ## http://localhost:800/css/grammar
    path("grammar/" , views.grammar) ,
    ## http://localhost:800/css/selector
    path("selector/" , views.selector) ,
    ## http://localhost:800/css/combine_selector
    path("combine_selector/" , views.combine)
]