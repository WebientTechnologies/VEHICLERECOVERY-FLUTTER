import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:vinayak/Screens/LoginScreen/controller/loginController.dart';
import 'package:vinayak/core/constants/color_constants.dart';
import 'package:vinayak/core/constants/helper.dart';
import 'package:vinayak/core/utils/routes/app_routes.dart';
import 'package:vinayak/widget/pciconBtn.dart';
import 'package:vinayak/widget/textfield.dart';

import '../forgotPassword/forgotPassword.dart';
import '../loginDeviceChange/loginDeviceChange.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController lc = Get.put(LoginController());

  // Function to validate email
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid username';
    }

    lc.emailError.value = '';
    return null;
  }

  // Function to handle button click
  Future<void> handleButtonClick() async {
    String? emailError = validateEmail(lc.emailcont.value.text);

    // if (emailError != null) {
    //   // Display error toast
    //   Fluttertoast.showToast(
    //     msg: emailError,
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //     fontSize: 16.0,
    //   );
    // } else {
    // Continue with your button click logic
    var deviceId = await Helper.getStringPreferences('deviceId');

    if (deviceId == null) {
      String deviceID = Uuid().v4();
      await Helper.setStringPreferences('deviceId', deviceID);
    }

    lc.login(context);
    //}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (ctx, constraints) {
          var height = constraints.maxHeight;
          var width = constraints.maxWidth;
          return Stack(
            children: [
              Image.asset(
                'assets/images/back.jpg',
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: height * 0.15,
                left: width * 0.05,
                child: Container(
                  width: width * 0.9,
                  height: height * 0.7,
                  decoration: BoxDecoration(
                    color: ColorConstants.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          height: 120,
                          margin: const EdgeInsets.only(top: 40),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/logo.jpg'),
                              fit: BoxFit.contain,
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                        ),
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.all(22.0),
                        child: Column(
                          children: [
                            TextFieldWidget(
                              controller: lc.emailcont.value,
                              borderColor: ColorConstants.aqua,
                              borderWidth: 2,
                              hintText: 'Username',
                              borderRadius: 18,
                              validator: validateEmail,
                            ),
                            SizedBox(height: 8),
                            // Conditionally display error message
                            if (lc.emailError.value.isNotEmpty)
                              Text(
                                lc.emailError.value,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: height * 0.017,
                                ),
                              ),
                            SizedBox(height: 20),
                            TextFieldWidget(
                                controller: lc.passcont.value,
                                borderColor: ColorConstants.aqua,
                                borderWidth: 2,
                                hintText: 'Password',
                                borderRadius: 18,
                                obscureText: true),
                            SizedBox(height: height * 0.04),
                            PCIconButton(
                              onPressed: handleButtonClick,
                              text: 'Login',
                              textColor: ColorConstants.white,
                              textSize: height * 0.024,
                              width: width * 0.7,
                              height: height * 0.05,
                              backgroundColor: ColorConstants.aqua,
                              borderRadius: BorderRadius.circular(22),
                            ),
                            SizedBox(height: height * 0.015),
                            PCIconButton(
                              onPressed: () {
                                Get.toNamed(AppRoutes.agentRegi,
                                    arguments: ['loginPage']);
                              },
                              borderRadius: BorderRadius.circular(22),
                              text: 'Agent Registration',
                              textColor: ColorConstants.white,
                              textSize: height * 0.024,
                              width: width * 0.7,
                              height: height * 0.05,
                              backgroundColor: ColorConstants.aqua,
                            ),
                            SizedBox(height: height * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Get.to(LoginForgotPassword());
                                  },
                                  child: Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                      color: ColorConstants.aqua,
                                      fontSize: height * 0.017,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.to(DeviceChangeScreen());
                                  },
                                  child: Text(
                                    'Device Change',
                                    style: TextStyle(
                                      color: ColorConstants.aqua,
                                      fontSize: height * 0.017,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
