class Patient {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String age;
  final String gender;
  final String city;
  final String province;
  final String address;
  final String image;

  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    this.email = '',
    this.phone = '',
    this.city = '',
    this.province = '',
    this.address = '',
    this.image = 'assets/images/person_example.png',
  });
}
