
class GetReviewResponseModel {
  final int id;
  final int customerId;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final String customerAddress;
  final int rating;
  final String comment;
  final String createdAt;


  GetReviewResponseModel ({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.customerAddress,
    required this.rating,
    required this.comment,
    required this.createdAt});

  factory GetReviewResponseModel.fromJson(Map<String, dynamic> json) {
    return GetReviewResponseModel(
        id: json['id'],
        customerId : json['customerId'],
        customerName : json['customerName'],
        customerEmail : json['customerEmail'],
        customerPhone : json['customerPhone'],
        customerAddress : json['customerAddress'],
        rating : json['rating'],
        comment : json['comment'],
        createdAt: json['createdAt']
     );
    }
  }
