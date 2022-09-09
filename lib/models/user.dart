class UserModel {
  String? email;
  String? rol;
  String? id;

// receiving data
  UserModel({this.id, this.email, this.rol});
  factory UserModel.fromMap(map) {
    return UserModel(
      email: map['correo'],
      id: map['id'],
      rol: map['rol'],
    );
  }
// sending data
  Map<String, dynamic> toMap() {
    return {
      'correo': email,
      'id': id,
      'rol': rol,
    };
  }
}
