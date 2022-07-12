import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:topmaybe/constant.dart';
import 'package:get/get.dart';
import 'package:csc_picker/csc_picker.dart';
import '../../api_base/api_response.dart';
import 'AddNewAddress/set_address_bloc.dart';
import 'AddNewAddress/set_address_model.dart';
import 'DeleteAddress/delete_address_bloc.dart';
import 'DeleteAddress/delete_address_model.dart';
import 'get_address_model.dart';
import 'get_address_repository.dart';

class ManageAddressList extends StatefulWidget {
  const ManageAddressList({Key? key}) : super(key: key);

  @override
  _ManageAddressListState createState() => _ManageAddressListState();
}

class _ManageAddressListState extends State<ManageAddressList> {
  List addressValue = [
    "1",
    "2",
    "3",
  ];
  bool addNewAddress = false;
  String userToken = "";
  late Map body;
  String userId = "";
  bool streamCheck = false;
  bool deleteCheck = false;
  int? selectedIndexForHome;
  String home = 'Home';
  List<String> homeOffice = ["Home", "Office", "Others"];

  final FocusNode _focusNodeEmail = FocusNode();

  final TextEditingController emailval = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nearbyController = TextEditingController();
  final SetAddressBloc _setAddressBloc = SetAddressBloc();
  final DeleteAddressBloc _deleteAddressBloc = DeleteAddressBloc();

  String? countryValue;

  String? stateValue;
  String? cityValue;
  String? address;
  late SharedPreferences prefs;
  Future<GetAddressModel>? _getAddress;
  late GetAddressRepository _getAddressRepository;
  String userPhone="";
  double shopDistance = 10;

