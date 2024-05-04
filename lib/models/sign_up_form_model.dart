class SignUpFormModel{
  
  final String? name;
  final String? email;
  final String? username;
  final String? password;
  final String? pin;
  final String? profilePicture;
  final String? phoneNumber;

  // Constructor
  SignUpFormModel({
    this.name, 
    this.email,
    this.username,
    this.password,
    this.pin,
    this.profilePicture,
    this.phoneNumber
  });

  Map<String, dynamic> toJson(){
    return{
      'name': name,
      'email': email,
      'username': username,
      'password': password,
      'pin': pin,
      'profile_picture': profilePicture,
      'phone_number': phoneNumber
    };
  }

  SignUpFormModel copyWith({
    String? pin,
    String? profilePicture,
    String? phoneNumber
  }) => SignUpFormModel(
    name: name,
    email: email,
    password: password,
    username: username,
    pin: pin ?? this.pin,
    profilePicture: profilePicture ?? this.profilePicture,
    phoneNumber: phoneNumber ?? this.phoneNumber
  );
}