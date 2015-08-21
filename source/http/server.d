module http.server;

import std.socket;

alias HTTPServerRequestDelegate = void delegate();
/// Delegate based request handler
alias HTTPServerRequestDelegate = void delegate(HTTPServerRequest req, HTTPServerResponse res);
/// Static function based request handler
alias HTTPServerRequestFunction = void function(HTTPServerRequest req, HTTPServerResponse res);
/// Interface for class based request handlers
interface HTTPServerRequestHandler {
    /// Handles incoming HTTP requests
    void handleRequest(HTTPServerRequest req, HTTPServerResponse res);
}
//import http.base;



class BaseServer{
    this(string serverAddress, HTTPServerRequestDelegate){

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

    this(string host, ushort port, HTTPServerRequestDelegate requestHandler){
        super(host, requestHandler);
        auto listener = new TcpSocket(AddressFamily.INET);
        listener.bind(new InternetAddress("localhost", 8081));
        listener.listen(10);
    }

    void serve(){
        try{
            while(isRunning){
                //
            }
        }
        catch{
            
        }

    }
}
