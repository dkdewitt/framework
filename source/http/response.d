module http.response;
import inet.urlparser;

class BaseHTTPResponse{

    this(){

    }
}


class HTTPResponse: BaseHTTPResponse{
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
