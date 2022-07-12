

import 'package:topmaybe/Screens/Product/product_model.dart';

import '../../../api_base/api_base_helper.dart';



class GetAllActiveChildBySubRepository{
  final ApiBaseHelper _apiBaseHelper =  ApiBaseHelper();

  Future<ProductModel> getChildCategory(body,String catId) async{
    // Map body={};
    final response= await _apiBaseHelper.post("api/Category/GetAllActiveChildBySub/$catId", body);
    return ProductModel.fromJson(response);
  }
}