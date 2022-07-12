import '../../../api_base/api_base_helper.dart';
import 'get_item_review_model.dart';

class GetItemReviewRepository{
  final ApiBaseHelper _apiBaseHelper =  ApiBaseHelper();

  Future<GetItemReviewModel> getReview(String itemId) async{
    Map body={};
    final response= await _apiBaseHelper.post("CusApi/CustomerReviews/GetItemReview/$itemId", body);
    return GetItemReviewModel.fromJson(response);
  }
}