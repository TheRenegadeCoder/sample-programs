#include <stdio.h>
int main(){
   int m, n, i, j, matrix[10][10], transpose[10][10];
   printf("Enter the no of rows  :\n");
   scanf("%d",&m);
   printf("Enter the number of columns :\n");
   scanf("%d",&n);
   printf("Enter elements of the matrix\n");
   for (i= 0; i < m; i++)
      for (j = 0; j < n; j++)
         scanf("%d", &matrix[i][j]);
  
   printf("your entered matrix is !\n");
   
   for (i= 0; i < m; i++){
      for (j = 0; j < n; j++)
         printf("%d\t", matrix[i][j]);
         printf("\n");
    }     
     
   for (i = 0;i < m;i++)
      for (j = 0; j < n; j++)
         transpose[j][i] = matrix[i][j];
   printf("Transpose of the matrix:\n");
   for (i = 0; i< n; i++) {
      for (j = 0; j < m; j++)
         printf("%d\t", transpose[i][j]);
         printf("\n");
   }
   return 0;
}
