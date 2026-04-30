#import <Foundation/Foundation.h>
#include <stdlib.h>

@interface NSString (FileIO)
- (BOOL)writeToDefaultPath:(NSString*)path error:(NSError**)error;
+ (nullable instancetype)stringWithDefaultPath:(NSString*)path
                                         error:(NSError**)error;
@end

@implementation NSString (FileIO)

- (BOOL)writeToDefaultPath:(NSString*)path error:(NSError**)error {
    NSURL* url = [NSURL fileURLWithPath:path];
    return [self writeToURL:url
                 atomically:YES
                   encoding:NSUTF8StringEncoding
                      error:error];
}

+ (instancetype)stringWithDefaultPath:(NSString*)path error:(NSError**)error {
    NSURL* url = [NSURL fileURLWithPath:path];
    return [self stringWithContentsOfURL:url
                                encoding:NSUTF8StringEncoding
                                   error:error];
}

@end

int main(int argc, const char* argv[]) {
    @autoreleasepool {
        NSString* path = @"output.txt";
        NSString* content = @"Hello!\nGoodbye!\n";
        NSError* error = nil;

        if (![content writeToDefaultPath:path error:&error]) {
            fprintf(stderr, "Write Error: %s\n",
                    error.localizedDescription.UTF8String);
            return EXIT_FAILURE;
        }

        NSString* result = [NSString stringWithDefaultPath:path error:&error];
        if (!result) {
            fprintf(stderr, "Read Error: %s\n",
                    error.localizedDescription.UTF8String);
            return EXIT_FAILURE;
        }

        printf("%s", result.UTF8String);
    }
    return EXIT_SUCCESS;
}