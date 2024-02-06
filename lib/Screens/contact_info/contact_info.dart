import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinayak/core/global_controller/user_controller.dart';

import '../../core/constants/color_constants.dart';

class ContactInfo extends StatefulWidget {
  const ContactInfo({super.key});

  @override
  State<ContactInfo> createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {
  UserController uc = Get.find<UserController>();

  @override
  void initState() {
    // TODO: implement initState
    uc.loadUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorConstants.aqua),
        title: Text(
          'Contact Info',
          style: TextStyle(
              fontWeight: FontWeight.w500, color: ColorConstants.aqua),
        ),
      ),
      body: Container(
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
            // _buildAccountInfoRow(
            //   label: 'DOB',
            //   value: '',
            //   icon: Icons.calendar_today,
            // ),
          ],
        ),
      ),
    );
  }
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
                color: ColorConstants.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
