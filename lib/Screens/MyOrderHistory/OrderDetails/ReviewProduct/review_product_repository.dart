

import 'package:topmaybe/Screens/MyOrderHistory/OrderDetails/ReviewProduct/review_product_model.dart';

import '../../../../api_base/api_base_helper.dart';

class ReviewProductRepository{
  final ApiBaseHelper _apiBaseHelper =  ApiBaseHelper();

  Future<ReviewProductModel> setReviewProduct(body) async{
    // Map body={};
    final response= await _apiBaseHelper.post("CusApi/CustomerReviews/Set", body);
    return ReviewProductModel.fromJson(response);
  }
}