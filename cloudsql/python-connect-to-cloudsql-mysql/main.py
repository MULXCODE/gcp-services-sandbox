import MySQLdb

host="127.0.0.1"
user="your_user"
password="your_pass"
db_schema="db_schema"

db=MySQLdb.connect(host=host,user=user,passwd=password,db=db_schema)
c = db.cursor()
print(c.execute("SHOW DATABASES"))