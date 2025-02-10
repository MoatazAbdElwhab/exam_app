class EditProfileUserDto {
  EditProfileUserDto({
      String? id, 
      String? username, 
      String? firstName, 
      String? lastName, 
      String? email, 
      String? phone, 
      String? role, 
      String? password, 
      bool? isVerified, 
      String? createdAt, 
      String? passwordChangedAt,}){
    _id = id;
    _username = username;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _phone = phone;
    _role = role;
    _password = password;
    _isVerified = isVerified;
    _createdAt = createdAt;
    _passwordChangedAt = passwordChangedAt;
}

  EditProfileUserDto.fromJson(dynamic json) {
    _id = json['_id'];
    _username = json['username'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _email = json['email'];
    _phone = json['phone'];
    _role = json['role'];
    _password = json['password'];
    _isVerified = json['isVerified'];
    _createdAt = json['createdAt'];
    _passwordChangedAt = json['passwordChangedAt'];
  }
  String? _id;
  String? _username;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phone;
  String? _role;
  String? _password;
  bool? _isVerified;
  String? _createdAt;
  String? _passwordChangedAt;
EditProfileUserDto copyWith({  String? id,
  String? username,
  String? firstName,
  String? lastName,
  String? email,
  String? phone,
  String? role,
  String? password,
  bool? isVerified,
  String? createdAt,
  String? passwordChangedAt,
}) => EditProfileUserDto(  id: id ?? _id,
  username: username ?? _username,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  phone: phone ?? _phone,
  role: role ?? _role,
  password: password ?? _password,
  isVerified: isVerified ?? _isVerified,
  createdAt: createdAt ?? _createdAt,
  passwordChangedAt: passwordChangedAt ?? _passwordChangedAt,
);
  String? get id => _id;
  String? get username => _username;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get phone => _phone;
  String? get role => _role;
  String? get password => _password;
  bool? get isVerified => _isVerified;
  String? get createdAt => _createdAt;
  String? get passwordChangedAt => _passwordChangedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['username'] = _username;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['email'] = _email;
    map['phone'] = _phone;
    map['role'] = _role;
    map['password'] = _password;
    map['isVerified'] = _isVerified;
    map['createdAt'] = _createdAt;
    map['passwordChangedAt'] = _passwordChangedAt;
    return map;
  }
}