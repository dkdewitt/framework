module http.request;
import http.server;
import inet.urlparser;
import http.base;
import std.algorithm;
import std.range;
import std.string;
import std.typecons;
class BaseHTTPRequest{

    this(){

    }
}


class HTTPRequest: BaseHTTPRequest{
    HTTPMethod method;
    string client;
    ushort _port;
    string path;
    string fullPath;
    string username;
    string password;
    string queryString;
    //Cookies cookie;
    //FormFields query;
    string[string] params;
    string[string] headers;
    URL url;

    @property URL fullURL() const{
        URL url;

        return url;
    }

this(char[] data){
        ///writeln(data);
        
        auto tmp1 = splitter(data, "\r\n")
            .array();
        
        auto tmp = tmp1[1..$];

        foreach(header; tmp){
            string headerString = header.dup;
            auto spllitLoc = headerString.indexOf(':');
            if (spllitLoc > 0){
            auto t = tuple(headerString[0..spllitLoc], headerString[spllitLoc+2..$]);
            headers[t[0]] = t[1];
            }
        }
        
        auto requestLine = tmp1[0].split(" ");
        
        string tz = requestLine[1].dup;
        
        string urlString = "http://" ~ this.headers.get("Host", "") ~ tz;
        //string urlString = this.headers.get("Referer", "/");
        
        //this.url = URL(urlString);
        //this.query = url.query;
        //this.queryDict = url.queryDict();
        //this.requestHeaders = RequestHeaders(data.dup);

        //this.method = getMethodFromString(this.requestHeaders.requestLine[0]);
        //string host = this.requestHeaders.headers["Host"].dup;
        this.fullPath = urlString;
        this.path = tz;
      
       
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