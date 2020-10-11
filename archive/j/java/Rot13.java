public class Rot13
{
   public static void main(String[] args)
   {
      if(args.length<1) {
         System.out.println("Usage: please provide a string to encrypt");
      }
      else {
         String code = args[0];
         String result = "";
         if(code.length()==0) {
            System.out.println("Usage: please provide a string to encrypt");
         }
         else {
            String lower = "abcdefghijklmnopqrstuvwxyz";
            String upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            for(int a=0; a<code.length(); a++) {
               String ch = code.substring(a,a+1);
               int l = lower.indexOf(ch);
               int u = upper.indexOf(ch);
               if(l!=-1) {
                  result+=lower.substring( (l+13)%26,(l+14)%26!=0 ? (l+14)%26 : l+14 );
               }
               else if(u!=-1) {
                  result+=upper.substring( (u+13)%26,(u+14)%26!=0 ? (u+14)%26 : u+14 );
               }
               else {
                  result+=ch;
               }
            }
            System.out.println(result);
         }
      }
   }
}