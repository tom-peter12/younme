import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:chatter/models/contacts_data.dart';

class ContactsDatabase {
  static final ContactsDatabase instance = ContactsDatabase._init();

  static Database? _database;

  ContactsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('contacts.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE $tableContacts ( 
        ${ContactsField.user_id} $idType, 
        ${ContactsField.user_name} $textType,
        ${ContactsField.phone_number} $textType,
        ${ContactsField.public_key} $textType,
        ${ContactsField.preshared_key} $textType
      )
    ''');
  }

  Future<Contacts> create(Contacts contact) async {
    final db = await instance.database;

    final id = await db.insert(tableContacts, contact.toJson());
    return contact.copy(user_id: id);
  }

  Future<int> update(Contacts contacts) async {
    final db = await instance.database;

    return db.update(
      tableContacts,
      contacts.toJson(),
      where: '${ContactsField.user_id} = ?',
      whereArgs: [contacts.user_id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
