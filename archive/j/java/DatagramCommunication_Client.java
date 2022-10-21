import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;

public class NP2_DatagramCommunication_Client {
    public static void main(String[] args) throws Exception {

        DatagramSocket ds = new DatagramSocket(2001);

        String msg = " hello my world";
        DatagramPacket dp = new DatagramPacket(msg.getBytes(), msg.length(), InetAddress.getByName("localhost"), 2000);

        ds.send(dp);

        byte b[] = new byte[100];
        dp = new DatagramPacket(b, 100);
        ds.receive(dp);

        msg = new String(dp.getData()).trim();
        System.out.println("From Server " + msg);

        ds.close();
    }
}

class Server {
    public static void main(String[] args) throws Exception {

        DatagramSocket ds = new DatagramSocket(2000);

        byte b[] = new byte[100];
        DatagramPacket dp = new DatagramPacket(b, 100);
        ds.receive(dp);

        String msg = new String(dp.getData()).trim();
        System.out.println("From Client " + msg);

        StringBuilder sb = new StringBuilder(msg);
        sb.reverse();
        msg = sb.toString();

        dp = new DatagramPacket(msg.getBytes(),msg.length(),InetAddress.getByName("localhost"),2001);
        ds.send(dp);

        ds.close();
    }
}
