import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:vinayak/Screens/changePassword/controller/passwordController.dart';
import 'package:vinayak/core/constants/color_constants.dart';
import 'package:vinayak/core/global_controller/user_controller.dart';
import 'package:vinayak/widget/myappbar.dart';
import 'package:vinayak/widget/pciconBtn.dart';
import 'package:vinayak/widget/textfield.dart';

class ChangePassword extends StatefulWidget {
  final double width;
  final double height;

  const ChangePassword({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  UserController uc = Get.put(UserController());
  PasswordController pc = Get.put(PasswordController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: MyAppBar(),
      drawer: uc.userDetails['role'] == 'repo-agent'
          ? MyRepoAgentDrawer()
          : MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Old Password',
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(
                  height: widget.height * 0.01,
                ),
                TextFieldWidget(
                  controller: oldPasswordController,
                  hintText: 'Old Password',
                  borderColor: ColorConstants.aqua,
                  borderRadius: 18,
                  // obscureText: true, // For password fields
                ),
                SizedBox(
                  height: widget.height * 0.02,
                ),
                Text(
                  'New Password',
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(
                  height: widget.height * 0.01,
                ),
                TextFieldWidget(
                  controller: passwordController,
                  hintText: 'New Password',
                  borderColor: ColorConstants.aqua,
                  borderRadius: 18,
                  // obscureText: true,
                ),
                SizedBox(
                  height: widget.height * 0.02,
                ),
                Text(
                  'Confirm Password',
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(
                  height: widget.height * 0.01,
                ),
                TextFieldWidget(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  borderColor: ColorConstants.aqua,
                  borderRadius: 18,
                  // obscureText: true,
                )
              ],
            ),
          ),
          SizedBox(
            height: widget.height * 0.04,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PCIconButton(
                onPressed: () {
                  // Cancel button logic
                  Get.back();
                  oldPasswordController.clear();
                  passwordController.clear();
                  confirmPasswordController.clear();
                },
                width: widget.width * 0.3,
                text: 'Reset',
                backgroundColor: ColorConstants.aqua,
                textColor: Colors.white,
                borderRadius: BorderRadius.circular(18),
                height: widget.height * 0.05,
              ),
              SizedBox(width: widget.width * 0.05),
              PCIconButton(
                onPressed: () {
                  // Check if fields are empty
                  if (oldPasswordController.text.isEmpty ||
                      passwordController.text.isEmpty ||
                      confirmPasswordController.text.isEmpty) {
                    Fluttertoast.showToast(
                      msg: 'Please fill in all the fields',
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  } else {
                    pc.updatePassword(
                      oldPasswordController.value.text,
                      passwordController.value.text,
                      confirmPasswordController.value.text,
                    );
                    oldPasswordController.clear();
                    passwordController.clear();
                    confirmPasswordController.clear();
                  }
                },
                width: widget.width * 0.3,
                text: 'Change',
                borderRadius: BorderRadius.circular(18),
                backgroundColor: ColorConstants.aqua,
                textColor: Colors.white,
                height: widget.height * 0.05,
              )
            ],
          ),
        ],
      ),
    );
  }
}
