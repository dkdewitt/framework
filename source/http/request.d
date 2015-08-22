module http.request;
import http.server;
import inet.urlparser;
import http.base;
class BaseHTTPRequest{

    this(){

    }
}


class HTTPRequest: BaseHTTPRequest{
    HTTPMethod method;
    string client;
    ushort _port;
    string path;
    string username;
    string password;
    string queryString;
    //Cookies cookie;
    //FormFields query;
    string[string] params;


    @property URL fullURL() const{
        URL url;

        return url;
    }
}

/**
*   Base Request Class
**/
class BaseRequestHandler{
    string m;
    //request
    //clientAddress
    //server

    this(){

    }

    void parseRequest(){

    }
}