import std.conv;
import std.string;


struct Headers{

    string[string] _headers;

    this(string[] headers){

        foreach(int i, line; headers){
            string headerString = line.dup;
            if(headerString == ""){
                string[] requestBody = to!(string[])(requestTmp[i+2..$]);
                formData(requestBody);
                break;
            }
            auto spllitLoc = headerString.indexOf(':');
            if (spllitLoc > 0){
            auto t = tuple(headerString[0..spllitLoc], headerString[spllitLoc+2..$]);
            _headers[t[0]] = t[1];
            }
        }
    }

}