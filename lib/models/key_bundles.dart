// ignore_for_file: constant_identifier_names, non_constant_identifier_names

const String tableKB = 'KB';

class KBField {
  static final List<String> values = [
    /// Add all fields
    id, pk 
  ];

  static const String id = '_id';
  static const String pk = 'pk';
 
}

class KB {
  final int? id;
  final String pk;


  const KB({
    this.id,
    required this.pk,
   
  });

    // ignore: unnecessary_new
    factory KB.fromMap(Map<String, dynamic> json) => new KB(
        pk: json['pk'],
    
       
      );

  KB copy({
    int? id,
   String? pk,

  }) =>
      KB(
        id: id ?? this.id,
        pk: pk ?? this.pk,
      
      );

  static KB fromJson(Map<String, Object?> json) => KB(
        id: json[KBField.id] as int?,
        pk: json[KBField.pk] as String,
   
      );

  Map<String, Object?> toJson() => {
        KBField.id: id,
        KBField.pk: pk,
     
      };
}


// ignore_for_file: constant_identifier_names, non_constant_identifier_names

const String tableMyKBs = 'MyKBs';

class MyKBsField {
  static final List<String> values = [
    /// Add all fields
    id, sk, pk
  ];

  static const String id = '_id';
  static const String sk = 'sk';
  static const String pk = 'pk';

}

class MyKBs {
  final int? id;
  final String sk;
  // final String email;
  final String pk;


  const MyKBs({
    this.id,
    required this.sk,
    // required this.email,
    required this.pk,

  });

    // ignore: unnecessary_new
    factory MyKBs.fromMap(Map<String, dynamic> json) => new MyKBs(
        sk: json['sk'],
        pk: json['pk'],
  
      );

  MyKBs copy({
    int? id,
   String? message,
  //  String email,
   String? message_from,
   DateTime? timestamp,
   int? dir,
  }) =>
      MyKBs(
        id: id ?? this.id,
        sk: sk ?? this.sk,
        // email: email ?? this.email,
        pk: pk ?? this.pk,
     
      );

  static MyKBs fromJson(Map<String, Object?> json) => MyKBs(
        id: json[MyKBsField.id] as int?,
        sk: json[MyKBsField.sk] as String,
        // email: json[MyKBsField.email] as String,
        pk: json[MyKBsField.pk] as String,
 
      );

  Map<String, Object?> toJson() => {
        MyKBsField.id: id,
        MyKBsField.sk: sk,
        // MyKBsField.email: email,
        MyKBsField.pk: pk,
      
      };
}
