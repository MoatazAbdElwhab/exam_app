class UserDto {
  UserDto({
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? role,
    bool? isVerified,
    String? id,
    String? createdAt,}){
    _username = username;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _phone = phone;
    _role = role;
    _isVerified = isVerified;
    _id = id;
    _createdAt = createdAt;
  }

  UserDto.fromJson(dynamic json) {
    _username = json['username'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _email = json['email'];
    _phone = json['phone'];
    _role = json['role'];
    _isVerified = json['isVerified'];
    _id = json['_id'];
    _createdAt = json['createdAt'];
  }
  String? _username;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phone;
  String? _role;
  bool? _isVerified;
  String? _id;
  String? _createdAt;

  UserDto copyWith({  String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? role,
    bool? isVerified,
    String? id,
    String? createdAt,
  }) => UserDto(  username: username ?? _username,
    firstName: firstName ?? _firstName,
    lastName: lastName ?? _lastName,
    email: email ?? _email,
    phone: phone ?? _phone,
    role: role ?? _role,
    isVerified: isVerified ?? _isVerified,
    id: id ?? _id,
    createdAt: createdAt ?? _createdAt,
  );

  String? get username => _username;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get phone => _phone;
  String? get role => _role;
  bool? get isVerified => _isVerified;
  String? get id => _id;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = _username;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['email'] = _email;
    map['phone'] = _phone;
    map['role'] = _role;
    map['isVerified'] = _isVerified;
    map['_id'] = _id;
    map['createdAt'] = _createdAt;
    return map;
  }

}