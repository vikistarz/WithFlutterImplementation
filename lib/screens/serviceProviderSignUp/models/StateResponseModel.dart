
class StatesResponseModel {
  final int id;
  final String name;
  final String capital;
  final String state_code;
  final String creation_date;
  final String latitude;
  final String longitude;
  final int total_area;
  final int population;
  final dynamic postalCode;
  final String religions;
  final String createdAt;
  final String updatedAt;


  StatesResponseModel ({
    required this.id,
    required this.name,
    required this.capital,
    required this.state_code,
    required this.creation_date,
    required this.latitude,
    required this.longitude,
    required this.total_area,
    required this.population,
    required this.postalCode,
    required this.religions,
    required this.createdAt,
    required this.updatedAt});

  factory StatesResponseModel.fromJson(Map<String, dynamic> json) {
    return StatesResponseModel(
        id: json['id'],
        name: json['name'],
        capital: json['capital'],
        state_code: json['state_code'],
        creation_date: json['creation_date'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        total_area: json['total_area'],
        population: json['population'],
        postalCode: json['postalCode'],
        religions: json['religions'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']
     );
    }
  }
