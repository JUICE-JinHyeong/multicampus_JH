from django.shortcuts import render

# Create your views here.

def index(request) :
    print('debug >>>>> index call')
    # return HttpResponse()
    # render 함수를 이용하면 UI를 담당하는 templates 찾는 것이다.
    return render(request , 'example/index.html');