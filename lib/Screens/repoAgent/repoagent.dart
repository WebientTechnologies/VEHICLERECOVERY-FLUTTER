import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinayak/Screens/repoAgent/controller/repoController.dart';
import 'package:vinayak/core/response/status.dart';
import 'package:vinayak/widget/myappbar.dart';
import 'package:vinayak/widget/pciconBtn.dart';
import 'package:vinayak/widget/textfield.dart';

import '../../core/constants/color_constants.dart';

class RepoAgent extends StatefulWidget {
  const RepoAgent({Key? key}) : super(key: key);

  @override
  State<RepoAgent> createState() => _RepoAgentState();
}

class _RepoAgentState extends State<RepoAgent> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  RepoAgentController rac = Get.put(RepoAgentController());

  @override
  void initState() {
    super.initState();
    rac.getAllRepoAgentData(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorConstants.aqua),
        title: Text(
          'Repo Agent Approval',
          style: TextStyle(
              fontWeight: FontWeight.w500, color: ColorConstants.aqua),
        ),
      ),
      key: _scaffoldKey,
      body: LayoutBuilder(builder: (ctx, constraints) {
        var height = constraints.maxHeight;
        var width = constraints.maxWidth;
        return Obx(() {
          switch (rac.rxRequestAllRepoStatus.value) {
            case Status.LOADING:
              return Center(
                child: CircularProgressIndicator(),
              );
            case Status.ERROR:
              return Center(
                child: Text('Something went wrong'),
              );
            case Status.COMPLETED:
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: rac.allRepoModel.value.agents!.length,
                      itemBuilder: (ctx, index) {
                        Color bgColor = index % 2 == 0
                            ? ColorConstants.back
                            : ColorConstants.aqua;

                        return RepoDetailsWidget(
                          height: height,
                          width: width,
                          agentid:
                              rac.allRepoModel.value.agents?[index].id ?? '',
                          status:
                              '${rac.allRepoModel.value.agents?[index].status}',
                          id: rac.allRepoModel.value.agents?[index].agentId ??
                              '',
                          aadharNo: rac.allRepoModel.value.agents?[index]
                                  .aadharCard ??
                              '',
                          mobileno:
                              rac.allRepoModel.value.agents?[index].mobile ??
                                  '',
                          name:
                              rac.allRepoModel.value.agents?[index].name ?? '',
                          panNo:
                              rac.allRepoModel.value.agents?[index].panCard ??
                                  '',
                          username:
                              rac.allRepoModel.value.agents?[index].username ??
                                  '',
                          backgroundColor: bgColor,
                        );
                      },
                    ),
                  ),
                ],
              );
          }
        });
      }),
    );
  }
}

class RepoDetailsWidget extends StatefulWidget {
  String agentid;
  final double height;
  final double width;
  final String id, name, mobileno, panNo, aadharNo, username;
  final Color backgroundColor;
  final String status;

