import std.stdio;
import http.server;
import http.request;
import http.response;
import http.router;
import http.base;

void home(HTTPRequest req, HTTPResponse res)
{       
        string responseBody = "<html><body><h1>Welcome Home</h1></body></html>\n";
       res.render(responseBody);
}


void test1(HTTPRequest req, HTTPResponse res)
{

    string responseBody = "";
    if(req.method==HTTPMethod.GET){
        responseBody = "<html><body>TEST<form action=\"test\" method=\"POST\">
    
First name:<br>
<input type=\"text\" name=\"firstname\">
<br>
Last name:<br>
<input type=\"text\" name=\"lastname\"> 
Password:<br>
<input type=\"password\" name=\"password\"> <input type=\"submit\" value=\"Submit\">
</form></body></html>\n";

}

    if(req.method==HTTPMethod.POST){
        string name = req.form.get("firstname", "") ~ " " ~ req.form.get("lastname","") ~ "<br /> and your password is " ~ req.form.get("password","");
        responseBody = "<html><body><h1>Welcome " ~ name ~ " </h1></body></html>\n";
    }
       res.render(responseBody);
}

void test2(HTTPRequest req, HTTPResponse res)
{
    writeln("I ran2");
}

void post1(HTTPRequest req, HTTPResponse res)
{
    writeln("I ran2");
}


void main()
{

    auto router = new URLRouter;
     router.get("/home", &home);
    router.get("/test", &test1);
    router.get("/test1", &test2);
    router.post("/test", &test1);
	writeln("Edit source/app.d to start your project.");
    BaseHTTPServer server1 = new BaseHTTPServer(router);
    //HTTPResponse h1;
}
