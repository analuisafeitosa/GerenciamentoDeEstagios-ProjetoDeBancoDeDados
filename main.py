import psycopg2

conn = psycopg2.connect(host = "127.0.0.1", port = 8888, dbname ="gerenciamento_estagios", user="admin", password="admin123")

cur = conn.cursor()
cur.execute("SELECT current_user, current_database")
print("Sessão", cur.fetchall())

cur.execute("SELECT * FROM pessoa;")
print("Dados pessoas", cur.fetchall())

cur.close()
conn.close()