  Future<void> createSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("user_id")!;
    userPhone= prefs.getString("user_phone")!;
    // print("address page");
    // print(prefs.getString("user_token"));
    // userId = prefs.getString("user_id")!;
    // userToken = prefs.getString("user_token")!;
    body = {};
    _getAddressRepository = GetAddressRepository();
    _getAddress = _getAddressRepository.getAddress(body, userId);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    createSharedPref();
  }

  bool validateEmail = false;
  bool idfetched = false;

  String? emailValidator(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (value!.isEmpty || value.trim().isEmpty) {
      return null;
    }
    if (!regex.hasMatch(value)) {
      return "Please enter valid email";
    } else {
      return null;
    }
  }

  List val = [10, 20, 30, 40, 50];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<GetAddressModel>(
        future: _getAddress,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.Data != null) {
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  centerTitle: false,
                  toolbarHeight: 6.h,
                  titleSpacing: 0,
                  backgroundColor: darkThemeOrange,
                  //Color.fromRGBO(202, 85, 44, 1),
                  //Colors.white,
                  //bottomOpacity: 0.0,
                  elevation: 0.0,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 18.sp,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  title: Text(
                    "Saved Addresses".toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                resizeToAvoidBottomInset: false,
                body: ListView(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: snapshot.data!.Data!.length,
                      itemBuilder: (context, index) => SizedBox(
                        height: 210,
                        child: Card(
                          elevation: 3,
                          shape: const RoundedRectangleBorder(),
                          margin: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Address ${index + 1}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.grey[400],
                                      size: 0,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 15),
                                child: Text(
                                  snapshot.data!.Data![index]!.caddAddressName!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: darkThemeOrange,
                                      fontSize: 14),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 8),
                                  child: Text(
                                      "${snapshot.data!.Data![index]!.caddHouseNo}, ${snapshot.data!.Data![index]!.caddAddress_1},${snapshot.data!.Data![index]!.caddAddress_2},"
                                          "${snapshot.data!.Data![index]!.stName}, ${snapshot.data!.Data![index]!.caddPincode}",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey[600]),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 5),
                                child: Row(
                                  children: [
                                     Icon(
                                        Icons.phone_android,
                                        color: darkThemeBlue,
                                        size: 13.sp,
                                      ),

                                    // Image.asset('assets/icons/mobile.png',
                                    //     color: Colors.red, height: 15),
                                    Text(
                                      '   $userPhone',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 25),
                                child: Divider(
                                  thickness: 1,
                                  height: 0,
                                ),
                              ),
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 50),
                                      child: InkWell(
                                        onTap: () {
                                          // Get.to(() => AddressEditPage(
                                          //       addressId: snapshot
                                          //           .data!.data![index]!.id!,
                                          //       city: snapshot
                                          //           .data!.data![index]!.city!,
                                          //       fullAddress: snapshot.data!
                                          //           .data![index]!.address!,
                                          //       landMark: snapshot.data!
                                          //           .data![index]!.landmark!,
                                          //       name: snapshot.data!
                                          //           .data![index]!.addressName!,
                                          //       pin: snapshot
                                          //           .data!.data![index]!.zip!,
                                          //       state: snapshot
                                          //           .data!.data![index]!.state!,
                                          //     ));
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                                Icons.edit,
                                                color: darkThemeBlue,
                                                size: 13.sp,
                                              ),

                                            const Text(
                                              '  Edit',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 35,
                                      child: VerticalDivider(
                                        thickness: 1,
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(right: 50),
                                        child:
                                        // Row(
                                        //   children: [
                                        //     Icon(
                                        //       Icons.delete_forever,
                                        //       color: darkThemeBlue,
                                        //       size: 13.sp,
                                        //     ),
                                        //     const Text(
                                        //       '  Delete',
                                        //       style: TextStyle(
                                        //           fontSize: 12,
                                        //           fontWeight: FontWeight.w500),
                                        //     ),
                                        //   ],
                                        // ),
                                        StreamBuilder<ApiResponse<DeleteAddressModel>>(
                                            stream: _deleteAddressBloc.deleteAddressStream,
                                            builder: (context, snapshot1) {
                                              //idd=snapshot.data.data[index].id.toString();
                                              if (snapshot1.hasData) {
                                                switch (
                                                    snapshot1.data!.status) {
                                                  case Status.LOADING:
                                                    print("Loading");
                                                    break;
                                                  case Status.COMPLETED:
                                                    print("Fav Deleted");
                                                    Future.delayed(
                                                        Duration.zero, () {
                                                      //Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteKitchens()));
                                                      if (deleteCheck) {
                                                        body ={};
                                                        setState(() {
                                                          _getAddress = _getAddressRepository.getAddress(body, userId);
                                                          deleteCheck = false;
                                                        });
                                                      }
                                                    });
                                                    break;
                                                  case Status.ERROR:
                                                    print("Fav not deleted");
                                                    break;
                                                }
                                              }
                                              return InkWell(
                                                onTap: () {
                                                  _deleteAddressBloc.deleteAddress(snapshot.data!.Data![index]!.caddId.toString());
                                                  deleteCheck = true;
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.delete_forever,
                                                      color: darkThemeBlue,
                                                      size: 18.sp,
                                                    ),
                                                    const Text(
                                                      '  Delete',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            })

                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          addNewAddress = !addNewAddress;
                        });
                      },
                      child: Container(
                        height: 6.h,
                        //width:  55.w,
                        margin: const EdgeInsets.all(15),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: darkThemeBlue,
                            borderRadius: BorderRadius.circular(5)
                            //border: Border.all(color: Colors.grey[300]!)
                            ),
                        child: Row(
                          children: [
                            Text(
                              "ADD A NEW ADDRESS",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            const Spacer(),
                            addNewAddress
                                ? Icon(
                                    Icons.keyboard_arrow_up,
                                    size: 18.sp,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 18.sp,
                                    color: Colors.white,
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: addNewAddress,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                right: 6.0.w, left: 6.0.w, top: 5.0.w),
                            child: Text(
                              "Name",
                              style: TextStyle(
                                  fontSize: 12.5.sp, color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 6.0.w, left: 6.0.w, top: 5.0.w),
                            child: TextFormField(
                              // textInputAction: TextInputAction.next,
                              cursorColor: darkThemeBlue,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      const Color.fromRGBO(255, 255, 255, 1),
                                  labelText: 'Name',
                                  alignLabelWithHint: true,
                                  hintText: "Name",
                                  labelStyle: const TextStyle(
                                    color: Color.fromRGBO(82, 82, 82, 1),
                                    fontSize: 16,
                                  ),
                                  hintStyle: const TextStyle(
                                      color: Color.fromRGBO(82, 82, 82, 1)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(221, 221, 221, 1)),
                                      borderRadius: BorderRadius.circular(5)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(221, 221, 221, 1)),
                                      borderRadius: BorderRadius.circular(5)),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  )),
                              controller: _nameController,
                              keyboardType: TextInputType.name,
                              //enabled: !idfetched,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 6.0.w, left: 6.0.w, top: 5.0.w),
                            child: Text(
                              "Phone",
                              style: TextStyle(
                                  fontSize: 12.5.sp, color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 6.0.w, left: 6.0.w, top: 5.0.w),
                            child: TextFormField(
                              // textInputAction: TextInputAction.next,
                              cursorColor: darkThemeBlue,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      const Color.fromRGBO(255, 255, 255, 1),
                                  labelText: 'Phone',
                                  alignLabelWithHint: true,
                                  hintText: "987654321",
                                  labelStyle: const TextStyle(
                                    color: Color.fromRGBO(82, 82, 82, 1),
                                    fontSize: 16,
                                  ),
                                  hintStyle: const TextStyle(
                                      color: Color.fromRGBO(82, 82, 82, 1)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(221, 221, 221, 1)),
                                      borderRadius: BorderRadius.circular(5)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(221, 221, 221, 1)),
                                      borderRadius: BorderRadius.circular(5)),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  )),
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              //enabled: !idfetched,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 6.0.w, left: 6.0.w, top: 5.0.w),
                            child: Row(
                              children: [
                                Text(
                                  "Email",
                                  style: TextStyle(
                                      fontSize: 12.5.sp, color: Colors.black),
                                ),
                                Text(
                                  " (Optional)",
                                  style: TextStyle(
                                      fontSize: 13.5.sp, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 6.0.w, left: 6.0.w, top: 5.0.w),
                            child: TextFormField(
                              // textInputAction: TextInputAction.next,
                              focusNode: _focusNodeEmail,
                              cursorColor: darkThemeBlue,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      const Color.fromRGBO(255, 255, 255, 1),
                                  labelText: 'Email ID',
                                  alignLabelWithHint: true,
                                  hintText: "name@domain.com",
                                  errorText: validateEmail
                                      ? emailValidator(emailval.text)
                                      : null,
                                  labelStyle: const TextStyle(
                                    color: Color.fromRGBO(82, 82, 82, 1),
                                    fontSize: 16,
                                  ),
                                  hintStyle: const TextStyle(
                                      color: Color.fromRGBO(82, 82, 82, 1)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(221, 221, 221, 1)),
                                      borderRadius: BorderRadius.circular(5)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(221, 221, 221, 1)),
                                      borderRadius: BorderRadius.circular(15)),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  )),
                              controller: emailval,
                              keyboardType: TextInputType.emailAddress,
                              enabled: !idfetched,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 6.0.w, left: 6.0.w, top: 5.0.w),
                            child: CSCPicker(
                              ///Enable disable state dropdown [OPTIONAL PARAMETER]
                              showStates: true,

                              /// Enable disable city drop down [OPTIONAL PARAMETER]
                              showCities: true,

                              ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                              flagState: CountryFlag.ENABLE,
                              defaultCountry: DefaultCountry.India,
                              onCountryChanged: (value) {
                                setState(() {
                                  countryValue = value;
                                });
                              },
                              onStateChanged: (value) {
                                setState(() {
                                  stateValue = value;
                                  // print(value?.length);
                                });
                              },
                              onCityChanged: (value) {
                                setState(() {
                                  cityValue = value;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 6.0.w, left: 6.0.w, top: 5.0.w),
                            child: Text(
                              "Zip",
                              style: TextStyle(
                                  fontSize: 12.5.sp, color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 6.0.w, left: 6.0.w, top: 5.0.w),
                            child: TextFormField(
                              // textInputAction: TextInputAction.next,
                              cursorColor: darkThemeBlue,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      const Color.fromRGBO(255, 255, 255, 1),
                                  labelText: 'Pincode',
                                  alignLabelWithHint: true,
                                  // hintText: "987654321",
                                  labelStyle: const TextStyle(
                                    color: Color.fromRGBO(82, 82, 82, 1),
                                    fontSize: 16,
                                  ),
                                  hintStyle: const TextStyle(
                                      color: Color.fromRGBO(82, 82, 82, 1)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(221, 221, 221, 1)),
                                      borderRadius: BorderRadius.circular(5)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(221, 221, 221, 1)),
                                      borderRadius: BorderRadius.circular(5)),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  )),
                              controller: _zipController,
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 6.0.w, left: 6.0.w, top: 5.0.w),
                            child: Text(
                              "Address",
                              style: TextStyle(
                                  fontSize: 12.5.sp, color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 6.0.w, left: 6.0.w, top: 5.0.w),
                            child: TextFormField(
                              // textInputAction: TextInputAction.next,
                              cursorColor: darkThemeBlue,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      const Color.fromRGBO(255, 255, 255, 1),
                                  //labelText: 'Name',
                                  alignLabelWithHint: true,
                                  hintText: "1234 Main St",
                                  labelStyle: const TextStyle(
                                    color: Color.fromRGBO(82, 82, 82, 1),
                                    fontSize: 16,
                                  ),
                                  hintStyle: const TextStyle(
                                      color: Color.fromRGBO(82, 82, 82, 1)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(221, 221, 221, 1)),
                                      borderRadius: BorderRadius.circular(5)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(221, 221, 221, 1)),
                                      borderRadius: BorderRadius.circular(5)),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  )),
                              controller: _addressController,
                              keyboardType: TextInputType.streetAddress,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 6.0.w, left: 6.0.w, top: 5.0.w),
                            child: Text(
                              "Land Mark",
                              style: TextStyle(
                                  fontSize: 12.5.sp, color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 6.0.w, left: 6.0.w, top: 5.0.w),
                            child: TextFormField(
                              // textInputAction: TextInputAction.next,
                              cursorColor: darkThemeBlue,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      const Color.fromRGBO(255, 255, 255, 1),
                                  // labelText: 'Name',
                                  alignLabelWithHint: true,
                                  hintText: "Near By",
                                  labelStyle: const TextStyle(
                                    color: Color.fromRGBO(82, 82, 82, 1),
                                    fontSize: 16,
                                  ),
                                  hintStyle: const TextStyle(
                                      color: Color.fromRGBO(82, 82, 82, 1)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(221, 221, 221, 1)),
                                      borderRadius: BorderRadius.circular(5)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(221, 221, 221, 1)),
                                      borderRadius: BorderRadius.circular(5)),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  )),
                              controller: _nearbyController,
                              keyboardType: TextInputType.name,
                              //enabled: !idfetched,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 6.0.w, left: 6.0.w, top: 5.0.w),
                            child: Text(
                              "Address Type",
                              style: TextStyle(
                                  fontSize: 12.5.sp, color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 6.0.w, left: 6.0.w, top: 5.0.w),
                            child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 12.0,
                                  mainAxisSpacing: 12.0,
                                  childAspectRatio: 50 / 18,
                                ),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                // physics: const ScrollPhysics(),
                                itemCount: 3,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedIndexForHome = index;
                                      });

                                      if (index == 0) {
                                        home = "Home";
                                      } else if (index == 1) {
                                        home = "Office";
                                      } else {
                                        home = "Others";
                                      }
                                      if (kDebugMode) {
                                        print(home);
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: selectedIndexForHome == index
                                              ? darkThemeOrange
                                              : const Color.fromRGBO(
                                                  246, 246, 245, 1),
                                          border: Border.all(
                                            color: selectedIndexForHome == index
                                                ? darkThemeOrange
                                                : const Color.fromRGBO(
                                                    221, 221, 221, 1),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: FittedBox(
                                            child: Text(homeOffice[index],
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: selectedIndexForHome ==
                                                          index
                                                      ? Colors.white
                                                      : const Color.fromRGBO(
                                                          82, 82, 82, 1),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          InkWell(
                            onTap: () {
                              streamCheck = true;
                              Map body = {
                                "cadd_cus_id": userId,
                                "cadd_address_name": home,
                                "cadd_house_no": _addressController.text,
                                "cadd_address_1": _nearbyController.text,
                                "cadd_address_2": "",
                                "cadd_address_3": "",
                                "cadd_pincode": _zipController.text,
                                "cadd_ct_id": 1,
                                "cadd_st_id": 3,
                                "cadd_cnt_id": 1,
                                "cadd_is_default": true
                              };
                              _setAddressBloc.setAddress(body);
                            },
                            child: StreamBuilder<ApiResponse<SetAddressModel>>(
                              stream: _setAddressBloc.setAddressStream,
                              builder: (context, snapshot1) {
                                if (streamCheck) {
                                  if (snapshot1.hasData) {
                                    switch (snapshot1.data!.status) {
                                      case Status.LOADING:
                                        return const Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 3.0,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              darkThemeOrange,
                                            ),
                                          ),
                                        );
                                      case Status.COMPLETED:
                                        {
                                          streamCheck = false;
                                          if (snapshot1.data!.data.Code != 0) {
                                            Future.delayed(Duration.zero, () {
                                              //Get.offAll(() => const CartPage());

                                              setState(() {
                                                addNewAddress = false;
                                                body = {};
                                                _getAddress =
                                                    _getAddressRepository
                                                        .getAddress(
                                                            body, userId);
                                              });
                                            });
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Something is wrong",
                                                fontSize: 14,
                                                backgroundColor: Colors.white,
                                                gravity: ToastGravity.CENTER,
                                                textColor: darkThemeBlue,
                                                toastLength: Toast.LENGTH_LONG);
                                          }
                                          if (kDebugMode) {
                                            print("complete");
                                          }
                                          //managedSharedPref(snapshot.data.data);
                                          //navToAttachList(context);
                                          Fluttertoast.showToast(
                                              msg: "Address Added Successfully",
                                              fontSize: 14,
                                              backgroundColor: Colors.white,
                                              textColor: darkThemeOrange,
                                              toastLength: Toast.LENGTH_LONG);
                                        }

                                        break;
                                      case Status.ERROR:
                                        streamCheck = false;
                                        Future.delayed(Duration.zero, () async {
                                          Fluttertoast.showToast(
                                              msg: "Something is wrong",
                                              fontSize: 16,
                                              backgroundColor: Colors.white,
                                              textColor: darkThemeOrange,
                                              toastLength: Toast.LENGTH_LONG);
                                        });
                                        break;
                                    }
                                  } else if (snapshot1.hasError) {}
                                  if (kDebugMode) {
                                    print("error");
                                  }
                                }
                                return Container(
                                  height: 6.h,
                                  width: 40.w,
                                  margin: EdgeInsets.only(
                                      right: 6.0.w, left: 6.0.w, top: 5.0.w),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: darkThemeBlue,
                                      borderRadius: BorderRadius.circular(5)
                                      //border: Border.all(color: Colors.grey[300]!)
                                      ),
                                  child: Center(
                                    child: Text(
                                      "SAVE ADDRESS",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                  ],
                ),
                // bottomSheet: InkWell(
                //   onTap: () {
                //     if (shopDistance <= 10.0) {
                //       if (_addressId != "") {
                //         Get.to(() => const OrderPlace(
                //               addressId: '1',
                //             ));
                //       } else {
                //         Fluttertoast.showToast(
                //             msg: "Please Select a Address",
                //             fontSize: 16,
                //             backgroundColor: Colors.white,
                //             gravity: ToastGravity.CENTER,
                //             textColor: darkThemeBlue,
                //             toastLength: Toast.LENGTH_LONG);
                //       }
                //     } else {
                //       Fluttertoast.showToast(
                //           msg: "This shop is Undeliverable at your location",
                //           fontSize: 14,
                //           backgroundColor: Colors.orange[100],
                //           textColor: darkThemeBlue,
                //           toastLength: Toast.LENGTH_LONG);
                //     }
                //   },
                //   child: Container(
                //     margin: const EdgeInsets.only(bottom: 0),
                //     height: 55,
                //     decoration: const BoxDecoration(
                //       gradient: LinearGradient(
                //         begin: Alignment.centerLeft,
                //         end: Alignment.centerRight,
                //         colors: <Color>[
                //           darkThemeBlue,
                //           darkThemeBlue,
                //         ],
                //       ),
                //     ),
                //     child: const Center(
                //       child: Text(
                //         'Proceed to Checkout...',
                //         style: TextStyle(
                //             color: Colors.white,
                //             fontWeight: FontWeight.bold,
                //             fontSize: 16),
                //       ),
                //     ),
                //   ),
                // ),
              );
            } else {
              return Center(
                  child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  const Text(
                    "Please Add A New Address",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ));
            }
          } else if (snapshot.hasError) {
            if (kDebugMode) {
              print("hello");
            }
            return const Center(
                child: Text(
              "No Data ",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ));
          } else {
            return const Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                darkThemeOrange,
              ),
            ));
          }
        },
      ),
    );
  }
}
