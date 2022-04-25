import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Utils/Constants.dart';
import '../../api/UpdateProfileApi.dart';
import '../../shared_preferences/token_profile.dart';
import '../../shared_preferences/type_preference.dart';

import 'BankDetailsScreen.dart';

class ProfilePage extends StatefulWidget {
  static String routeName = "/userInfo";

  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var isType;
  var type;

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final shopController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final pinCodeController = TextEditingController();
  final descriptionController = TextEditingController();
  final _isLoading = ValueNotifier<bool>(false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    typePreference = TypePreference();
  }

  getType() async {
    var isType = await typePreference!.getTypeStatus();
    type = isType ? 'Vendor' : "Customer";
    print(type.toString());
    return isType;
  }

  _onProceed() async {
    if (_form.currentState!.validate() == true) {
      _isLoading.value = true;
      try {
        final responseStatusCode = await UpdateProfile.updateProfile(
            tokenProfile!.token,
            nameController.text,
            emailController.text,
            addressController.text,
            pinCodeController.text,
            type.toString(),
            shopController.text,
            descriptionController.text);
        if (responseStatusCode == 200) {
          print(responseStatusCode);
          print("-Changed Details-");
          Navigator.pushNamed(context, BankDetailScreen.routeName);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Something went wrong"),
            duration: Duration(seconds: 4),
          ));
        }
        _isLoading.value = false;
      } catch (e) {
        _isLoading.value = false;
      }
      _isLoading.value = false;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please Enter Valid Details"),
        duration: Duration(seconds: 4),
      ));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    shopController.dispose();
    emailController.dispose();
    addressController.dispose();
    pinCodeController.dispose();
    descriptionController.dispose();
    _isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    const defaultFontSize = 14.0;
    final containerSize = height * 0.221;
    final picSize = height * 0.08;
    // _isLoading.value = false;
    return Form(
      key: _form,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: getType(),
            builder: (context, AsyncSnapshot<dynamic> type) {
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
                              Images[Random().nextInt(Images.length)],
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
                SizedBox(height: height * 0.071),
                ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    children: [
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Name",
                              style: TextStyle(color: AppColors.iconGrey))),
                      SizedBox(height: height * 0.013),
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
                            hintStyle: const TextStyle(
                                color: AppColors.iconGrey,
                                fontSize: defaultFontSize),
                            hintText: "Enter your Name",
                          ),
                          textCapitalization: TextCapitalization.words,
                          controller: nameController,
                        ),
                      ),
                      SizedBox(height: height * 0.013),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Email-ID",
                              style: TextStyle(color: AppColors.iconGrey))),
                      SizedBox(height: height * 0.013),
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
                            hintStyle: const TextStyle(
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
                      SizedBox(height: height * 0.013),
                      type.data == true
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
                                  insertText(
                                      "Description",
                                      "Enter a small Description",
                                      descriptionController,
                                      height),
                                ])
                          : const SizedBox(),
                      SizedBox(height: height * 0.013),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Address",
                            style: TextStyle(color: AppColors.iconGrey),
                          )),
                      SizedBox(height: height * 0.013),
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
                                  color: AppColors.tileSelectGreen, width: 0.5),
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
                            hintStyle: const TextStyle(
                                color: AppColors.iconGrey,
                                fontSize: defaultFontSize),
                            hintText: "Enter your address",
                          ),
                          controller: addressController,
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ),
                      SizedBox(height: height * 0.013),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Pincode",
                            style: TextStyle(color: AppColors.iconGrey),
                          )),
                      SizedBox(height: height * 0.013),
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
                            hintStyle: const TextStyle(
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
                            onPressed: () async => await _onProceed(),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppColors.tileSelectGreen),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                )),
                            child: ValueListenableBuilder<bool>(
                              valueListenable: _isLoading,
                              builder: (context, value, child) => value
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: height * 0.04,
                                          width: width * 0.075,
                                          child:
                                              const CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: width * 0.05),
                                        const Text(
                                          "Please Wait...",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        )
                                      ],
                                    )
                                  : const Text(
                                      'Proceed',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                            )),
                      )
                    ])
              ]);
            }),
      ),
    );
  }
}

Widget insertText(String title, String hint, TextEditingController controller,
        double height) =>
    ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: const TextStyle(color: AppColors.iconGrey),
            )),
        SizedBox(height: height * 0.013),
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
