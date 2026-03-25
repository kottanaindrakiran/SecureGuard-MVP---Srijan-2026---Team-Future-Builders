import sqlite3
import json
import os
from datetime import datetime

class Cache:
    def __init__(self):
        self.db_path = os.path.join(os.path.expanduser('~'), '.secureguard_cache.db')
        self._init_db()

    def _init_db(self):
        with sqlite3.connect(self.db_path) as conn:
            conn.execute('''
                CREATE TABLE IF NOT EXISTS scan_cache (
                    package TEXT,
                    ecosystem TEXT,
                    score INTEGER,
                    data_json TEXT,
                    cached_at TIMESTAMP,
                    PRIMARY KEY (package, ecosystem)
                )
            ''')

    def save(self, package, ecosystem, score, data):
        with sqlite3.connect(self.db_path) as conn:
            conn.execute('''
                INSERT OR REPLACE INTO scan_cache (package, ecosystem, score, data_json, cached_at)
                VALUES (?, ?, ?, ?, ?)
            ''', (package, ecosystem, score, json.dumps(data), datetime.now()))

    def get(self, package, ecosystem):
        with sqlite3.connect(self.db_path) as conn:
            cursor = conn.execute('''
                SELECT score, data_json FROM scan_cache 
                WHERE package = ? AND ecosystem = ?
            ''', (package, ecosystem))
            row = cursor.fetchone()
            if row:
                return {'package': package, 'score': row[0], 'data': json.loads(row[1])}
        return None

    def get_last(self):
        with sqlite3.connect(self.db_path) as conn:
            cursor = conn.execute('SELECT package, score, data_json FROM scan_cache ORDER BY cached_at DESC LIMIT 1')
            row = cursor.fetchone()
            if row:
                return {'package': row[0], 'score': row[1], 'data': json.loads(row[2])}
        return None

    def clear(self):
        if os.path.exists(self.db_path):
            os.remove(self.db_path)
        self._init_db()
