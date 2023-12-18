#import <Foundation/Foundation.h>

@interface StringHelper:NSObject
- (NSString *) reverseString:(NSString *)stringToReverse;
@end

@implementation StringHelper 
- (NSString *) reverseString:(NSString *)stringToReverse {
    NSMutableString* result = [NSMutableString string];
    NSInteger index = [stringToReverse length];
    while (index > 0) {
        index--;
        NSRange range = NSMakeRange(index, 1);
        [result appendString:[stringToReverse substringWithRange:range]];
    }
    return result;
}

@end

int main (int argc, const char *argv[]){
    NSAutoreleasePool *pool =[[NSAutoreleasePool alloc] init];
    if (argc >= 2){
        NSString *userInput =[NSString stringWithUTF8String:argv[1]];
        if([userInput length] > 0){
            StringHelper* helper = [[StringHelper alloc] init];
            printf("%s\n", [[helper reverseString: userInput] UTF8String]);
        }
    }
    [pool drain];
    return 0;
}
