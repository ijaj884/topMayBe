

import '../../../api_base/api_base_helper.dart';
import 'GetAllActiveDealsOfTheDay/get_all_active_deals_of_the_day_model.dart';
import 'get_best_seller.dart';
import 'new_arrival_model.dart';

class GetAllActiveDealsRepository{
  final ApiBaseHelper _apiBaseHelper =  ApiBaseHelper();

  Future<GetAllActiveDealsOfTheDayModel> getDealsOfTheDay(String userId) async{
     Map body={};
    final response= await _apiBaseHelper.post("CusApi/ItemSku/GetAllActiveDealsOfTheDay/$userId", body);
    return GetAllActiveDealsOfTheDayModel.fromJson(response);
  }
  Future<GetBestSellerModel> getBestSeller(String userId) async{
     Map body={};
    final response= await _apiBaseHelper.post("CusApi/ItemSku/GetBestSeller/$userId", body);
    return GetBestSellerModel.fromJson(response);
  }
  Future<NewArrivalModel> getNewArrival(String userId) async{
     Map body={};
    final response= await _apiBaseHelper.post("CusApi/ItemSku/GetNewArrival/$userId", body);
    return NewArrivalModel.fromJson(response);
  }

}