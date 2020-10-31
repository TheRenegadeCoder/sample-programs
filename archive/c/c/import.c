/*Call the varian;es defined in external file and print them*/
#include <stdio.h>
#include "export.c"

extern int var1, var2;
void main()
{
    printf ("%d, %d", var1, var);
}
