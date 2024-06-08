

class UserIf {
  final int userId;
  final String name;
  final String email;
  final String phone;
  final String address;
  final bool gender;
  final String image;
  final String registerDate;
  final bool status;

  UserIf({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.gender,
    required this.image,
    required this.registerDate,
    required this.status,
  });

  factory UserIf.fromJson(Map<String, dynamic> json) {
    return UserIf(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      gender: json['gender'],
      image: json['image'],
      registerDate: json['registerDate'],
      status: json['status'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'gender': gender,
      'image': image,
      'registerDate': registerDate,
      'status': status,
    };
  }


}