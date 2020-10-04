#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
  @autoreleasepool {
    
    NSLog(@"Enter the text to be capitalized: ");
    NSString* textFromStdin = [[NSString alloc] initWithData:[[NSFileHandle fileHandleWithStandardInput] availableData] encoding:NSUTF8StringEncoding];
    
    NSString* normalizedText = [textFromStdin stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    if([normalizedText length] < 1){
      NSLog(@"Usage: please provide a string");
      return 0;
    }
    
    NSString *firstChar = [[normalizedText substringToIndex:1] uppercaseString];
    NSString *remainingText = [normalizedText substringFromIndex:1];
    NSString *capitalizedText = [firstChar stringByAppendingString:remainingText];
    
    NSLog(@"%@", capitalizedText);
    
    return 0;
    
  }
  return 0;
}
