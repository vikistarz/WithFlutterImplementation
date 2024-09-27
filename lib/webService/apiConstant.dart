
class ApiConstant {


  static const String baseUri = "https://server.handiwork.com.ng/api/";

  static const String customerLogInApi = baseUri + 'auth/login/customer';

  static const String serviceProviderLogInApi = baseUri + 'auth/login/skill-provider';

  static const String serviceProviderSignUpApi = baseUri + 'skill-providers/create';

  static const String customerSignUpApi = baseUri + 'customers/create';

  static const String getStateApi = baseUri + 'nigerian-states/states';

  static const String getServicesApi = baseUri + 'skills-subcategory/viewAllSkillTypes';

}