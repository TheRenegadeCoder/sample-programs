def isLeapYear(n):
  if (n%100!=0 and n%4==0) or (n%100==0 and n%400==0):
    return True
  else:
    return False

year=int(input())
if isLeapYear(year)==True:
  print("Leap Year")
else:
  print("Not a leap year")
