import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProductFrameCircle extends StatelessWidget {
  final String productImage;
  final String productName;
  final TextStyle textStyle;
  final Color mainBackgroundColor;
  final EdgeInsets containerPadding;
  final double containerHeight;
  final double containerWidth;
  final double? imageHeight;
  final Color circleBorderColor;
  final double spacingBetweenImgText;
  final TextOverflow textOverflow;

  const ProductFrameCircle({
    Key? key,
    required this.productImage,
    required this.productName,
    required this.textStyle,
    required this.containerHeight,
    required this.containerWidth,
    required this.imageHeight,
    this.mainBackgroundColor =  Colors.transparent,
    this.circleBorderColor =  Colors.white,
    this.containerPadding = const EdgeInsets.all(0),
    this.spacingBetweenImgText = 2,
    this.textOverflow = TextOverflow.ellipsis})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerHeight,
      width: containerWidth,
      padding: containerPadding,
      color: mainBackgroundColor,
      child: Column(
        children: [
          Container(
            // margin: EdgeInsets.only(top: 20,bottom: 20),
            padding: EdgeInsets.all(2),
            height: imageHeight,
            width: imageHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Container(
              height: imageHeight,
              width: imageHeight,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle),
              child:
              Image.asset(
                productImage,
                fit: BoxFit.fill,
              ),
              // FadeInImage(
              //   image: NetworkImage(
              //     productImage,),
              //   // width: screenWidth*0.29,//120.0,
              //   // height: screenHeight*0.123,
              //   placeholder: AssetImage("assets/tempImages/Products/product2.png"),
              //   fit: BoxFit.fill,
              // ),

              // child: Image.asset("asset/blank-profile-picture-973460_1280.webp")
            ),
          ),
          SizedBox(
            height: spacingBetweenImgText,
          ),
          Text(
            productName,
            style: textStyle,
            overflow: textOverflow,
            textAlign: TextAlign.center,
          )

        ],
      ),
    );
  }
}
