class LoginResponse {
  late String token;
  late String userId;
  late String user;
  late String email;
  late String role;
  late String photo;

  LoginResponse(
      {required this.token,
      required this.userId,
      required this.user,
      required this.email,
      required this.role,
      required this.photo});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userId = json['userId'];
    user = json['user'];
    email = json['email'];
    role = json['role'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['token'] = token;
    data['userId'] = userId;
    data['user'] = user;
    data['email'] = email;
    data['role'] = role;
    data['photo'] = photo;
    return data;
  }
}
