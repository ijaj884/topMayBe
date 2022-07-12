import 'package:topmaybe/Screens/ProductDetails/product_details_model.dart';

import '../../../api_base/api_base_helper.dart';


class ProductDetailsRepository{
  final ApiBaseHelper _apiBaseHelper =  ApiBaseHelper();

  Future<ProductDetailsModel> getProductDetails(String itemId) async{
     Map body={};
    final response= await _apiBaseHelper.post("CusApi/ItemSku/GetItemSkuByItmId/$itemId", body);
    return ProductDetailsModel.fromJson(response);
  }
}