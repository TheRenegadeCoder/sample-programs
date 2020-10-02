#import <Foundation/Foundation.h>
int main (int argc, char *argv[])
{
 NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
 
 int numbertotest, remainder;
 NSLog(@"Enter your number to be tested: ");
 scanf("%i", &numbertotest);
 
 remainder = numbertotest % 2;
 
 if (remainder == 0)
 NSLog(@"The number is even.");
 else
 NSLog(@"The number is odd.");
 
 [pool drain];
 return 0;
}