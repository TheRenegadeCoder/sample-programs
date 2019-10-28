import java.util.*;
public class RomanNumeralConversion
{
   public static Map<String,Integer> map = new HashMap<String,Integer>();
   public static void main(String[] args)
   {
      if(args.length<1)
         System.out.println("Usage: please provide a string of roman numerals");
      else {
         String number = args[0];
         if(number.length()==0)
            System.out.println("0");
         else {
            map.put("I",1);
            map.put("V",5);
            map.put("X",10);
            map.put("L",50);
            map.put("C",100);
            map.put("D",500);
            map.put("M",1000);
            int total = 0;
            for(int i=0; i<number.length(); i++) {
               String ch = number.substring(i,i+1);
               if(!map.containsKey(ch)) {
                  System.out.println("Error: invalid string of roman numerals");
                  return;
               }
               if(i==number.length()-1)
                  total+=map.get(ch);
               else {
                  String next = number.substring(i+1,i+2);
                  if(!map.containsKey(next)) {
                     System.out.println("Error: invalid string of roman numerals");
                     return;
                  }
                  if(map.get(ch)<map.get(next)) {
                     total+=map.get(next)-map.get(ch);
                     i++;
                  }
                  else {
                     total+=map.get(ch);
                  }
               }
            }
            System.out.println(total);
         }
      }
   }
}