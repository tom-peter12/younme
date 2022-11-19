// ignore_for_file: constant_identifier_names, non_constant_identifier_names

const String tableContacts = 'Contacts';

class ContactsField {
  static final List<String> values = [
    /// Add all fields
    user_id, user_name, phone_number, public_key, preshared_key
  ];

  static const String user_id = '_id';
  static const String user_name = 'username';
  static const String phone_number = 'phonenumber';
  static const String public_key = 'publickey';
  static const String preshared_key = 'presharedkey';
}

class Contacts {
  final int? user_id;
  final String user_name;
  // final String email;
  final String phone_number;
  final String public_key;
  final String preshared_key;

  const Contacts({
    this.user_id,
    required this.user_name,
    // required this.email,
    required this.phone_number,
    required this.public_key,
    required this.preshared_key,
  });

  Contacts copy({
    int? user_id,
    String? user_name,
    // String? email,
    String? phone_number,
    String? public_key,
    String? preshared_key,
  }) =>
      Contacts(
        user_id: user_id ?? this.user_id,
        user_name: user_name ?? this.user_name,
        // email: email ?? this.email,
        phone_number: phone_number ?? this.phone_number,
        public_key: public_key ?? this.public_key,
        preshared_key: preshared_key ?? this.preshared_key,
      );

  static Contacts fromJson(Map<String, Object?> json) => Contacts(
        user_id: json[ContactsField.user_id] as int?,
        user_name: json[ContactsField.user_name] as String,
        // email: json[ContactsField.email] as String,
        phone_number: json[ContactsField.phone_number] as String,
        public_key: json[ContactsField.public_key] as String,
        preshared_key: json[ContactsField.preshared_key] as String,
      );

  Map<String, Object?> toJson() => {
        ContactsField.user_id: user_id,
        ContactsField.user_name: user_name,
        // ContactsField.email: email,
        ContactsField.phone_number: phone_number,
        ContactsField.public_key: public_key,
        ContactsField.preshared_key: preshared_key,
      };
}
