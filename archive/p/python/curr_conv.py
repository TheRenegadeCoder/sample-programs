import requests

class Currency_converter:
    rates = {}

    def __init__(self,url):
        data=requests.get(url).json()
        self.rates = data["rates"]

    def convert(self , from_currency , to_currency , amount):
        initial_amount = amount

        if from_currency != 'EUR' :
            amount = amount / self.rates[from_currency]

        amount = round(amount * self.rates[to_currency] , 2)
        print('{} {} = {} {}'.format(initial_amount , from_currency , amount , to_currency))

if __name__ == "__main__":
    YOUR_ACCESS_KEY='GET YOUR ACCESS KEY FROM fixer.io'
    url=str.__add__('http://data.fixer.io/api/latest?access_key=' , YOUR_ACCESS_KEY)
    c=Currency_converter(url)
    from = 'USD'
    to = 'INR'
    amount = 1

    c.convert(from , to , amount)
