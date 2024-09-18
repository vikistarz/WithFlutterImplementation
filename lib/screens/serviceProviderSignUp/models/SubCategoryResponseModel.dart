
class SubCategoryResponseModel {
  final int id;
  final List<String> subCategories;


  SubCategoryResponseModel ({
    required this.id,
    required this.subCategories});

  factory SubCategoryResponseModel.fromJson(Map<String, dynamic> json) {
    var itemsFromJson = json['subCategories'] as List;
    List<String> subCategoryList = itemsFromJson.map((subCategory) => subCategory.toString()).toList();

    return SubCategoryResponseModel(
        id : json['id'],
       subCategories: subCategoryList,
     );
    }
  }
