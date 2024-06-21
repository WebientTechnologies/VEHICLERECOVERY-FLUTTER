import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:vinayak/Screens/agentRegisteration/controller/agenRegistController.dart';
import 'package:vinayak/core/constants/color_constants.dart';
import 'package:vinayak/core/response/status.dart';
import 'package:vinayak/core/utils/routes/app_routes.dart';
import 'package:vinayak/widget/myappbar.dart';
import 'package:vinayak/widget/pciconBtn.dart';
import 'package:vinayak/widget/textfield.dart';

class AgentReisteration extends StatefulWidget {
  const AgentReisteration({Key? key}) : super(key: key);

  @override
  State<AgentReisteration> createState() => _AgentReisterationState();
}

class _AgentReisterationState extends State<AgentReisteration> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  String dropdown1 = 'None';
  String dropdown2 = 'Select';
  String dropdown3 = 'Select';
  String zoneId = '';
  String cityid = '';
  String stateid = '';
  String country = "";
  String state = "";
  String city = "";
  String page = '';
  bool isLogin = true;
  AgentRegistrationController arc = Get.put(AgentRegistrationController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    arc.getAllZoneApiData();
    page = Get.arguments[0];
    if (page == 'loginPage') {
      isLogin = true;
    } else {
      isLogin = false;
    }
  }

  void resetFields() {
    arc.nameController.value.clear();
    arc.mobileController.value.clear();
    arc.alternativeMobileController.value.clear();
    arc.emailController.value.clear();
    arc.panCardController.value.clear();
    arc.aadharCardController.value.clear();
    arc.addressLine1Controller.value.clear();
    arc.addressLine2Controller.value.clear();
    arc.stateController.value.clear();
    arc.cityController.value.clear();
    arc.pincodeController.value.clear();
    arc.usernameController.value.clear();
    arc.passwordController.value.clear();

    // Reset dropdown values
    setState(() {
      dropdown1 = 'None';
      dropdown2 = 'Select';
      dropdown3 = 'Select';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      resizeToAvoidBottomInset: false,
      appBar: isLogin
          ? AppBar(
              title: const Text('Agent Registration'),
              titleTextStyle: TextStyle(
                color: ColorConstants.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
              backgroundColor: ColorConstants.aqua,
              automaticallyImplyLeading: false,
            )
          : AppBar(
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
          var width = constraints.maxWidth;
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: ColorConstants.aqua, width: 2),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      margin: EdgeInsets.all(5),
                      height: 40,
                      width: width * 0.95,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                        child: Text(
                          'S0011',
                          style: TextStyle(
                              color: ColorConstants.aqua,
                              fontSize: height * 0.023,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  Center(child: Obx(() {
                    switch (arc.rxRequestZoneStatus.value) {
                      case Status.LOADING:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      case Status.ERROR:
                        return Text('Something went wrong');
                      case Status.COMPLETED:
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorConstants.aqua, width: 2),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          height: 50,
                          width: width * 0.95,
                          margin: EdgeInsets.all(4),
                          child: DropdownButtonHideUnderline(
                            child: GFDropdown(
                              icon: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: VerticalDivider(
                                      width: 3,
                                      thickness: 2,
                                      color: ColorConstants.aqua,
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 30,
                                  ),
                                ],
                              ),
                              focusColor: ColorConstants.aqua,
                              iconEnabledColor: ColorConstants.aqua,
                              isExpanded: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              borderRadius: BorderRadius.circular(18),
                              dropdownButtonColor: Colors.white,
                              value: dropdown1,
                              onChanged: (newValue) {
                                setState(() {
                                  dropdown1 = newValue.toString();
                                  // Get the selected zone
                                  var selectedZone =
                                      arc.zoneModel.value.zones!.firstWhere(
                                    (zone) => zone.name == dropdown1,
                                  );
                                  zoneId = selectedZone.id ?? '';
                                  arc.getAllStateApiData(selectedZone.id ?? '');
                                });
                              },
                              items: [
                                'None',
                                ...arc.zoneModel.value.zones!
                                    .map((value) => value.name!)
                              ]
                                  .map((value) => DropdownMenuItem(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                              color: ColorConstants.aqua),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        );
                    }
                  })),
                  Obx(() {
                    switch (arc.rxRequestStateStatus.value) {
                      case Status.LOADING:
                        return Center(
                            // child: CircularProgressIndicator(),
                            );
                      case Status.ERROR:
                        return Center(
                          child: Text('Something went wrong'),
                        );
                      case Status.COMPLETED:
                        return Center(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: ColorConstants.aqua, width: 2),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            height: 50,
                            width: width * 0.95,
                            margin: EdgeInsets.all(4),
                            child: DropdownButtonHideUnderline(
                              child: GFDropdown(
                                icon: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: VerticalDivider(
                                        width: 3,
                                        thickness: 2,
                                        color: ColorConstants.aqua,
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 30,
                                    ),
                                  ],
                                ),
                                focusColor: ColorConstants.aqua,
                                iconEnabledColor: ColorConstants.aqua,
                                isExpanded: true,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                borderRadius: BorderRadius.circular(18),
                                dropdownButtonColor: Colors.white,
                                value: dropdown2,
                                onChanged: (newValue) {
                                  setState(() {
                                    dropdown2 = newValue.toString();
                                    print('Selected Dropdown 2: $dropdown2');

                                    // Find the selected state
                                    var selectedState =
                                        arc.stateModel.value.states!.firstWhere(
                                      (state) => state.id == dropdown2,
                                    );
                                    stateid = selectedState.id ?? '';
                                    print('Selected State: $selectedState');

                                    if (selectedState != null) {
                                      // Make API call
                                      arc.getAllCityApiData(
                                          selectedState.id ?? '');
                                    }
                                  });
                                },
                                items: [
                                  'Select', // Ensure 'Select' is unique
                                  ...arc.stateModel.value.states!
                                      .map((value) => value.id)
                                      .toList()
                                ]
                                    .map((value) => DropdownMenuItem(
                                          value: value,
                                          child: Text(
                                            value == 'Select'
                                                ? 'Select'
                                                : arc.stateModel.value.states!
                                                        .firstWhere((state) =>
                                                            state.id == value)
                                                        .name ??
                                                    '',
                                            style: TextStyle(
                                                color: ColorConstants.aqua),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                          ),
                        );
                    }
                  }),

                  // Third Dropdown
                  Obx(() {
                    switch (arc.rxRequestCityStatus.value) {
                      case Status.LOADING:
                        return Center(
                            // child: CircularProgressIndicator(),
                            );
                      case Status.ERROR:
                        return Center(
                          child: Text('Something went wrong'),
                        );
                      case Status.COMPLETED:
                        return Center(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: ColorConstants.aqua, width: 2),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            height: 50,
                            width: width * 0.95,
                            margin: EdgeInsets.all(4),
                            child: DropdownButtonHideUnderline(
                              child: GFDropdown(
                                icon: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: VerticalDivider(
                                        width: 3,
                                        thickness: 2,
                                        color: ColorConstants.aqua,
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 30,
                                    ),
                                  ],
                                ),
                                focusColor: ColorConstants.aqua,
                                iconEnabledColor: ColorConstants.aqua,
                                isExpanded: true,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                borderRadius: BorderRadius.circular(18),
                                dropdownButtonColor: Colors.white,
                                value: dropdown3,
                                onChanged: (newValue) {
                                  setState(() {
                                    dropdown3 = newValue.toString();
                                    var selectedState =
                                        arc.cityModel.value.cities!.firstWhere(
                                      (city) => city.id == dropdown3,
                                    );
                                    cityid = selectedState.id ?? '';
                                  });
                                },
                                items: [
                                  'Select',
                                  ...arc.cityModel.value.cities!
                                      .map((value) => value.id)
                                      .toList()
                                ]
                                    .map((value) => DropdownMenuItem(
                                          value: value,
                                          child: Text(
                                            value == 'Select'
                                                ? 'Select'
                                                : arc.cityModel.value.cities!
                                                        .firstWhere((state) =>
                                                            state.id == value)
                                                        .name ??
                                                    '',
                                            style: TextStyle(
                                                color: ColorConstants.aqua),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                          ),
                        );
                    }
                  }),

                  SizedBox(height: 10),
                  TextFieldWidget(
                    controller: arc.nameController.value,
                    hintText: 'Seezer Name',
                    width: width * 0.95,
                    borderRadius: 18,
                    height: 40,
                    borderColor: ColorConstants.aqua,
                    textColor: ColorConstants.aqua,
                  ),
                  SizedBox(height: 10), // Add padding here
                  TextFieldWidget(
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    controller: arc.mobileController.value,
                    hintText: 'Mobile Number',
                    width: width * 0.95,
                    borderRadius: 18,
                    height: 40,
                    borderColor: ColorConstants.aqua,
                    textColor: ColorConstants.aqua,
                  ),
                  SizedBox(height: 10), // Add padding here
                  TextFieldWidget(
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    controller: arc.alternativeMobileController.value,
                    hintText: 'Alternate Number',
                    width: width * 0.95,
                    borderRadius: 18,
                    height: 40,
                    borderColor: ColorConstants.aqua,
                    textColor: ColorConstants.aqua,
                  ),
                  SizedBox(height: 10), // Add padding here
                  TextFieldWidget(
                    controller: arc.emailController.value,
                    hintText: 'email',
                    width: width * 0.95,
                    height: 40,
                    borderRadius: 18,
                    borderColor: ColorConstants.aqua,
                    textColor: ColorConstants.aqua,
                  ),
                  SizedBox(height: 10), // Add padding here
                  TextFieldWidget(
                    keyboardType: TextInputType.number,
                    controller: arc.panCardController.value,
                    hintText: 'Pan Card',
                    width: width * 0.95,
                    borderRadius: 18,
                    height: 40,
                    borderColor: ColorConstants.aqua,
                    textColor: ColorConstants.aqua,
                  ),
                  SizedBox(height: 10), // Add padding here
                  TextFieldWidget(
                    keyboardType: TextInputType.number,
                    controller: arc.aadharCardController.value,
                    hintText: 'Aadhar Card',
                    width: width * 0.95,
                    borderRadius: 18,
                    height: 40,
                    borderColor: ColorConstants.aqua,
                    textColor: ColorConstants.aqua,
                  ),
                  SizedBox(height: 10), // Add padding here
                  TextFieldWidget(
                    controller: arc.addressLine1Controller.value,
                    hintText: 'Address Line 1',
                    width: width * 0.95,
                    borderRadius: 18,
                    height: 40,
                    borderColor: ColorConstants.aqua,
                    textColor: ColorConstants.aqua,
                  ),
                  SizedBox(height: 10), // Add padding here
                  TextFieldWidget(
                    controller: arc.addressLine2Controller.value,
                    hintText: 'Address Line 2',
                    width: width * 0.95,
                    borderRadius: 18,
                    height: 40,
                    borderColor: ColorConstants.aqua,
                    textColor: ColorConstants.aqua,
                  ),
                  SizedBox(height: 10), // Add padding here
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: Obx(
                      () => CountryStateCityPicker(
                          country: arc.countryController.value,
                          state: arc.stateController.value,
                          city: arc.cityController.value,
                          dialogColor: Colors.grey.shade200,
                          textFieldDecoration: InputDecoration(
                              suffixIcon:
                                  const Icon(Icons.arrow_drop_down_rounded),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ColorConstants.aqua),
                                  borderRadius: BorderRadius.circular(50)))),
                    ),
                  ),

                  SizedBox(height: 10), // Add padding here
                  TextFieldWidget(
                    keyboardType: TextInputType.number,
                    controller: arc.pincodeController.value,
                    hintText: 'Pincode',
                    width: width * 0.95,
                    height: 40,
                    borderRadius: 18,
                    borderColor: ColorConstants.aqua,
                    textColor: ColorConstants.aqua,
                  ),
                  SizedBox(height: 10), // Add padding here
                  TextFieldWidget(
                    controller: arc.usernameController.value,
                    hintText: 'Username',
                    width: width * 0.95,
                    borderRadius: 18,
                    height: 40,
                    borderColor: ColorConstants.aqua,
                    textColor: ColorConstants.aqua,
                  ),
                  SizedBox(height: 10), // Add padding here
                  TextFieldWidget(
                    controller: arc.passwordController.value,
                    hintText: 'Password',
                    width: width * 0.95,
                    borderRadius: 18,
                    height: 40,
                    borderColor: ColorConstants.aqua,
                    textColor: ColorConstants.aqua,
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PCIconButton(
                          onPressed: () {
                            resetFields();
                          },
                          text: 'Reset',
                          textColor: ColorConstants.white,
                          textSize: height * 0.022,
                          width: width * 0.3,
                          height: height * 0.05,
                          backgroundColor: ColorConstants.aqua,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        PCIconButton(
                          onPressed: () {
                            String? emailError =
                                validateEmail(arc.emailController.value.text);

                            if (isLogin == true) {
                              if (emailError != null) {
                                // Display error toast
                                Fluttertoast.showToast(
                                  msg: emailError,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              } else {
                                arc.agentRegister(
                                    zoneId, stateid, cityid, false);
                              }
                            } else {
                              if (emailError != null) {
                                // Display error toast
                                Fluttertoast.showToast(
                                  msg: emailError,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              } else {
                                arc.agentRegister(
                                    zoneId, stateid, cityid, true);
                              }
                            }
                          },
                          text: 'Submit',
                          textColor: ColorConstants.white,
                          textSize: height * 0.022,
                          width: width * 0.3,
                          height: height * 0.05,
                          backgroundColor: ColorConstants.aqua,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        if (isLogin == true)
                          PCIconButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.signin);
                            },
                            text: 'Login',
                            textColor: ColorConstants.white,
                            textSize: height * 0.022,
                            width: width * 0.3,
                            height: height * 0.05,
                            backgroundColor: ColorConstants.aqua,
                            borderRadius: BorderRadius.circular(22),
                          )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email address';
    }

    arc.emailController.value.text = '';
    return null;
  }
}

Widget _buildInfoContainer(String text, double width) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: ColorConstants.aqua, width: 2),
      borderRadius: BorderRadius.circular(18),
    ),
    margin: EdgeInsets.symmetric(horizontal: 10),
    height: 50,
    width: width * 0.95,
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        style: TextStyle(
          color: ColorConstants.aqua,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
