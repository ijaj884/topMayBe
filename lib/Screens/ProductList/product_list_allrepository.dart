

import '../../../api_base/api_base_helper.dart';
import '../HomeScreen/GetAllActiveDeals/new_arrival_model.dart';

class ProductListRepository{
  final ApiBaseHelper _apiBaseHelper =  ApiBaseHelper();

  Future<NewArrivalModel> getDealsOfTheDay(String userId) async{
    Map body={};
    final response= await _apiBaseHelper.post("CusApi/ItemSku/GetAllActiveDealsOfTheDay/$userId", body);
    return NewArrivalModel.fromJson(response);
  }
  Future<NewArrivalModel> getBestSeller(String userId) async{
    Map body={};
    final response= await _apiBaseHelper.post("CusApi/ItemSku/GetBestSeller/$userId", body);
    return NewArrivalModel.fromJson(response);
  }
  Future<NewArrivalModel> getNewArrival(String userId) async{
    Map body={};
    final response= await _apiBaseHelper.post("CusApi/ItemSku/GetNewArrival/$userId", body);
    return NewArrivalModel.fromJson(response);
  }
  Future<NewArrivalModel> getTopOfer(String userId) async{
    Map body={};
    final response= await _apiBaseHelper.post("CusApi/ItemSku/GetTopOffer/0/$userId", body);
    return NewArrivalModel.fromJson(response);
  }
  Future<NewArrivalModel> getRecentlyViewed(String userId) async{
    Map body={};
    final response= await _apiBaseHelper.post("CusApi/ItemSku/GetRecentlyViewed/$userId", body);
    return NewArrivalModel.fromJson(response);
  }

}