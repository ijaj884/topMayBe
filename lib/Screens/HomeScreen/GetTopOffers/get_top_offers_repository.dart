

import '../../../api_base/api_base_helper.dart';
import 'get_top_offers_model.dart';

class GetTopOfferRepository{
  final ApiBaseHelper _apiBaseHelper =  ApiBaseHelper();

  Future<GetTopOffersModel> getTopOfer(String userId) async{
     Map body={};
    final response= await _apiBaseHelper.post("CusApi/ItemSku/GetTopOffer/0/$userId", body);
    return GetTopOffersModel.fromJson(response);
  }

}