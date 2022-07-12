import '../../../api_base/api_base_helper.dart';
import 'get_list_for_customer_support_ticket_model.dart';



class GetListForCustomerSupportTicketRepository{
  final ApiBaseHelper _apiBaseHelper =  ApiBaseHelper();

  Future<GetListForCustomerSupportTicketModel> getListForCustomerSupport(String userId) async{
     Map body={};
    final response= await _apiBaseHelper.post("CusApi/SupportTicket/GetListForCustomer/$userId", body);
    return GetListForCustomerSupportTicketModel.fromJson(response);
  }
}