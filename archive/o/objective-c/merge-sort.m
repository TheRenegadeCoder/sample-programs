#import <Foundation/Foundation.h>

@interface NSString (Parsing)
- (nullable NSArray<NSNumber*>*)strictIntegerList;
@end

@implementation NSString (Parsing)

- (NSArray<NSNumber*>*)strictIntegerList {
    NSArray<NSString*>* parts = [self componentsSeparatedByString:@","];
    NSMutableArray<NSNumber*>* results =
        [NSMutableArray arrayWithCapacity:parts.count];
    NSCharacterSet* invertedDigits =
        NSCharacterSet.decimalDigitCharacterSet.invertedSet;

    for (NSString* raw in parts) {
        NSString* s = [raw stringByTrimmingCharactersInSet:
                               NSCharacterSet.whitespaceAndNewlineCharacterSet];
        if (s.length == 0) return nil;

        NSString* core = ([s hasPrefix:@"-"] || [s hasPrefix:@"+"])
                             ? [s substringFromIndex:1]
                             : s;
        if (core.length == 0 ||
            [core rangeOfCharacterFromSet:invertedDigits].location !=
                NSNotFound)
            return nil;

        [results addObject:@(s.longLongValue)];
    }
    return (results.count >= 2) ? results : nil;
}

@end

@interface NSArray (Sorting)
- (NSArray<NSNumber*>*)sortedArrayUsingMergeSort;
@end

@interface NSArray (SortingInternal)
- (NSArray<NSNumber*>*)recursivelySortedArray;
- (NSArray<NSNumber*>*)mergedWithArray:(NSArray<NSNumber*>*)other;
@end

@implementation NSArray (Sorting)

- (NSArray<NSNumber*>*)sortedArrayUsingMergeSort {
    if (self.count < 2) return self;
    return [self recursivelySortedArray];
}

@end

@implementation NSArray (SortingInternal)

- (NSArray<NSNumber*>*)recursivelySortedArray {
    if (self.count < 2) return self;

    NSUInteger mid = self.count / 2;

    NSArray* left =
        [[self subarrayWithRange:NSMakeRange(0, mid)] recursivelySortedArray];

    NSArray* right =
        [[self subarrayWithRange:NSMakeRange(mid, self.count - mid)]
            recursivelySortedArray];

    return [left mergedWithArray:right];
}

- (NSArray<NSNumber*>*)mergedWithArray:(NSArray<NSNumber*>*)other {
    NSMutableArray* result =
        [NSMutableArray arrayWithCapacity:self.count + other.count];

    NSUInteger i = 0, j = 0;

    while (i < self.count && j < other.count) {
        if ([self[i] compare:other[j]] != NSOrderedDescending) {
            [result addObject:self[i++]];
        } else {
            [result addObject:other[j++]];
        }
    }

    if (i < self.count) {
        [result addObjectsFromArray:[self subarrayWithRange:NSMakeRange(
                                                                i, self.count -
                                                                       i)]];
    }

    if (j < other.count) {
        [result
            addObjectsFromArray:[other
                                    subarrayWithRange:NSMakeRange(
                                                          j, other.count - j)]];
    }

    return result;
}

@end

int main(int argc, const char* argv[]) {
    @autoreleasepool {
        const char* usage =
            "Usage: please provide a list of at least two integers to sort in "
            "the format \"1, 2, 3, 4, 5\"";

        if (argc < 2) {
            puts(usage);
            return 1;
        }

        NSArray<NSNumber*>* numbers = @(argv[1]).strictIntegerList;

        if (!numbers) {
            puts(usage);
            return 1;
        }

        NSString* output = [[numbers sortedArrayUsingMergeSort]
            componentsJoinedByString:@", "];

        puts(output.UTF8String);
    }
    return 0;
}