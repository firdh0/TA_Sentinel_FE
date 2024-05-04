// {
//     "id": 8,
//     "name": "test6",
//     "email": "test6@gmail.com",
//     "username": "test6",
//     "pin": "123456",
//     "phone_number": "1234567890",
//     "verified": 1,
//     "profile_picture": "http://localhost:8000/storage3kvUn9QYh5.png",
//     "created_at": "2024-05-03T14:16:28.000000Z",
//     "updated_at": "2024-05-03T14:16:28.000000Z",
//     "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwMDAvYXBpL3JlZ2lzdGVyIiwiaWF0IjoxNzE0NzQ1Nzg4LCJleHAiOjE3MTQ3NDkzODgsIm5iZiI6MTcxNDc0NTc4OCwianRpIjoiaU5iZENBN2JhWFhjOG43UyIsInN1YiI6IjgiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.T49I8cI3afp3STLS6JLuPegrm6YhX0adclYXq6pdI74",
//     "token_expires_in": 3600,
//     "token_type": "bearer"
// }

class UserModel{

  final int? id;
  final String? name;
  final String? email;
  final String? password;
  final String? username;
  final String? phoneNumber;
  final int? verified;
  final String? profilePicture;
  final String? pin;
  final String? token;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.username,
    this.phoneNumber,
    this.verified,
    this.profilePicture,
    this.pin,
    this.token
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    username: json['username'],
    phoneNumber: json['phone_number'],
    verified: json['verified'],
    profilePicture: json['profile_picture'],
    pin: json['pin'],
    token: json['token'],
  );

  // Yang bisa diedit
  UserModel copyWith({
    String? name,
    String? email,
    String? username,
    String? pin,
    String? password,
    String? phoneNumber,
  }) => UserModel(
    id: id,
    username: username ?? this.username,
    name: name ?? this.name,
    email: email ?? this.email,
    pin: pin ?? this.pin,
    password: password ?? this.password,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    verified: verified,
    profilePicture: profilePicture,
    token: token
  );

}