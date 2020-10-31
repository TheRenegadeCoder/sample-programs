mport mysql.connector
import pandas as pd

mydb = mysql.connector.connect(
  host="",
  user="",
  password="",
  database=""
)
mycursor = mydb.cursor(buffered=True)

query = "SELECT * FROM TableName"
print("Reading...")
service = pd.read_sql(query,mydb)
print("Done!")
print(service.memory_usage().sum()//10**3,end="")
print("KB")
