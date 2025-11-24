import os
import sys
import argparse
import psycopg2
from psycopg2 import sql

DB_HOST = os.environ.get("POSTGRES_HOST", "127.0.0.1")
DB_PORT = int(os.environ.get("POSTGRES_PORT", 5432))
DB_NAME = os.environ.get("POSTGRES_DB", "gerenciamento_estagios")
DB_USER = os.environ.get("POSTGRES_USER", "admin")
DB_PASS = os.environ.get("POSTGRES_PASSWORD", "admin123")


def get_tables(conn):
    cur = conn.cursor()
    cur.execute("""
        SELECT table_schema, table_name
        FROM information_schema.tables
        WHERE table_type = 'BASE TABLE' AND table_schema NOT IN ('pg_catalog','information_schema')
        ORDER BY table_schema, table_name
    """)
    rows = cur.fetchall()
    cur.close()
    # return list of schema.table
    return [f"{r[0]}.{r[1]}" for r in rows]


def run_query(conn, table, limit=None):
    cur = conn.cursor()
    # Use psycopg2.sql to safely build a SELECT identifier
    identifier = sql.Identifier(*table.split('.', 1)) if '.' in table else sql.Identifier(table)
    q = sql.SQL('SELECT * FROM {tbl}').format(tbl=identifier)
    if limit:
        q = q + sql.SQL(' LIMIT {n}').format(n=sql.Literal(limit))
    cur.execute(q)
    rows = cur.fetchall()
    cols = [desc[0] for desc in cur.description] if cur.description else []
    cur.close()
    return cols, rows


def main():
    parser = argparse.ArgumentParser(description='Query tables in the PostgreSQL database')
    parser.add_argument('tables', nargs='*', help='Table name(s) to query (schema.name or name)')
    parser.add_argument('--list', action='store_true', help='List available tables and exit')
    parser.add_argument('--limit', '-n', type=int, default=50, help='Limit rows returned per table (default 50)')
    args = parser.parse_args()

    # connect
    conn = psycopg2.connect(host=DB_HOST, port=DB_PORT, dbname=DB_NAME, user=DB_USER, password=DB_PASS)

    try:
        if args.list:
            tbls = get_tables(conn)
            if not tbls:
                print('Nenhuma tabela encontrada.')
                return
            print('Tabelas disponíveis:')
            for t in tbls:
                print(' -', t)
            return

        # If no tables provided, show a simple interactive list selection
        targets = args.tables
        if not targets:
            tbls = get_tables(conn)
            if not tbls:
                print('Nenhuma tabela encontrada.')
                return
            print('Tabelas disponíveis:')
            for i, t in enumerate(tbls, 1):
                print(f'{i:3d}) {t}')
            sel = input('\nDigite números separados por vírgula (ex: 1,3) ou nomes (ex: professor): ').strip()
            if not sel:
                print('Nenhuma seleção — saindo.')
                return
            # parse selections
            chosen = []
            parts = [p.strip() for p in sel.split(',') if p.strip()]
            for p in parts:
                if p.isdigit():
                    idx = int(p) - 1
                    if 0 <= idx < len(tbls):
                        chosen.append(tbls[idx])
                else:
                    chosen.append(p)
            targets = chosen

        # Execute queries for each target
        for tbl in targets:
            try:
                cols, rows = run_query(conn, tbl, limit=args.limit)
            except Exception as e:
                print(f"Erro ao consultar '{tbl}': {e}")
                continue

            print('\n' + '='*60)
            print(f'Tabela: {tbl}  (mostrando até {args.limit} linhas)')
            if not rows:
                print('<vazio>')
                continue
            # print header
            print(' | '.join(cols))
            # print rows
            for r in rows:
                print(' | '.join(str(x) for x in r))

    finally:
        conn.close()


if __name__ == '__main__':
    main()
