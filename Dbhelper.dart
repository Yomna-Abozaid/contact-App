import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/contact.dart';

class Db_Helper {
  static final Db_Helper _instance = Db_Helper.internal();
  factory Db_Helper() => _instance;
  Db_Helper.internal();

  static Database? _db;
  Future<Database> createDatabase() async {
    if (_db != null) {
      print('Database already exists.');
      return _db!;
    }
    String path = join(await getDatabasesPath(), 'contact.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        print('Creating database and tables...');
        return db.execute(
            'CREATE TABLE contacts(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,phone TEXT,imgUrl TEXT)');
      },
    );
    print('Database created successfully.');
    return _db!;
  }

  Future<int> insertContact(Contact contact) async {
    Database db = await createDatabase();
    print('Inserting contact: $contact');
    int result = await db.insert('contacts', contact.toMap());
    print('Contact inserted successfully with id: $result');
    return result;
  }

  Future<List<Map<String, dynamic>>> getContacts() async {
    Database db = await createDatabase();
    print('Fetching Contact from the database.');
    List<Map<String, dynamic>> contacts = await db.query('contacts');
    print('Fetched ${contacts.length} contacts from the database.');
    return contacts;
  }

  Future<int> deleteContact(int id) async {
    Database db = await createDatabase();
    print('Deleting Contact with id: $id');
    int result = await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
    print('Contact deleted successfully. Deleted $result record(s).');
    return result;
  }

  contactUpdate(Contact contact) async {
    Database db = await createDatabase();
    return await db.update('contacts', contact.toMap(),
        where: 'id = ?', whereArgs: [contact.id]);
  }
}
