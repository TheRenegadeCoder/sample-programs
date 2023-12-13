#import <Foundation/Foundation.h>

NSString* readFileWith(NSString* path) {
  NSFileHandle* fileHandle = [NSFileHandle fileHandleForReadingAtPath:path];
  if (fileHandle) {
    @try {
      NSData* fileData  = [fileHandle availableData];
      return [[NSString alloc] initWithBytes:[fileData bytes] length:[fileData length] encoding:NSUTF8StringEncoding];
    } @catch (NSException *e) {
      printf("Error reading file %s\n", [e UTF8String]);
      return nil;
    }
    @finally{
      [fileHandle closeFile];
    }
  }else{
    printf("File to read not found %s\n", [path UTF8String]);
  }
  
};

BOOL writeFileWith(NSString* path, NSString* content) {
  NSFileHandle* fileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
  if(fileHandle){
    @try {
      NSData* fileData  = [content dataUsingEncoding:NSUTF8StringEncoding];
      [fileHandle writeData:fileData];
      return YES;
    } @catch (NSException *e) {
      printf("Error writing file %s\n", [e UTF8String]);
      return NO;
    }
    @finally{
      [fileHandle closeFile];
    }
  }else{
    printf("File to write not found %s\n", [path UTF8String]);
  }
  
};

BOOL createFileIfNotExistsAt(NSString* path) {
  return [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
};

int main(int argc, const char * argv[]) {
  NSAutoreleasePool *pool =[[NSAutoreleasePool alloc] init];
  NSString* path = @"output.txt";
  if(createFileIfNotExistsAt(path)){
    BOOL result = writeFileWith(path, @"Hello!\nGoodbye!\n");
    if (result) {
      NSString* contents = readFileWith(path);
      if (contents) {
        printf("%s", [contents UTF8String]);
      }
    }
  }else{
    printf("Unable to create file at %s\n", [path UTF8String]);
  }
  [pool drain];
  return 0;
}
