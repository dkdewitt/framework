module inet.urlparser;

import std.stdio;
import std.exception;
import std.string;
import std.conv;
import std.algorithm;
import std.array;

struct URL{
    string url;
    string scheme;
    string netloc;
    ushort port;
    string path;
    string  query;
    string fragment;
    string username;
    string password;
    string[string] form;


    this(string scheme, string host, ushort port, string path)
    {
        scheme = scheme;
        host = host;
        port = port;
        //pathString = urlEncode(path.toString(), "/");
    }

    this(string url ){
        enforce(url.length > 0);
        this.url = url;
        string urlTmp = url;
        if ( urlTmp.indexOf("://") != -1){
            long loc = urlTmp.indexOf("://");
            string scheme = urlTmp[0..loc];
            urlTmp = urlTmp[loc+1..$];
            this.scheme = scheme;
            switch (scheme){
                case "http":
                case "ftp" : 
                case "https" :
                    enforce(urlTmp.startsWith("//"), "URL does not contain //");
                    urlTmp = urlTmp[2..$];
                    goto default;
                default:
                    //Get next slash
                    long netlocBeg = 0;
                    long netlocEnd = urlTmp.indexOf("/");

                    if (netlocEnd == -1)
                        //Fix this
                        break;

                    string hostTmp = urlTmp[0..netlocEnd];
                    //Check if credentials are passed in

                    auto userpassLoc = hostTmp.indexOf("@");
                    netlocBeg = userpassLoc+1;
                    if(userpassLoc > 0){
                        //Seperate Out for user and pass
                        auto credentials = hostTmp[0..userpassLoc];
                        auto seperator = credentials.indexOf(":");
                        this.username = credentials[0..seperator];
                        this.password = credentials[seperator+1..$];

                        enforce(username.length > 0, "Cannot have empty username");

                    }
                    this.netloc  = urlTmp[netlocBeg..netlocEnd];
                    auto portTmpLoc = this.netloc.indexOf(":");

                    if(portTmpLoc > 0){
                        enforce(portTmpLoc < this.netloc.length -1, "Invalid Port");
                    
                    this.port = to!ushort(this.netloc[portTmpLoc+1..$]);
                    this.netloc = this.netloc[0 .. portTmpLoc];
                }
                urlTmp = urlTmp[netlocEnd..$]; 
                auto sep = urlTmp.indexOf("?");
                long tmpFrag;
                if(sep > 0){
                    tmpFrag = urlTmp.indexOf("#");
                    this.path = urlTmp[0..sep];
                    tmpFrag = urlTmp.indexOf("#");
                    if(tmpFrag > 0)
                        this.query = urlTmp[sep+1..tmpFrag];
                    else
                        this.query = urlTmp[sep+1..$]; 
                }
                else{
                    tmpFrag = urlTmp.indexOf("#");
                    if (tmpFrag > 0){
                        auto path = urlTmp[0..tmpFrag];
                        this.path = path;
                        
                    }
                }
                    if(tmpFrag > 0)
                       this.fragment=urlTmp[tmpFrag+1..$];
            }
        }
    }

    string[string] queryDict(){
        string tmpQuery = this.query;
        auto tmp1 = splitter(this.query,"&").map!(a=>splitter(a,"="));
        string[string] arr;// = tmp1.each!(a=>assocArray(tuple(a[0], a[1])));
        foreach(item; tmp1){
            auto tmpItem = item.array;
            arr[tmpItem[0]] = tmpItem[1];
        }
        return arr;
    }   

    @property string host() {return this.netloc;}

}


