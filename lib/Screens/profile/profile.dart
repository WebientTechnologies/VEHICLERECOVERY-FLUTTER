import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinayak/core/constants/color_constants.dart';
import 'package:vinayak/core/global_controller/user_controller.dart';
import 'package:vinayak/widget/myappbar.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UserController uc = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    uc.loadUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: MyAppBar(),
      body: LayoutBuilder(
        builder: (ctx, constraints) {
          var height = constraints.maxHeight;
          var width = constraints.maxWidth;
          return Column(
            children: [
              Container(
                height: height * 0.33,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue,
                      ColorConstants.back,
                      ColorConstants.aqua,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
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
                      child: Icon(
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
                        decoration: BoxDecoration(),
                        child: Text(
                          uc.userDetails['role'] == 'office-staff'
                              ? uc.userDetails['staf']['name']
                              : uc.userDetails['agent']['name'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ColorConstants.aqua,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width * 0.4,
                height: height * 0.06,
                color: ColorConstants.aqua,
                child: Center(
                  child: Text(
                    'Account Info',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAccountInfoRow(
                      label: 'Name',
                      value: uc.userDetails['role'] == 'office-staff'
                          ? uc.userDetails['staf']['name']
                          : uc.userDetails['agent']['name'],
                      icon: Icons.person,
                    ),
                    _buildAccountInfoRow(
                      label: 'Email',
                      value: uc.userDetails['role'] == 'office-staff'
                          ? uc.userDetails['staf']['email']
                          : uc.userDetails['agent']['email'],
                      icon: Icons.email,
                    ),
                    _buildAccountInfoRow(
                      label: 'Mobile',
                      value: uc.userDetails['role'] == 'office-staff'
                          ? uc.userDetails['staf']['mobile']
                          : uc.userDetails['agent']['mobile'],
                      icon: Icons.phone,
                    ),
                    _buildAccountInfoRow(
                      label: 'Address',
                      value: uc.userDetails['role'] == 'office-staff'
                          ? uc.userDetails['staf']['addressLine1']
                          : uc.userDetails['agent']['addressLine1'],
                      icon: Icons.location_on,
                    ),
                    _buildAccountInfoRow(
                      label: 'DOB',
                      value: '',
                      icon: Icons.calendar_today,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      drawer: uc.userDetails['role'] == 'repo-agent'
          ? MyRepoAgentDrawer()
          : MyDrawer(),
    );
  }

  Widget _buildAccountInfoRow({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: ColorConstants.aqua,
            size: 40,
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: ColorConstants.aqua,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: ColorConstants.aqua,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
