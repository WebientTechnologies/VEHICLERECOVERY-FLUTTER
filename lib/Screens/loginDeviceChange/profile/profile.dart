import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinayak/Screens/contact_info/contact_info.dart';
import 'package:vinayak/core/constants/color_constants.dart';
import 'package:vinayak/core/global_controller/user_controller.dart';

import '../../../core/constants/helper.dart';
import '../../../core/utils/routes/app_routes.dart';
import '../../changePassword/changePassword.dart';
import '../../repoAgent/repoagent.dart';
import '../../viewRequest/viewRequest.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UserController uc = Get.put(UserController());

  bool showExtra = false;

  @override
  void initState() {
    super.initState();
    uc.loadUserDetails();

    load();
  }

  Future load() async {
    showExtra = uc.userDetails['role'] == 'office-staff' ? true : false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorConstants.aqua),
        title: Text(
          'Profile',
          style: TextStyle(
              fontWeight: FontWeight.w500, color: ColorConstants.aqua),
        ),
      ),
      body: LayoutBuilder(
        builder: (ctx, constraints) {
          var height = constraints.maxHeight;
          return Column(
            children: [
              SizedBox(
                height: height * 0.33,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorConstants.aqua,
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ),
                      ),
                      child: const Icon(
                        Icons.account_circle,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 50,
                        decoration: const BoxDecoration(),
                        child: Text(
                          uc.userDetails['role'] == 'office-staff'
                              ? uc.userDetails['staf']['name']
                              : uc.userDetails['agent']['name'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ColorConstants.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (showExtra) const Divider(),
              if (showExtra)
                GestureDetector(
                  onTap: () {
                    Get.to(const RepoAgent());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.people,
                          color: ColorConstants.aqua,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Repo Agent Approval',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: ColorConstants.aqua,
                        )
                      ],
                    ),
                  ),
                ),
              if (showExtra) const Divider(),
              if (showExtra)
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.agentRegi, arguments: ['homePage']);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_add,
                          color: ColorConstants.aqua,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Add Repo Agent',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: ColorConstants.aqua,
                        )
                      ],
                    ),
                  ),
                ),
              if (showExtra) const Divider(),
              if (showExtra)
                GestureDetector(
                  onTap: () {
                    Get.to(ViewRequest());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_add,
                          color: ColorConstants.aqua,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'View Request',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: ColorConstants.aqua,
                        )
                      ],
                    ),
                  ),
                ),
              const Divider(),
              GestureDetector(
                onTap: () {
                  Get.to(const ContactInfo());
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: ColorConstants.aqua,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Contact Info',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: ColorConstants.aqua,
                      )
                    ],
                  ),
                ),
              ),
              const Divider(),
              GestureDetector(
                onTap: () {
                  Get.to(ChangePassword(
                    width: Get.width,
                    height: Get.height,
                  ));
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Row(
                    children: [
                      Icon(
                        Icons.password,
                        color: ColorConstants.aqua,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Change Password',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: ColorConstants.aqua,
                      )
                    ],
                  ),
                ),
              ),
              const Divider(),
              GestureDetector(
                onTap: () async {
                  UserController uc = Get.find<UserController>();
                  uc.deleteUserDetails();
                  await Helper.setStringPreferences('token', '');
                  Get.offAllNamed(AppRoutes.signin);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: ColorConstants.aqua,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Logout',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: ColorConstants.aqua,
                      )
                    ],
                  ),
                ),
              ),
              const Divider(),
            ],
          );
        },
      ),
    );
  }
}
