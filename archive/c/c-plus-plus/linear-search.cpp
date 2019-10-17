#include <iostream>

int main() {
  int size, key;
  std::cout<<"Enter the size of array: ";
  std::cin>>size;
  int array[size];
  std::cout<<"Enter the elements of array: \n";
  for(int i=0; i<size; i++) {
    std::cout<<"Enter array element at position "<<i+1<<": ";
    std::cin>>array[i];
  }
  std::cout<<"Enter the key to search: ";
  std::cin>>key;
  int flag=0, pos=-1;
  for(int i=0; i<size; i++)
    if(array[i] == key) {
      flag = 1;
      pos = i;
      break;
    }
  if(flag)
    std::cout<<key<<" is found at position "<<pos+1<<".\n";
  else
    std::cout<<key<<" is not found in array.\n";

  return 0;
}
