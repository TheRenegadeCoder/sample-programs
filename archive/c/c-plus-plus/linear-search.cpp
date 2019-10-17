#include <iostream>
#include <vector>
#include <sstream>

std::vector<int> sysarg_to_list(std::string str) {
  std::vector<int> ret;
  std::string s = "";
  for(int i=0; i<str.length(); i++) {
    if(str[i] == ' ')
      continue;
    if(str[i] == ',') {
      std::stringstream ss(s);
      int num = 0;
      ss >> num;
      ret.push_back(num);
      s = "";
      continue;
    }
    s += str[i];
  }
  std::stringstream ss(s);
  int num = 0;
  ss >> num;
  ret.push_back(num);
  return ret;
}

int main(int argc, char** argv) {
  int size, key;
  key = atoi(argv[1]);
  std::string arr_string = argv[2];

  std::vector<int> array = sysarg_to_list(arr_string);
  size = array.size();

  int flag=0, pos=-1;

  for(int i=0; i<size; i++)
    if(array[i] == key) {
      flag = 1;
      pos = i;
      break;
    }
  if(flag)
    std::cout<<key<<" is found at position "<<pos<<".\n";
  else
    std::cout<<key<<" is not found in array.\n";

  return 0;
}
