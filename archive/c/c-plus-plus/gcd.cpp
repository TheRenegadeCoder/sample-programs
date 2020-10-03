int findGCF(int num1, int num2)
{
  int r =1;
  while(r != 0){
  	r = num1%num2;
  	num1 = num2;
  	num2 = r;
  }
  return num1;
}