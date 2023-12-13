#import <Foundation/Foundation.h>

int main (int argc, const char * argv[])
{
   NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
   NSString *s = @"Hello, World!";
   printf("%s\n", [s UTF8String]);
   [pool drain];
   return 0;
}
