module http.router;
import http.base;
import std.stdio;
public import http.server;
import http.request;
import http.response;
import std.algorithm;
import std.functional;


class URLRouter: HTTPServerRequestHandler{
    URLRoute[] _routes;
    string _prefix;
    void get(string path , HTTPMethod method, void function() cb){
        _routes ~= URLRoute(path, HTTPMethod.GET, cb);
    }

    /// Adds a new route for requests matching the specified HTTP method and pattern.
    URLRouter match(HTTPMethod method, string path, HTTPServerRequestDelegate cb)
    in { assert(path.length, "Path cannot be null or empty"); }
    body {
        _routes ~= URLRoute( path,method, cb);
        return this;
    }

    /// ditto
    URLRouter match(HTTPMethod method, string path, HTTPServerRequestHandler cb) { 
        return match(method, path, &cb.handleRequest); 
    }
    /// ditto
    URLRouter match(HTTPMethod method, string path, HTTPServerRequestFunction cb) { 
        return match(method, path, toDelegate(cb)); 
    }



    void handleRequest(HTTPRequest req, HTTPResponse res){
        auto method = req.method;
        auto path = req.path;
        if (path.length < _prefix.length || path[0 .. _prefix.length] != _prefix) return;
        path = path[_prefix.length .. $];
        while(true)
        {
            foreach (ref r; _routes) {
                if (r.method == method && path==r.path) {
                    //logTrace("route match: %s -> %s %s", req.path, r.method, r.pattern);
                    // .. parse fields ..
                    r.cb(req, res);
                    writeln("Request");
                    //if (res.headerWritten) return;
                }
            }
            //if (method == HTTPMethod.HEAD) method = HTTPMethod.GET;
            //else if (method == HTTPMethod.OPTIONS)
            //else break;
        }


        
    }


}
struct URLRoute{
public:
    string path;
    HTTPMethod method;
    HTTPServerRequestDelegate cb;
    this(string path, HTTPMethod method){
        this.path = path;
        this.method = method;
    }
    this(string path, HTTPMethod method,HTTPServerRequestDelegate cb){
        this.path = path;
        this.method = method;
        this.cb = cb;
    }
    this(string path, HTTPMethod method,void function() cb){
        this.path = path;
        this.method = method;
        //this.cb = toDelegate(cb);
    }

    

}