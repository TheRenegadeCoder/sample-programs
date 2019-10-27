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
    char textInput[1000];
    scanf ("%[^\n]%*c", textInput);
    NSString *userInput =[NSString stringWithUTF8String:textInput];
    if([userInput length] > 0){
        NSLog(@"\n%@", userInput);
        StringHelper* helper = [[StringHelper alloc] init];
        NSLog(@"\n%@", [helper reverseString: userInput]);  
    }
    [pool drain];
    return 0;
}
