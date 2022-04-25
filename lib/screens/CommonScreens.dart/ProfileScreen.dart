// import 'dart:math';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:subs_vendor/Utils/Constants.dart';
import 'package:subs_vendor/api/GetUserDetail.dart';
import 'package:subs_vendor/screens/CommonScreens.dart/EditProfilePage.dart';
import 'package:subs_vendor/shared_preferences/token_profile.dart';
import 'package:subs_vendor/shared_preferences/type_preference.dart';

class DisplayProfile extends StatefulWidget {
  static String routeName = "/editInfo";

  const DisplayProfile({Key? key}) : super(key: key);

  @override
  _DisplayProfileState createState() => _DisplayProfileState();
}

class _DisplayProfileState extends State<DisplayProfile> {
  var isType;
  var type;

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final shopController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final pinCodeController = TextEditingController();
  final descriptionController = TextEditingController();
  late final int picIndex;

  @override
  void initState() {
    // TODO: implement initState
    picIndex = Random().nextInt(Images.length);
    super.initState();
    typePreference = TypePreference();
    getProfile();
  }

  getType() async {
    var isType = await typePreference!.getTypeStatus();
    type = isType ? 'vendor' : "Customer";
    print(type.toString());
    return isType;
  }

  Future getProfile() async {
    final mapOfSubs = await getUser(tokenProfile?.token);
    // print('In profile list');
    // print(mapOfSubs);
    nameController.text = mapOfSubs['data']['name'] ?? "";
    emailController.text = mapOfSubs['data']['email'] ?? "";
    addressController.text = mapOfSubs['data']['address'] ?? "";
    pinCodeController.text = mapOfSubs['data']['pincode'] ?? "";
    if (ConstantType == true) {
      shopController.text = mapOfSubs['data']['shopname'] ?? "";
      descriptionController.text = mapOfSubs['data']['name'];
    } else {
      shopController.text = '';
      descriptionController.text = '';
    }

    return mapOfSubs['data'];
  }

