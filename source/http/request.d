module http.request;


class BaseHTTPRequest{

    this(){

    }
}


class HTTPRequest: BaseHTTPRequest{
    
}

/**
*   Base Request Class
**/
class BaseRequestHandler: HTTPServerRequestDelegate/HTTPServerRequestFunction{

    //request
    //clientAddress
    //server
    this(){

    }

    void parseRequest(){

    }
}