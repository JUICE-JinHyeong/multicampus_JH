from django.shortcuts import render

# Create your views here.

def index(request) :
    print('debug >>>>>>> htmlApp index')
    return render(request , 'html/index.html')

def grammar(request) :
    print('debug >>>>>>>> htmlApp grammar')
    return render(request , 'html/grammar.html')

def layout(request) :
    print('debug >>>>>>> htmlApp request')
    return render(request , 'html/layout.html')

def move(request) :
    print('debug >>>>>> htmlApp move')
    return render(request , 'html/move.html')

def list(request) :
    print('debug >>>>>> htmlApp list')
    return render(request , 'html/list.html')

def table(request) :
    print('debug >>>>>> htmlApp table')
    return render(request , 'html/table.html')

def form(request) :
    print('debug >>>>>> htmlApp form')
    return render(request , 'html/form.html')

def login(request) :
    print('debug >>>>> htmlApp login')
    if request.method == 'GET' :
        id = request.GET['user_id']
        pwd = request.GET['user_pwd']
        print('GET param >>>>>>>>> ' , id , pwd)
        context = { 'id' : id , 'pwd' : pwd}

    elif request.method == 'POST' :
        id = request.POST['user_id']
        pwd = request.POST['user_pwd']
        print('POST param >>>>>>>>' , id , pwd)
        context = { 'id ' : id , 'pwd' : pwd}

    return render(request , 'html/signOK.html' , context)