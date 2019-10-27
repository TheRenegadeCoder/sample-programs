from datetime import date
from sys import argv

# ENTER THE DAY AS YYYY-MM-DD as a single argument on the command line
# ie, python days_since_date.py 2019-10-25

input_str = argv[1]
input_int = input_str.split('-')
input_int = [int(x) for x in input_int]

start = date(input_int[0], input_int[1], input_int[2])
today = date.today()
delta = today - start

if delta.days == 1:
    days = 'day'
else:
    days = 'days'

print("Today is {} {} since {}".format(delta.days, days, input_str))
