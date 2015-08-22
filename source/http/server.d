module http.server;

import std.stdio;
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
    HTTPServerRequestHandler requestHandler;
    this(){

    }
    this(string serverAddress, HTTPServerRequestHandler requestHandler){
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
        Socket listener;

public:
this(HTTPServerRequestHandler requestHandler){
    //HTTPServerRequestDelegate requestHandler;

        super("localhost",  requestHandler);
        listener = new TcpSocket(AddressFamily.INET);
        listener.bind(new InternetAddress("localhost", 8081));
        listener.listen(10);
        this.isRunning = true;
        serve();
        writeln("Test");
    }


    Socket getRequest(){
        return this.listener.accept();
    }

    void handle_request(){
        while(true){
            char[1024] buffer;
            auto newSocket = listener.accept();
            auto received = newSocket.receive(buffer);
            writeln(received);
            HTTPRequest req = new HTTPRequest(buffer[0.. received]);
            HTTPResponse resp;
            requestHandler.handleRequest(req,resp);
        }
    }

    void serve(){
        try{
            while(isRunning){

                writeln("Running");
                handle_request();
            }
        }
        catch{
            
        }

    }
    void processRequest(){

    }
}
