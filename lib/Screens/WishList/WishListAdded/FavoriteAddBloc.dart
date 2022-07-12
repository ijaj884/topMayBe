import 'dart:async';


import '../../../api_base/api_response.dart';
import 'FavoriteAddModel.dart';
import 'FavoriteAddRepository.dart';



class FavoriteAddBloc {
  late FavoriteAddRepository _favoriteAddRepository;

  late StreamController <ApiResponse<FavoriteAddModel>> _favoriteAddController;

  StreamSink<ApiResponse<FavoriteAddModel>>? get favoriteAddSink =>
      _favoriteAddController.sink;

  Stream<ApiResponse<FavoriteAddModel>>? get favoriteAddStream =>
      _favoriteAddController.stream;

  FavoriteAddBloc() {
    _favoriteAddController = StreamController<ApiResponse<FavoriteAddModel>>.broadcast();
    _favoriteAddRepository = FavoriteAddRepository();

  }

  favoriteAdd(Map body) async {
    print("body");
    print(body);
    favoriteAddSink!.add(ApiResponse.loading('Submitting'));
    try {
      FavoriteAddModel loginModel = await _favoriteAddRepository.favoriteadd(body);
      favoriteAddSink!.add(ApiResponse.completed(loginModel));
    } catch (e) {
      favoriteAddSink!.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  // dispose() {
  //   _favoriteAddController.close();
  //   favoriteAddSink!.close();
  // }
}