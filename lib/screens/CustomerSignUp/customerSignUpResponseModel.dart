class CustomerSignUpResponseModel {
  final bool success;
  final CustomerData  customer;
  final CustomerWallet wallet;


  CustomerSignUpResponseModel({
    required this.success,
    required this.customer,
    required this.wallet});

  factory CustomerSignUpResponseModel.fromJson(Map<String, dynamic> json) {
    return CustomerSignUpResponseModel(success: json['success'],
        customer: CustomerData.fromJson(json['customer']),
        wallet: CustomerWallet.fromJson(json['wallet']),
    );
  }
}



class CustomerData {
  final int id;
  final String token;

  CustomerData({
  required this.id,
    required this.token
});

  factory CustomerData.fromJson(Map<String, dynamic> json) {
    return CustomerData(
      id: json['id'],
      token: json['token']
    );
  }
}



class CustomerWallet{
  final int id;

  CustomerWallet({
    required this.id
});

  factory CustomerWallet.fromJson(Map<String, dynamic> json) {
    return CustomerWallet(
        id: json['id'],
    );
  }

}