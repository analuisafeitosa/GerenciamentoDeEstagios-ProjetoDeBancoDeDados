import os
import time
import psycopg2

DB_HOST = os.environ.get("POSTGRES_HOST", "127.0.0.1")
DB_PORT = int(os.environ.get("POSTGRES_PORT", 5432))
DB_NAME = os.environ.get("POSTGRES_DB", "gerenciamento_estagios")
DB_USER = os.environ.get("POSTGRES_USER", "admin")
DB_PASS = os.environ.get("POSTGRES_PASSWORD", "admin123")

def wait_for_db(retries=10, delay=2):
	for i in range(retries):
		try:
			conn = psycopg2.connect(host=DB_HOST, port=DB_PORT, dbname=DB_NAME, user=DB_USER, password=DB_PASS)
			return conn
		except Exception as e:
			print(f"Conexão ao Postgres falhou (tentativa {i+1}/{retries}): {e}")
			time.sleep(delay)
	raise RuntimeError("Não foi possível conectar ao banco de dados")


def main():
	conn = wait_for_db(retries=30, delay=2)
	cur = conn.cursor()
	cur.execute("SELECT current_user, current_database();")
	print("Sessão", cur.fetchall())

	try:
		cur.execute("SELECT * FROM pessoa;")
		print("Dados pessoas", cur.fetchall())
	except Exception as e:
		print("Erro ao ler tabela 'pessoa':", e)

	cur.close()
	conn.close()


if __name__ == '__main__':
	main()
