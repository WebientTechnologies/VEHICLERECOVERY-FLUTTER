import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinayak/Screens/1RepoStaff/homeR/homeRepo.dart';
import '../../core/constants/color_constants.dart';
import '../../routes/app_routes.dart';
import '../Screens/RepoDataReports/repoDataReports.dart';
import '../Screens/changePassword/changePassword.dart';
import '../Screens/holdDataReports/holddataReports.dart';
import '../Screens/profile/profile.dart';
import '../Screens/releaseDataReports/releaseDatareports.dart';
import '../Screens/repoAgent/repoagent.dart';
import '../Screens/searchDataReports/searchdataReports.dart';
import '../Screens/viewRequest/viewRequest.dart';
import '../core/constants/helper.dart';
import '../core/global_controller/user_controller.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 40,
      title: Text('Vinayak Recovery'),
      titleTextStyle: TextStyle(
        color: ColorConstants.white,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      backgroundColor: ColorConstants.aqua,
      leading: IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: Icon(
          Icons.menu,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40);
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.blue.shade900,
                ColorConstants.back,
                ColorConstants.aqua,
              ], begin: Alignment.topLeft, end: FractionalOffset.bottomRight),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.account_circle,
                    size: 60,
                    color: ColorConstants.aqua,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Vinayak Recovery',
                  style: TextStyle(
                    color: ColorConstants.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              'DASHBOARD',
              style: TextStyle(color: ColorConstants.aqua),
            ),
            leading: Icon(Icons.dashboard, color: ColorConstants.aqua),
            onTap: () {
              Get.toNamed(AppRoutes.home);
            },
          ),
          // ListTile(
          //   title: Text(
          //     'CLIENT',
          //     style: TextStyle(color: ColorConstants.aqua),
          //   ),
          //   leading: Icon(Icons.person, color: ColorConstants.aqua),
          //   onTap: () {
          //     Get.to(ClientScreen());
          //   },
          // ),
          ListTile(
            title: Text(
              'REPO AGENT APPROVAL',
              style: TextStyle(color: ColorConstants.aqua),
            ),
            leading: Icon(Icons.people, color: ColorConstants.aqua),
            onTap: () {
              Get.to(RepoAgent());
            },
          ),
          ListTile(
            title: Text(
              'ADD REPO AGENT',
              style: TextStyle(color: ColorConstants.aqua),
            ),
            leading: Icon(Icons.person_add, color: ColorConstants.aqua),
            onTap: () {
              // Get.to(AddRepoAgent());
              Get.toNamed(AppRoutes.agentRegi, arguments: ['homePage']);
              // Handle add repo agent tap
            },
          ),
          ListTile(
            title: Text(
              'PROFILE',
              style: TextStyle(color: ColorConstants.aqua),
            ),
            leading: Icon(Icons.account_circle, color: ColorConstants.aqua),
            onTap: () {
              Get.to(Profile());
            },
          ),
          ListTile(
            title: Text(
              'CHANGE PASSWORD',
              style: TextStyle(color: ColorConstants.aqua),
            ),
            leading: Icon(Icons.lock, color: ColorConstants.aqua),
            onTap: () {
              Get.to(ChangePassword(
                width: Get.width,
                height: Get.height,
              ));
            },
          ),
          ListTile(
            title: Text(
              'VIEW REQUEST',
              style: TextStyle(color: ColorConstants.aqua),
            ),
            leading: Icon(Icons.visibility, color: ColorConstants.aqua),
            onTap: () {
              Get.to(ViewRequest());
            },
          ),
          ListTile(
            title: Text(
              'SEARCH DATA REPORTS',
              style: TextStyle(color: ColorConstants.aqua),
            ),
            leading: Icon(Icons.search, color: ColorConstants.aqua),
            onTap: () {
              Get.to(SearchDataReports());
            },
          ),
          ListTile(
            title: Text(
              'HOLD DATA REPORTS',
              style: TextStyle(color: ColorConstants.aqua),
            ),
            leading: Icon(Icons.bookmark, color: ColorConstants.aqua),
            onTap: () {
              Get.to(HoldDataReports());
            },
          ),
          ListTile(
            title: Text(
              'REPO DATA REPORTS',
              style: TextStyle(color: ColorConstants.aqua),
            ),
            leading: Icon(Icons.people, color: ColorConstants.aqua),
            onTap: () {
              Get.to(RepoDataReports());
            },
          ),
          ListTile(
            title: Text(
              'RELEASE DATA REPORTS',
              style: TextStyle(color: ColorConstants.aqua),
            ),
            leading: Icon(Icons.person_pin, color: ColorConstants.aqua),
            onTap: () {
              Get.to(ReleaseDataReports());
            },
          ),
          ListTile(
            title: Text(
              'LOGOUT',
              style: TextStyle(color: ColorConstants.aqua),
            ),
            leading: Icon(Icons.logout, color: ColorConstants.aqua),
            onTap: () async {
              UserController uc = Get.find<UserController>();
              uc.deleteUserDetails();
              await Helper.setStringPreferences('token', '');
              Get.offAllNamed(AppRoutes.signin);
            },
          ),
        ],
      ),
    );
  }
}

