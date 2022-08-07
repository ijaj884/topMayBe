import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:topmaybe/Screens/MyOrderHistory/OrderDetails/ReviewProduct/review_product_model.dart';
import 'package:topmaybe/Screens/MyOrderHistory/OrderDetails/ReviewProduct/review_product_repository.dart';
import '../../../../api_base/api_response.dart';


class ReviewProductBloc {
  late ReviewProductRepository  _setCartRepository;

  late StreamController<ApiResponse<ReviewProductModel>> _getOtpController;

  StreamSink<ApiResponse<ReviewProductModel>>? get setCartSink =>
      _getOtpController.sink;

  Stream<ApiResponse<ReviewProductModel>>? get setReviewStream =>
      _getOtpController.stream;


  ReviewProductBloc() {
    _getOtpController = StreamController<ApiResponse<ReviewProductModel>>.broadcast();
    _setCartRepository = ReviewProductRepository();
    // getOtp();
  }
  setReview(Map body) async {
    setCartSink?.add(ApiResponse.loading("Fetching",));

    try {
      ReviewProductModel response = await _setCartRepository.setReviewProduct(body);
      setCartSink?.add(ApiResponse.completed(response));
    } catch (e) {
      setCartSink?.add(ApiResponse.error(e.toString()));
      if (kDebugMode) {
        print(e);
      }
    }
  }

}