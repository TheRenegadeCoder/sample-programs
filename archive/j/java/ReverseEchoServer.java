import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.*;

public class ReverseEchoServer extends Thread {

    Socket skt;
    static int count=1;

    ReverseEchoServer(Socket s)
    {
        skt=s;
    }

    @Override
    public void run() {
        super.run();
        try{
            BufferedReader br = new BufferedReader(new InputStreamReader(skt.getInputStream()));
            PrintStream ps = new PrintStream(skt.getOutputStream());

            String msg;
            StringBuilder sb;

            do{
                msg = br.readLine();

                sb = new StringBuilder(msg);
                sb.reverse();
                msg=sb.toString();
                System.out.println("From client "+count+++" "+msg);

                ps.println(msg);

            }while (!msg.equals("dne"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) throws Exception{

        ServerSocket ss = new ServerSocket(2000);

        int count=1;
        Socket skt;
        ReverseEchoServer res ;

        do{
            skt = ss.accept();
            System.out.println("Client connected : "+count++);
            res = new ReverseEchoServer(skt);
            res.start();

        }while (true);

    }
}
class Client1 {
    public static void main(String[] args) {

        try{

        Socket skt = new Socket( "localhost",2000);

        BufferedReader keyB = new BufferedReader(new InputStreamReader(System.in));
        BufferedReader br = new BufferedReader(new InputStreamReader(skt.getInputStream()));
        PrintStream ps = new PrintStream(skt.getOutputStream());

        String msg;

            do{
            msg = keyB.readLine();
            ps.println(msg);

            msg = br.readLine();
            System.out.println("From server "+msg);

        }while (!msg.equals("dne"));
        skt.close();
        } catch (UnknownHostException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

class Client2 {
    public static void main(String[] args) throws Exception {

        try {

            Socket skt = new Socket("localhost", 2000);

            BufferedReader keyB = new BufferedReader(new InputStreamReader(System.in));
            BufferedReader br = new BufferedReader(new InputStreamReader(skt.getInputStream()));
            PrintStream ps = new PrintStream(skt.getOutputStream());

            String msg;

            do {
                msg = keyB.readLine();
                ps.println(msg);

                msg = br.readLine();
                System.out.println("From server " + msg);

            } while (!msg.equals("dne"));
            skt.close();
        } catch (UnknownHostException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