class MyRepoAgentDrawer extends StatelessWidget {
  const MyRepoAgentDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.blue.shade900,
                ColorConstants.back,
                ColorConstants.aqua,
              ], begin: Alignment.topLeft, end: FractionalOffset.bottomRight),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.account_circle,
                    size: 60,
                    color: ColorConstants.aqua,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Vinayak Recovery',
                  style: TextStyle(
                    color: ColorConstants.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              'DASHBOARD',
              style: TextStyle(color: ColorConstants.aqua),
            ),
            leading: Icon(Icons.dashboard, color: ColorConstants.aqua),
            onTap: () {
              Get.to(HomeScreenRepoStaff());
            },
          ),
          ListTile(
            title: Text(
              'CHANGE PASSWORD',
              style: TextStyle(color: ColorConstants.aqua),
            ),
            leading: Icon(Icons.lock, color: ColorConstants.aqua),
            onTap: () {
              Get.to(ChangePassword(
                width: Get.width,
                height: Get.height,
              ));
            },
          ),
          ListTile(
            title: Text(
              'PROFILE',
              style: TextStyle(color: ColorConstants.aqua),
            ),
            leading: Icon(Icons.account_circle, color: ColorConstants.aqua),
            onTap: () {
              Get.to(Profile());
            },
          ),
          // Repo Data Reports Main Item
          ExpansionTile(
            title: Text(
              'REPO DATA REPORTS',
              style: TextStyle(color: ColorConstants.aqua),
            ),
            leading: Icon(Icons.people, color: ColorConstants.aqua),
            children: [
              // Submenu items for Repo Data Reports
              buildSubMenuItem('Hold Data List', Icons.bookmark, () {
                Get.to(HoldDataReports());
              }),
              buildSubMenuItem('Repo Data List', Icons.menu, () {
                Get.to(RepoDataReports());
              }),
              buildSubMenuItem('Release Data List', Icons.person_pin, () {
                Get.to(ReleaseDataReports());
              }),
            ],
          ),
          ListTile(
            title: Text(
              'LOGOUT',
              style: TextStyle(color: ColorConstants.aqua),
            ),
            leading: Icon(Icons.logout, color: ColorConstants.aqua),
            onTap: () async {
              UserController uc = Get.find<UserController>();
              uc.deleteUserDetails();
              await Helper.setStringPreferences('token', '');
              Get.offAllNamed(AppRoutes.signin);
            },
          ),
        ],
      ),
    );
  }

  ListTile buildSubMenuItem(String title, IconData icon, Function onTap) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: ColorConstants.aqua),
      ),
      leading: Icon(icon, color: ColorConstants.aqua),
      onTap: () {
        Navigator.pop(Get.context!); // Close the drawer
        onTap();
      },
    );
  }
}