  @override
  void dispose() {
    nameController.dispose();
    shopController.dispose();
    emailController.dispose();
    addressController.dispose();
    pinCodeController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    const defaultFontSize = 14.0;
    final containerSize = height * 0.221;
    final picSize = height * 0.08;
    return Form(
      key: _form,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: getProfile(),
            builder: (context, AsyncSnapshot<dynamic> list) {
              if (list.data != null) {
                return ListView(children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: containerSize,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryGrey,
                          borderRadius: BorderRadiusDirectional.only(
                              bottomEnd: Radius.circular(30),
                              bottomStart: Radius.circular(30)),
                        ),
                      ),
                      const Text(
                        "User Info",
                        style: TextStyle(fontSize: 18),
                      ),
                      Positioned(
                          top: containerSize - picSize,
                          child: Container(
                            child: ClipOval(
                              child: Image.asset(
                                Images[picIndex],
                                height: picSize * 2,
                                width: picSize * 2,
                                fit: BoxFit.cover,
                              ),
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.071,
                  ),
                  ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(10),
                      children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Name",
                                style: TextStyle(color: AppColors.iconGrey))),
                        SizedBox(
                          height: height * 0.013,
                        ),
                        SizedBox(
                          height: height * 0.065,
                          child: TextFormField(
                            showCursor: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColors.tileSelectGreen,
                                    width: 0.5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.tileSelectGreen),
                                  borderRadius: BorderRadius.circular(15)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.tileSelectGreen),
                                  borderRadius: BorderRadius.circular(15)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.tileSelectGreen),
                                  borderRadius: BorderRadius.circular(15)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.tileSelectGreen),
                                  borderRadius: BorderRadius.circular(15)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.tileSelectGreen),
                                  borderRadius: BorderRadius.circular(15)),
                              filled: true,
                              fillColor: Colors.white,
                              hintStyle: TextStyle(
                                  color: AppColors.iconGrey,
                                  fontSize: defaultFontSize),
                              hintText: "Enter your Name",
                            ),
                            textCapitalization: TextCapitalization.words,
                            controller: nameController,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.013,
                        ),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Email-ID",
                                style: TextStyle(color: AppColors.iconGrey))),
                        SizedBox(
                          height: height * 0.013,
                        ),
                        SizedBox(
                          height: height * 0.065,
                          child: TextFormField(
                            showCursor: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColors.tileSelectGreen,
                                    width: 0.5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.tileSelectGreen),
                                  borderRadius: BorderRadius.circular(15)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.tileSelectGreen),
                                  borderRadius: BorderRadius.circular(15)),
                              errorStyle: const TextStyle(fontSize: 0.01),
                              errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.tileSelectGreen),
                                  borderRadius: BorderRadius.circular(15)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.tileSelectGreen),
                                  borderRadius: BorderRadius.circular(15)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.tileSelectGreen),
                                  borderRadius: BorderRadius.circular(15)),
                              filled: true,
                              fillColor: Colors.white,
                              hintStyle: TextStyle(
                                  color: AppColors.iconGrey,
                                  fontSize: defaultFontSize),
                              hintText: "Enter your Email-ID",
                            ),
                            controller: emailController,
                            validator: (value) {
                              // Check if this field is empty
                              if (value == null || value.isEmpty) {
                                return 'This field is required';
                              }

                              // using regular expression
                              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                return "Please enter a valid email address";
                              }

                              // the email is valid
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: height * 0.013,
                        ),
                        ConstantType == true
                            ? ListView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                    insertText(
                                        "Shop Name",
                                        "Enter your Shop Name",
                                        shopController,
                                        height),
                                    SizedBox(
                                      height: height * 0.013,
                                    ),
                                    InsertText(
                                        "Description",
                                        "Enter a small Description",
                                        descriptionController,
                                        height),
                                  ])
                            : const SizedBox(),
                        SizedBox(
                          height: height * 0.013,
                        ),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Address",
                              style: TextStyle(color: AppColors.iconGrey),
                            )),
                        SizedBox(
                          height: height * 0.013,
                        ),
                        SizedBox(
                          height: height * 0.1,
                          child: TextFormField(
                            showCursor: true,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(36),

                              /// here char limit is 5
                            ],
                            maxLines: 2,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColors.tileSelectGreen,
                                    width: 0.5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.tileSelectGreen),
                                  borderRadius: BorderRadius.circular(15)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.tileSelectGreen),
                                  borderRadius: BorderRadius.circular(15)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.tileSelectGreen),
                                  borderRadius: BorderRadius.circular(15)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.tileSelectGreen),
                                  borderRadius: BorderRadius.circular(15)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.tileSelectGreen),
                                  borderRadius: BorderRadius.circular(15)),
                              filled: true,
                              fillColor: Colors.white,
                              hintStyle: TextStyle(
                                  color: AppColors.iconGrey,
                                  fontSize: defaultFontSize),
                              hintText: "Enter your address",
                            ),
                            controller: addressController,
                            textCapitalization: TextCapitalization.sentences,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.013,
                        ),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Pincode",
                              style: TextStyle(color: AppColors.iconGrey),
                            )),
                        SizedBox(
                          height: height * 0.013,
                        ),
                        SizedBox(
                          height: height * 0.065,
                          child: TextFormField(
                            showCursor: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColors.tileSelectGreen,
                                    width: 0.5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.tileSelectGreen),
                                  borderRadius: BorderRadius.circular(15)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.tileSelectGreen),
                                  borderRadius: BorderRadius.circular(15)),
                              errorStyle: const TextStyle(fontSize: 0.01),
                              errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.tileSelectGreen),
                                  borderRadius: BorderRadius.circular(15)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.tileSelectGreen),
                                  borderRadius: BorderRadius.circular(15)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.tileSelectGreen),
                                  borderRadius: BorderRadius.circular(15)),
                              filled: true,
                              fillColor: Colors.white,
                              hintStyle: TextStyle(
                                  color: AppColors.iconGrey,
                                  fontSize: defaultFontSize),
                              hintText: "Enter your pincode",
                            ),
                            controller: pinCodeController,
                            keyboardType: TextInputType.number,
                            validator: (value) =>
                                (value?.length != 6) ? 'Empty' : null,
                          ),
                        ),
                        SizedBox(height: height * 0.065),
                        SizedBox(
                          width: double.infinity,
                          height: height * 0.065,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditProfile(
                                            name: nameController.text,
                                            address: addressController.text,
                                            email: emailController.text,
                                            pincode: pinCodeController.text,
                                            shopname: shopController.text,
                                            desc: descriptionController.text)));
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColors.tileSelectGreen),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  )),
                              child: const Text(
                                'Edit Profile',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )),
                        )
                      ])
                ]);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  Widget insertText(String title, String hint, TextEditingController controller,
      double height) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: const TextStyle(color: AppColors.iconGrey),
            )),
        SizedBox(
          height: height * 0.013,
        ),
        SizedBox(
          height: height * 0.065,
          child: TextFormField(
            showCursor: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: AppColors.tileSelectGreen, width: 0.5),
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.tileSelectGreen),
                  borderRadius: BorderRadius.circular(15)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.tileSelectGreen),
                  borderRadius: BorderRadius.circular(15)),
              errorBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.tileSelectGreen),
                  borderRadius: BorderRadius.circular(15)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.tileSelectGreen),
                  borderRadius: BorderRadius.circular(15)),
              disabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.tileSelectGreen),
                  borderRadius: BorderRadius.circular(15)),
              filled: true,
              fillColor: Colors.white,
              hintStyle:
                  const TextStyle(color: AppColors.iconGrey, fontSize: 14),
              hintText: hint,
            ),
            controller: controller,
            textCapitalization: TextCapitalization.sentences,
          ),
        ),
      ],
    );
  }
}
