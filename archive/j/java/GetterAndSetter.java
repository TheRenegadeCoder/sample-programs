import java.util.Scanner;

class GetterAndSetter{
    public int length;
    public int width;
  
    public One(){
        length = 0;
        width = 0;
    }
    
public One(int length, int width){
    this.length = length;
    this.length = length;
}    
    
public void setLength(int length){
    this.length = length;
}    
    
public int getLength(int length){
    return length;
}    
    
public void setWidth(int width){
    this.width = width;
}    
    
public int getWidth(int width){
    return width;
}    
    
public void acceptData(){
    Scanner jo = new Scanner(System.in);
    System.out.println("Enter length");
    length = jo.nextInt();
    System.out.println("Enter width");
    width= jo.nextInt();
}    
    
public void showData(){
    System.out.println("Length "+ length);
    System.out.println("Width "+ width);
}    
    
public int getArea(){
    return length*width;
}    
    
public int getPeri(){
    return 2*(length+width);
}    
    
public static void main(String args[]){
    One o = new One();
    o.acceptData();
    o.showData();
    System.out.println("Area is " + o.getArea());
    System.out.println("Perimeter is " + o.getPeri());
}    
   
}