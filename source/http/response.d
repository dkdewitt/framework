module http.response;
import inet.urlparser;
import http.base;
import std.socket;
import std.stdio;
class BaseHTTPResponse{

    //HTTPVersion httpVersion = HttpVersion.HTTP_1_1;
    string[string] headers;
    this(){

    }

    //@property string contentType() const { return headers.get("Content Type", "text/plain; charset=UTF-8")};


}


class HTTPResponse: BaseHTTPResponse{
    Socket connection;
    string client;
    ushort _port;
    string path;
    string username;
    string password;
    string queryString;
    //Cookies cookie;
    //FormFields query;
    string header;
    string[string] params;

    string data="";

    @property URL fullURL() const{
        URL url;

        return url;
    }

    this(ref Socket connection){
        this.connection=connection;
        
    }

    void write(string data){
        this.header= "HTTP/1.1 200 OK\nContent-Type: text/html; charset=utf-8\n\n";
        this.data = data;
    }
    void render(string data){
        connection.send("HTTP/1.1 200 OK\nContent-Type: text/html; charset=utf-8\n\n" ~ data);
    }
}
