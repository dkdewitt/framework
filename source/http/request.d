module http.request;
import http.server;
import inet.urlparser;
import http.base;
import std.algorithm;
import std.range;
import std.string;
import std.typecons;
import std.conv;
class BaseHTTPRequest{

    this(){

    }
}


class HTTPRequest: BaseHTTPRequest{
    char[] data;
    HTTPMethod method;
    string client;
    ushort _port;
    string path;
    string fullPath;
    string username;
    string password;
    string queryString;
    string[string] params;
    string[string] _headers;
    URL url;
    string[string] form;  //POST request data

    @property URL fullURL() const{
        URL url;

        return url;
    }

this(char[] data){
        this.data = data;
        parseRequest();

       
    }

    /*void formData(string[] rng){
        auto tmp = splitter(rng[0], "&");
        foreach(item; tmp){
            auto spllitLoc = item.indexOf("=");
            form[item[0..spllitLoc]] = item[spllitLoc+1..$];
        }
    }*/

    void parseRequest(){
        import std.stdio;
        import std.conv;
        string tmp = this.data.dup;
        auto rawRequestData = splitLines(tmp).split("");

        string rawRequestLine = rawRequestData[0][0];
        string[] rawRequestHeaders = rawRequestData[0][1..$];
        foreach(header; rawRequestHeaders){
            auto lineSep = header.indexOf(":");
            if(lineSep < 0)
                throw new Exception("Invalid Header");
            
            this._headers[header[0..lineSep]] = stripLeft(header[lineSep+1..$]) ;
        }
        if(rawRequestData[$-1].length == 0)
            rawRequestData = rawRequestData[0..$-1];
        if(rawRequestData.length > 1){
            size_t contentLength = to!size_t(_headers.get("Content-Length", "0"));
            char[] rawRequestBody = rawRequestData[1][0].dup;
            string requestBody = rawRequestBody[0..contentLength].dup;
            auto requestBodyItems = requestBody.split("&");

            foreach(item; requestBodyItems){
                auto lineSep = item.indexOf("=");
                if(lineSep < 0)
                    throw new Exception("Invalid Request Body");
                this.form[item[0..lineSep]] = item[lineSep+1..$];
            }
        }
            auto requestLine = rawRequestLine.split(" ");
            string requestType = requestLine[0].dup;
            this.method = getMethodFromString(requestType);
            string path = requestLine[1].dup;
            string urlString = "http://" ~ this._headers.get("Host", "") ~ path;
            this.fullPath = urlString;
            this.path = path;
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