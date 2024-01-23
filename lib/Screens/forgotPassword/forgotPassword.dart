import 'package:flutter/material.dart';
import 'package:vinayak/core/constants/color_constants.dart';
import 'package:vinayak/widget/pciconBtn.dart';
import 'package:vinayak/widget/textfield.dart';

class LoginForgotPassword extends StatelessWidget {
  const LoginForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(builder: (ctx, constraints) {
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
              top: height * 0.08,
              left: width * 0.05,
              child: Container(
                width: width * 0.9,
                height: height * 0.8,
                decoration: BoxDecoration(
                  color: ColorConstants.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            width: width * 0.33,
                            height: height * 0.15,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/logo.jpg'),
                                fit: BoxFit.cover,
                                alignment: Alignment
                                    .centerLeft, // Adjust this alignment as needed
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Vinayak Recovery',
                          style: TextStyle(
                              color: ColorConstants.aqua,
                              fontSize: height * 0.03),
                        ),
                        ListView(
                          shrinkWrap: true,
                          children: [
                            TextFieldWidget(
                              // First TextField for username
                              controller: TextEditingController(),
                              borderColor: ColorConstants.aqua,
                              borderWidth: 2,
                              hintText: 'Username',
                              borderRadius: 18,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFieldWidget(
                              // Second TextField for registered mobile no
                              controller: TextEditingController(),
                              borderColor: ColorConstants.aqua,
                              borderWidth: 2,
                              hintText: 'Registered Mobile No',
                              borderRadius: 18,
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            PCIconButton(
                              // Button to send OTP
                              onPressed: () {
                                // Add logic to send OTP
                              },
                              text: 'Send OTP',
                              textColor: ColorConstants.white,
                              textSize: height * 0.024,
                              width: width * 0.7,
                              height: height * 0.05,
                              backgroundColor: ColorConstants.aqua,
                              borderRadius: BorderRadius.circular(22),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            TextFieldWidget(
                              // Third TextField for entering password
                              controller: TextEditingController(),
                              borderColor: ColorConstants.aqua,
                              borderWidth: 2,
                              hintText: 'Enter Password',
                              borderRadius: 18,
                              // obscureText: true,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFieldWidget(
                              // Fourth TextField for re-entering password
                              controller: TextEditingController(),
                              borderColor: ColorConstants.aqua,
                              borderWidth: 2,
                              hintText: 'Re-enter Password',
                              borderRadius: 18,
                              // obscureText: true,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFieldWidget(
                              // Fifth TextField for entering OTP
                              controller: TextEditingController(),
                              borderColor: ColorConstants.aqua,
                              borderWidth: 2,
                              hintText: 'Enter OTP',
                              borderRadius: 18,
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            PCIconButton(
                              // Button to submit
                              onPressed: () {
                                // Add logic to submit
                              },
                              text: 'Submit',
                              textColor: ColorConstants.white,
                              textSize: height * 0.024,
                              width: width * 0.7,
                              height: height * 0.05,
                              backgroundColor: ColorConstants.aqua,
                              borderRadius: BorderRadius.circular(22),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
