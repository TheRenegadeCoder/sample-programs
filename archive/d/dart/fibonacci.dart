void main(List<String> args) {
  try{
    int first = 0;
    int second = 1;
    int val = 1;
    for(int i=1; i<int.parse(args[0])+1; i++){
      print("${i}: ${val}");
      val = first+second;
      first = second;
      second = val;
    }
  }
  catch(e){
    print("Usage: please input the count of fibonacci numbers to output");
  }
}

