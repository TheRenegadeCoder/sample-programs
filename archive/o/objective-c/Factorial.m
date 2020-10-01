#include <Foundation/Foundation.h>

@interface Math : NSObject
+ (int)factorial:(int)n;
@end;

@implementation Math
+ (int)factorial:(int)n
{
	if (n == 0)
		return 1;
	return n * [Math factorial:n-1];
}
@end

int main() {
	int number = 5;
	int result = [Math factorial:number];
	printf("The factorial number of %i is %i!", number, result);
	return 0;
}