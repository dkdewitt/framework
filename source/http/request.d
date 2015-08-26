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
    string[string] headers;
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

    void formData(string[] rng){
        auto tmp = splitter(rng[0], "&");
        foreach(item; tmp){
            auto spllitLoc = item.indexOf("=");
            form[item[0..spllitLoc]] = item[spllitLoc+1..$];
        }
    }

    void parseRequest(){
        import std.stdio;
        import std.conv;
        auto requestTmp = splitter(this.data, "\r\n")
            .array();
        
        foreach(int i, line; requestTmp[1..$]){
            string headerString = line.dup;
            if(headerString == ""){
                string[] requestBody = to!(string[])(requestTmp[i+2..$]);
                formData(requestBody);
                break;
            }
            auto spllitLoc = headerString.indexOf(':');
            if (spllitLoc > 0){
            auto t = tuple(headerString[0..spllitLoc], headerString[spllitLoc+2..$]);
            headers[t[0]] = t[1];
            }
        }

        auto requestLine = requestTmp[0].split(" ");
        string requestType = requestLine[0].dup;
        this.method = getMethodFromString(requestType);
        string path = requestLine[1].dup;
        string urlString = "http://" ~ this.headers.get("Host", "") ~ path;
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