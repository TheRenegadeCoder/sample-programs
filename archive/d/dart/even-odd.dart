void main(List<String> args) {
  try{
    (int.parse(args[0])%2 == 0)?print("Even"):print("Odd");
  }
  catch(e){
    print("Usage: please input a number");
  }
}


