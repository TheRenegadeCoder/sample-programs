print "\nThe following program will help you to find wheteher a number is Prime Number or Not.";
print "\nPlease enter a number : ";

$num=<>;							#Num variable for storing input number
$determiner=0;							#variable to check whether a number is prime or not. Output depends on variable's value.
if($num==2)							#Basic Condition (Exceptiional)
{
print "Prime number.num";
}
else
{
for($c=2;$c<=$num-1;$c++)					#Basic Condition
{
if($num%$c==0)							#Dividin number with 2 and checking whether it is divisible or not.
{
$determiner=1;
break;
}
}
if($determiner==1)
{
print "\nNot prime.num";
}
else
{
print "\nPrime number.num";
}
}
