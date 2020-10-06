////////////////MERGE-SORT////////////////
NSArray* mergeArrays(NSArray* A, NSArray* B) 
{
    NSMutableArray *orderedArray = [NSMutableArray new];
    long indexLeft = 0;
    long indexRight = 0;
    
    while (indexLeft < [A count] && indexRight < [B count]) {
        if ([A[indexLeft] intValue] < [B[indexRight]intValue]) {
            [orderedArray addObject:A[indexLeft++]];
        }else if ([A[indexLeft] intValue] > [B[indexRight]intValue]){
            [orderedArray addObject:B[indexRight++]];
        }else { //equal values
            [orderedArray addObject:A[indexLeft++]];
            [orderedArray addObject:B[indexRight++]];
        }
    }
    
    //If one array has more positions than the other (odd lenght of the inital array)
    NSRange rangeRestLeft = NSMakeRange(indexLeft, A.count - indexLeft);
    NSRange rangeRestRight = NSMakeRange(indexRight, B.count - indexRight);
    NSArray *arrayTotalRight = [B subarrayWithRange:rangeRestRight];
    NSArray *arrayTotalLeft = [A subarrayWithRange:rangeRestLeft];
    arrayTotalLeft = [orderedArray arrayByAddingObjectsFromArray:arrayTotalLeft];
    NSArray *orderedArrayCompleted = [arrayTotalLeft arrayByAddingObjectsFromArray:arrayTotalRight];
    return orderedArrayCompleted;
}

NSArray* mergeSort(NSArray* randomArray){
    
    if ([randomArray count] < 2)
    {
        return randomArray;
    }
    int middlePivot = (int)[randomArray count]/2;
    NSRange rangeLeft = NSMakeRange(0, middlePivot);
    NSRange rangeRight = NSMakeRange(middlePivot, randomArray.count-middlePivot);
    NSArray *leftArray = [randomArray subarrayWithRange:rangeLeft];
    NSArray *rightArray = [randomArray subarrayWithRange:rangeRight];
    return mergeArrays(mergeSort(leftArray),mergeSort(rightArray));
}