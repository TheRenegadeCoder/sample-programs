public class BubbleSort {
    public static void BubbleSort( int [ ] no )
    {
        int j;
        boolean flag = true;
        int temp;

        while ( flag )
        {
            flag= false;
            for( j=0;  j < no.length -1;  j++ )
            {
                if ( no[ j ] < no[j+1] )
                {
                    temp = no[ j ];
                    no[ j ] = no[ j+1 ];
                    no[ j+1 ] = temp;
                    flag = true;
                }
            }
        }

        for(int p = 0 ;p<no.length;p++)
        {
            System.out.println(" "+no[p]);
        }
    }

    public static void main(String[] args) {
        int[] no = {10,20,30,70,90,02,03,05,65,72,23};
        BubbleSort(no);
    }
}
