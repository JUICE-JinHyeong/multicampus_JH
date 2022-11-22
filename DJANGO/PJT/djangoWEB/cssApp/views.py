from django.shortcuts import render

# Create your views here.

def index(request) :
    print('debug >>>>> index call')
    return render(request , 'css/index.html')

def grammar(request) :
    print('debug >>>>> grammar call')
    # return HttpResponse()
    # render 함수를 이용하면 UI를 담당하는 templates 찾는 것이다.
    return render(request , 'css/grammar.html');

def selector(request) :
    print('debug >>>>> selector call')
    return render(request , 'css/selector.html')

def combine(request) :
    print('debug >>>>> sekector call')
    return render(request , 'css/combine_selector.html')