  RepoDetailsWidget({
    Key? key,
    required this.agentid,
    required this.status,
    required this.height,
    required this.width,
    required this.id,
    required this.aadharNo,
    required this.mobileno,
    required this.name,
    required this.panNo,
    required this.username,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  State<RepoDetailsWidget> createState() => _RepoDetailsWidgetState();
}

class _RepoDetailsWidgetState extends State<RepoDetailsWidget> {
  RepoAgentController rac = Get.put(RepoAgentController());
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Seezer Id',
                        style: TextStyle(
                          color: ColorConstants.white,
                          fontWeight: FontWeight.bold,
                          fontSize: widget.height * 0.02,
                        ),
                      ),
                      Text(
                        widget.id,
                        style: TextStyle(
                          color: ColorConstants.white,
                          fontSize: widget.height * 0.02,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Pan No',
                        style: TextStyle(
                          color: ColorConstants.white,
                          fontWeight: FontWeight.bold,
                          fontSize: widget.height * 0.02,
                        ),
                      ),
                      Text(
                        widget.panNo,
                        style: TextStyle(
                          color: ColorConstants.white,
                          fontSize: widget.height * 0.02,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Seezer Name',
                        style: TextStyle(
                          color: ColorConstants.white,
                          fontWeight: FontWeight.bold,
                          fontSize: widget.height * 0.02,
                        ),
                      ),
                      Text(
                        widget.name,
                        style: TextStyle(
                          color: ColorConstants.white,
                          fontSize: widget.height * 0.02,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Aadhaar No',
                        style: TextStyle(
                          color: ColorConstants.white,
                          fontWeight: FontWeight.bold,
                          fontSize: widget.height * 0.02,
                        ),
                      ),
                      Text(
                        widget.aadharNo,
                        style: TextStyle(
                          color: ColorConstants.white,
                          fontSize: widget.height * 0.02,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mobile No',
                        style: TextStyle(
                          color: ColorConstants.white,
                          fontWeight: FontWeight.bold,
                          fontSize: widget.height * 0.02,
                        ),
                      ),
                      Text(
                        widget.mobileno,
                        style: TextStyle(
                          color: ColorConstants.white,
                          fontSize: widget.height * 0.02,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Username',
                        style: TextStyle(
                          color: ColorConstants.white,
                          fontWeight: FontWeight.bold,
                          fontSize: widget.height * 0.02,
                        ),
                      ),
                      Text(
                        widget.username,
                        style: TextStyle(
                          color: ColorConstants.white,
                          fontSize: widget.height * 0.02,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.status == 'active')
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      'Activate',
                      style: TextStyle(color: ColorConstants.green),
                    ),
                  ),
                if (widget.status == 'active')
                  ElevatedButton(
                    onPressed: () {
                      rac.updateStatus(widget.agentid, 'inactive');
                    },
                    child: Text(
                      'Deny',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: const ButtonStyle(
                        shape:
                            MaterialStatePropertyAll(RoundedRectangleBorder()),
                        backgroundColor: MaterialStatePropertyAll(Colors.red)),
                  ),
                if (widget.status == 'inactive')
                  const Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      'Deactivate',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                if (widget.status == 'inactive')
                  ElevatedButton(
                    onPressed: () {
                      rac.updateStatus(widget.agentid, 'active');
                    },
                    child: Text(
                      'Accept',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        shape:
                            MaterialStatePropertyAll(RoundedRectangleBorder()),
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xFF4bb050))),
                  ),
                ElevatedButton(
                  onPressed: () {
                    rac.updateDeviceId(widget.agentid);
                  },
                  style: const ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder()),
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xFF4bb050))),
                  child: const Text(
                    'Change\nDevice',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showPasswordChangeDialog();
                  },
                  style: const ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder()),
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xFF4bb050))),
                  child: const Text(
                    textAlign: TextAlign.center,
                    'Change\nPassword',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _showPasswordChangeDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(),
          contentPadding: EdgeInsets.zero,
          content: Container(
              width: widget.width * 0.9,
              height: widget.height * 0.34,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: widget.width * 0.9,
                    color: ColorConstants.aqua,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Change Password',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        ),
                        SizedBox(
                          height: widget.height * 0.01,
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
                        )
                      ],
                    ),
                  )
                ],
              )),
          actions: [
            PCIconButton(
              onPressed: () {
                Get.back();
                passwordController.clear();
                confirmPasswordController.clear();
              },
              width: widget.width * 0.3,
              text: 'Cancel',
              backgroundColor: ColorConstants.aqua,
              textColor: Colors.white,
              borderRadius: BorderRadius.circular(18),
              height: widget.height * 0.05,
            ),
            // Spacer(),
            PCIconButton(
              onPressed: () {
                rac.updatePassword(
                    widget.agentid,
                    passwordController.value.text,
                    confirmPasswordController.value.text);
                passwordController.clear();
                confirmPasswordController.clear();
              },
              width: widget.width * 0.3,
              text: 'Change',
              borderRadius: BorderRadius.circular(18),
              backgroundColor: ColorConstants.aqua,
              textColor: Colors.white,
              height: widget.height * 0.05,
            )
          ],
        );
      },
    );
  }
}
