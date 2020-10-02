#Perl Program to print whether a number is prime or not.

print "\nThe following progrmam will help you find out whether a number is prime or not.";
print "\nPlease enter a number";

#Main Execution Below ...

$num=<>;					#Num Variable to store input of user
$determiner=0;					#Variable to print Primne / Not Prime Number.
if($num==2)					#Basic Condition(Exceptional)
{
print "\nPrime number.num";
}
else
{
for($c=2;$c<=$num-1;$c++)
{
if($num%$c==0)					#Dividing num with 2
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

#End.
