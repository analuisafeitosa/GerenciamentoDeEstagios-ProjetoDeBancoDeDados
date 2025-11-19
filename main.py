import psycopg2

conn = psycopg2.connect(host = "localhost", port = 8888, dbname ="gerenciamento_estagios", user="admin", password="admin123")
cursor = conn.cursor()
result = cursor.fetchall()
print(result)
cursor.close()
conn.close()
