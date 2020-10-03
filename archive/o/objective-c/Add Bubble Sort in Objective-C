
    NSArray *dArray =@[@101, @201, @301,@121,@11,@123,@21,@14,@32,@76,@89,@987,@65];
    NSMutableArray *dataArray = [NSMutableArray arrayWithArray:dArray];
    
    NSArray *bubbleSortedArray = [self bubbleSort:dataArray];
    NSLog(@"bubbleSortCount %d",bubbleSortCount);     //Number of Iterations //bubbleSortCount is a static variable initialized to 0 //Gives the average & worst case of n^2
    NSLog(@"bubbleSortedArray %@",bubbleSortedArray); //Prints the sorted array
    bubbleSortCount =0;  //Reinitialize the static variable to 0 to retest
    NSLog(@"bubbleSortedArray %@",[self bubbleSort:bubbleSortedArray]); //Resort the already sorted array
    NSLog(@"bubbleSortCount %d",bubbleSortCount); //Gives the best case count of n


-(NSArray *)bubbleSort:(NSMutableArray *)unsortedDataArray
{
    long count = unsortedDataArray.count;
    int i;
    bool swapped = TRUE;
    while (swapped){
    swapped = FALSE;
    for (i=1; i<count;i++)         
    {             
            if ([unsortedDataArray objectAtIndex:(i-1)] > [unsortedDataArray objectAtIndex:i])
            {
                [unsortedDataArray exchangeObjectAtIndex:(i-1) withObjectAtIndex:i];
                swapped = TRUE;
            }
            //bubbleSortCount ++; //Increment the count everytime a switch is done, this line is not required in the production implementation.
        }
    }
    return unsortedDataArray;
}
