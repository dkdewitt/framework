import std.stdio;
import http.server;
import http.request;
import http.response;
import http.router;


void home(HTTPRequest req, HTTPResponse res)
{
    writeln("Welcome");
}


void test1(HTTPRequest req, HTTPResponse res)
{
    writeln("I ran");
}

void test2(HTTPRequest req, HTTPResponse res)
{
    writeln("I ran2");
}


void main()
{

    auto router = new URLRouter;
     router.get("/", &home);
    router.get("/test", &test1);
    router.get("/test1", &test2);
	writeln("Edit source/app.d to start your project.");
    BaseHTTPServer server1 = new BaseHTTPServer(router);
    //HTTPResponse h1;
}
