
class FilterServiceResponseModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String stateOfResidence;
  final String city;
  final String address;
  final String serviceType;
  final String subCategory;
  final String openingHour;
  final String imagePath;
  final String isVerified;
  final String? about;
  final String? skills;



  FilterServiceResponseModel ({
    required this.id, required this.firstName, required this.lastName, required this.email, required this.phone,
    required this.stateOfResidence, required this.city, required this.address, required this.serviceType, required this.subCategory,
    required this.openingHour, required this.imagePath, required this.isVerified, required this.about, required this. skills});

  factory FilterServiceResponseModel.fromJson(Map<String, dynamic> json) {
    return FilterServiceResponseModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      stateOfResidence: json['stateOfResidence'],
      city: json['city'],
      address: json['address'],
      serviceType: json['serviceType'],
      subCategory: json['subCategory'],
      openingHour: json['openingHour'],
      imagePath: json['imagePath'],
      isVerified: json['isVerified'],
      about: json['about'],
      skills: json['skills'],


     );
    }
  }

