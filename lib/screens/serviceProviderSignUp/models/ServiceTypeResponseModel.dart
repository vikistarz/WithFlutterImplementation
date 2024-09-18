
class ServiceTypeResponseModel {
  final int id;
  final String serviceType;


  ServiceTypeResponseModel ({
    required this.id,
    required this.serviceType});

  factory ServiceTypeResponseModel.fromJson(Map<String, dynamic> json) {
    return ServiceTypeResponseModel(
        id : json['id'],
      serviceType : json['serviceType'],
     );
    }
  }
