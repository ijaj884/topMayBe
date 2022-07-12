import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:topmaybe/constant.dart';

class TextFormFieldWidget extends StatelessWidget {

  // final TextStyle textStyle;
  // final TextStyle labelTextStyle;
  final TextEditingController textController;
  final Widget prefixIcon;
  final String hintText;
  final Color prefixBoxColor;
  final List<TextInputFormatter>? textInputFormatter;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final bool obscureText;

  const TextFormFieldWidget(
      {Key? key,
      // required this.textStyle,
      // required this.labelTextStyle,
      required this.textController,
      required this.prefixIcon,
      required this.hintText,
      required this.prefixBoxColor,
      this.textInputFormatter,
      this.textInputType,
      this.textInputAction,
      this.obscureText= false,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        controller: textController,
        keyboardType: textInputType!,
        inputFormatters: textInputFormatter ?? [],
        obscureText: obscureText,
        obscuringCharacter: "*",
        enableInteractiveSelection: true,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 15.sp,
        ),
        textInputAction: textInputAction!,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(15),
            color: prefixBoxColor,
            child: prefixIcon,
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 55, minHeight: 48),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          helperStyle: TextStyle(
            color: Colors.black38,
            fontWeight: FontWeight.w400,
            fontSize: 13.5.sp,
          ),
          errorStyle: TextStyle(
            color: darkThemeBlue,
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
          ),
          hintStyle: TextStyle(
            color: Colors.black38,
            fontWeight: FontWeight.w400,
            fontSize: 13.5.sp,
          ),
          hintText: hintText,
          fillColor: const Color.fromRGBO(242, 242, 242, 1),
          filled: true,
          // enabledBorder/: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(5.0),
          //   borderSide: BorderSide(color: Colors.black38, width: 0.3),
          // ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
