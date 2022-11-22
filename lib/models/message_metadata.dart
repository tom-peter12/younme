// ignore_for_file: constant_identifier_names, non_constant_identifier_names

const String tableMessages = 'Messages';

class MessagesField {
  static final List<String> values = [
    /// Add all fields
    id, message, message_from, timestamp, dir
  ];

  static const String id = '_id';
  static const String message = 'message';
  static const String message_from = 'username';
  static const String timestamp = 'timestamp';
  static const String dir = 'dir';
}

class Messages {
  final int? id;
  final String message;
  // final String email;
  final String message_from;
  final DateTime timestamp;
  final int dir;

  const Messages({
    this.id,
    required this.message,
    // required this.email,
    required this.message_from,
    required this.timestamp,
    required this.dir,
  });

    // ignore: unnecessary_new
    factory Messages.fromMap(Map<String, dynamic> json) => new Messages(
        message: json['message'],
        message_from: json['message_from'],
       timestamp: DateTime.now(), 
       dir: 0,
       
      );

  Messages copy({
    int? id,
   String? message,
  //  String email,
   String? message_from,
   DateTime? timestamp,
   int? dir,
  }) =>
      Messages(
        id: id ?? this.id,
        message: message ?? this.message,
        // email: email ?? this.email,
        message_from: message_from ?? this.message_from,
        timestamp: timestamp ?? this.timestamp,
        dir: dir ?? this.dir,
      );

  static Messages fromJson(Map<String, Object?> json) => Messages(
        id: json[MessagesField.id] as int?,
        message: json[MessagesField.message] as String,
        // email: json[MessagesField.email] as String,
        message_from: json[MessagesField.message_from] as String,
        timestamp: DateTime.now(),
        dir: 0,
      );

  Map<String, Object?> toJson() => {
        MessagesField.id: id,
        MessagesField.message: message,
        // MessagesField.email: email,
        MessagesField.message_from: message_from,
        MessagesField.timestamp: timestamp,
        MessagesField.dir: dir,
      };
}
