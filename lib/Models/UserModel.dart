class UserModel {
  String? id;
  String? firstname;
  String? lastname;
  String? email;
  String? password;
  String? role;
  UserModel({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      firstname: json['first_name'],
      lastname: json['last_name'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'first_name': firstname,
      'last_name:': lastname,
      'email': email,
      'password': password,
    };
  }
}
