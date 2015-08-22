module http.server;

import std.socket;
import http.request;
import http.response;
/// Delegate based request handler
alias HTTPServerRequestDelegate = void delegate(HTTPRequest req, HTTPResponse res);
/// Static function based request handler
alias HTTPServerRequestFunction = void function(HTTPRequest req, HTTPResponse res);
/// Interface for class based request handlers
interface HTTPServerRequestHandler {
    /// Handles incoming HTTP requests
    void handleRequest(HTTPRequest req, HTTPResponse res);
}
//import http.base;





class BaseServer{
    string _address;
    HTTPServerRequestDelegate requestHandler;
    this(string serverAddress, HTTPServerRequestDelegate requestHandler){
        this._address = serverAddress;
        this.requestHandler = requestHandler;
    }


}

class TCPServer{
private:


    this(){

    }
}

class BaseHTTPServer: BaseServer{
    private:
        bool isRunning;

public:
        this(){
        super("localhost", HTTPServerRequestDelegate requestHandler);    
        }
    static this(){


        super("localhost", HTTPServerRequestDelegate requestHandler);
        auto listener = new TcpSocket(AddressFamily.INET);
        listener.bind(new InternetAddress("localhost", 8081));
        listener.listen(10);
    }


    Socket getRequest(){
        return this.listener.accept();
    }

    void handle_request(){
        while(True){
            auto newSocket = listener.accept();
        }
    }

    void serve(){
        try{
            while(isRunning){
                handle_request();
            }
        }
        catch{
            
        }

    }
}
