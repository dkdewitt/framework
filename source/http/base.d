module http.base;
import std.stdio;
import std.algorithm;
import std.string;
import std.range;
import std.exception;
import std.conv;
import http.status;


enum HTTPVersion{
    HTTP_1_0,
    HTTP_1_1
}


enum HTTPMethod{
    GET,
    POST,
    PUT,
    DELETE,
    PATCH
}

string getStringHTTPMethod(HTTPMethod method)
{
    switch(method){

        default: return to!string(method);
    }
}

HTTPMethod getMethodFromString(string method){
    switch(method){
        default: throw new Exception("Invalid HTTP method: "~method);
        // HTTP standard, RFC 2616
        case "GET": return HTTPMethod.GET;
        
        case "PUT": return HTTPMethod.PUT;
        case "POST": return HTTPMethod.POST;
        case "PATCH": return HTTPMethod.PATCH;
        case "DELETE": return HTTPMethod.DELETE;
    }
}

//alias HTTPServerRequestDelegate = void delegate(Request req, Response res);
//alias HTTPServerRequestFunction = void function(Request req, Response res);



/**
*   HTTP Base Response
**/
class HTTPResponseBase {

    string[string] _headers;
    this(string content_type = null, string status = null, ){

    }

    //byte[] serializeHeaders(){
    //    return byte[] "";
    //}

}

class HTTPStatusException: Exception{
private:
    int _status;

public:
    this(int status, string message = null, string file = __FILE__, int line = __LINE__, Throwable next = null)
    {
        super(message != "" ? message : httpStatusText(status), file, line, next);
        _status = status;
    }

    @property int status() const { return _status; }
}


