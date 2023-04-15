import Database from 'better-sqlite3';

const options = { verbose: console.log };
export const db = new Database('./src/lib/database/vontigo.db', options);
db.pragma('journal_mode = WAL');
