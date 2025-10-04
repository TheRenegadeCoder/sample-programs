//
//  main.m
//
//  QuickSort in ObjC
//


#import <Foundation/Foundation.h>

// Function to convert and validate the input string
// Source: ChatGPT
NSInteger convertAndValidateInput(NSString *inputString) {
    NSScanner *scanner = [NSScanner scannerWithString:inputString];
    NSInteger integerValue = 0;

    // Check if the scanner successfully scanned an integer
    if ([scanner scanInteger:&integerValue] && [scanner isAtEnd]) {
        return integerValue;
    } else {
        // Raise an exception for invalid input
        @throw [NSException exceptionWithName:@"InvalidInputException"
            reason:@"Input is not a valid integer"
            userInfo:nil];
    }
}

// Function to convert a comma-separated string to an array of integers
// Source: ChatGPT
NSArray *convertStringToListOfIntegers(NSString *inputString) {
    NSMutableArray *resultArray = [NSMutableArray array];

    // Separate the input string into components using the comma as a delimiter
    NSArray *components = [inputString componentsSeparatedByString:@","];

    // Convert each component to an integer using the previous function
    for (NSString *component in components) {
        NSNumber *numberValue = [NSNumber numberWithInteger:convertAndValidateInput(component)];
        [resultArray addObject:numberValue];
    }

    return [resultArray copy];
}

// Display array of integers
void displayListOfIntegers(NSArray *integerArray) {
    NSString *displayString = [integerArray componentsJoinedByString:@", "];
    printf("%s\n", [displayString UTF8String]);
}

NSArray *quickSort(NSArray *dataset) {
    int numberOfItems = (int)[dataset count];
    
    if (numberOfItems < 2) {
        return dataset;
    }

    // Here, the pivot variable is the item in the  m i d d l e  of the array.
    // There are also other ways to find the pivot item.
    int pivotIndex = numberOfItems/2;
    int pivot = [[dataset objectAtIndex: pivotIndex] intValue];

    NSMutableArray *less = [NSMutableArray array];
    NSMutableArray *greater = [NSMutableArray array];
    NSMutableArray *equal = [NSMutableArray array];
    
    int i = 0;
    while (i < numberOfItems) {
        int item = [[dataset objectAtIndex: i] intValue];

        if (item < pivot) {
            [less addObject: [dataset objectAtIndex: i]];
        } else if (item > pivot) {
            [greater addObject: [dataset objectAtIndex: i]];
        } else if (pivot == item) {
            [equal addObject: [dataset objectAtIndex: i]];
        }
        i++;
    }

    NSMutableArray *returnSortedArray = [NSMutableArray array];
    [returnSortedArray addObjectsFromArray: quickSort(less)];
    [returnSortedArray addObjectsFromArray: equal];
    [returnSortedArray addObjectsFromArray: quickSort(greater)];

    return returnSortedArray;
}

int main(int argc, char *argv[]) {
    NSAutoreleasePool *pool =[[NSAutoreleasePool alloc] init];
    NSString *usage = @"Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"";
    if (argc < 2) {
        printf("%s\n", [usage UTF8String]);
    }
    else {
        NSString* inputStr = [NSString stringWithUTF8String:argv[1]];
        @try {
            NSArray *inputArray = convertStringToListOfIntegers(inputStr);
            if ([inputArray count] < 2) {
                printf("%s\n", [usage UTF8String]);
            }
            else {
                NSArray *sortedArray = quickSort(inputArray);
                displayListOfIntegers(sortedArray);
            }
        }
        @catch (NSException *) {
            printf("%s\n", [usage UTF8String]);
        }
    }

    [pool drain];
    return 0;
}
