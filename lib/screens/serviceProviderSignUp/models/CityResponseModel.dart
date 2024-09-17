
class CityResponseModel {
  final String name;

  CityResponseModel ({
    required this.name,
    });

  factory CityResponseModel.fromJson(Map<String, dynamic> json) {
    return CityResponseModel(
      name: json['name'],
     );
    }
  }
