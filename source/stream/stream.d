module stream.stream;


import std.stdio;
import std.array;
import std.algorithm;
import std.exception;
import std.datetime;
import std.conv;
import std.socket;
interface InputStream {


    @property bool empty();
@property ulong leastSize();
    void read(ubyte[] dt);

    ubyte[] readLine(size_t maxBytes = 0, string delimitter = "\r\n");

    ubyte[] readAll(size_t maxBytes=0);
    protected final ubyte[] readLineDefault(size_t max_bytes = 0, in string linesep = "\r\n")
    {
        auto dst = appender!(ubyte[])();
        size_t n = 0, m = 0;
        while(true){
            enforce(!max_bytes || n++ < max_bytes, "Line too long!");
            enforce(!empty, "Unterminated line!");
            ubyte[1] bt;
            read(bt);
            if( bt[0] == linesep[m] ) m++;
            else {
                dst.put(cast(ubyte[])linesep[0 .. m]);
                dst.put(bt[]);
                m = 0;
            }
            if( m >= linesep.length ) break;
        }
        return dst.data;
    }

    protected final ubyte[] readAllDefault(size_t max_bytes)
    {
        auto dst = appender!(ubyte[])();
        auto buffer = new ubyte[64*1024];
        size_t n = 0, m = 0;
        while( !empty ){
            enforce(!max_bytes || n++ < max_bytes, "Data too long!");
            size_t chunk = cast(size_t)min(leastSize, buffer.length);
            //logTrace("read pipe chunk %d", chunk);
            read(buffer[0 .. chunk]);
            dst.put(buffer[0 .. chunk]);
        }
        return dst.data;
    }
}


class HTTPInputStream: InputStream{
        private {
        InputStream m_in;
        bool m_empty = false;
        ulong m_bytesInCurrentChunk = 0;
    }

    this(InputStream stream)
    {
        assert(stream !is null);
        m_in = stream;
        readChunk();
    }
    @property bool empty() const { return m_empty; }

    @property ulong leastSize() const { return m_bytesInCurrentChunk; }
    void read(ubyte[] dst)
    {
        while( dst.length > 0 ){
            enforce( !empty );
            enforce( m_bytesInCurrentChunk > 0 );

            auto sz = cast(size_t)min(m_bytesInCurrentChunk, dst.length);
            m_in.read(dst[0 .. sz]);
            dst = dst[sz .. $];
            m_bytesInCurrentChunk -= sz;

            if( m_bytesInCurrentChunk == 0 ){
                // skipp current chunk footer
                ubyte[2] crlf;
                m_in.read(crlf);
                enforce(crlf[0] == '\r' && crlf[1] == '\n');
                readChunk();
            }

        }
    }

  ubyte[] readLine(size_t max_bytes, string line_sep = "\r\n")
    {
        return readLineDefault(max_bytes, line_sep);
    }

    ubyte[] readAll(size_t max_bytes = 0) { return readAllDefault(max_bytes); }


    private void readChunk()
    {
        // read chunk header
        auto ln = m_in.readLine();
        ulong sz = toImpl!ulong(cast(string)ln, 16u);
        m_bytesInCurrentChunk = sz;

        if( m_bytesInCurrentChunk == 0 ){
            // empty chunk denotes the end
            m_empty = true;

            // skip final chunk footer
            ubyte[2] crlf;
            m_in.read(crlf);
            enforce(crlf[0] == '\r' && crlf[1] == '\n');
        }
    }
}


class SocketStream{
    this(Socket conn){

    }
}


class OutputStream{


    this(){

    }


    void flush(){

    }

    void write(){
        
    }
}