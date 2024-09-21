import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinayak/Screens/add%20vehicle/controller/addvehicle_controller.dart';
import 'package:vinayak/core/global_controller/user_controller.dart';

import '../../core/constants/color_constants.dart';
import '../../widget/pciconBtn.dart';

class Addvehicle extends StatefulWidget {
  const Addvehicle({super.key});

  @override
  State<Addvehicle> createState() => _AddvehicleState();
}

class _AddvehicleState extends State<Addvehicle> {
  AddvehicleController avc = Get.put(AddvehicleController());
  UserController uc = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    avc.confirmByCont.value.text = uc.userDetails['staf']['_id'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Vehicle',
          style: TextStyle(
              fontWeight: FontWeight.w500, color: ColorConstants.aqua),
        ),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: Get.width * 0.9,
                height: 50,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: ColorConstants.aqua, width: 2),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Bank Name', border: InputBorder.none),
                    controller: avc.bankCont.value,
                  ),
                )),
            Container(
                width: Get.width * 0.9,
                height: 50,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: ColorConstants.aqua, width: 2),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Registration Number',
                        border: InputBorder.none),
                    controller: avc.regNoCont.value,
                  ),
                )),
            Container(
                width: Get.width * 0.9,
                height: 50,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: ColorConstants.aqua, width: 2),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Customer Name', border: InputBorder.none),
                    controller: avc.customerNameCont.value,
                  ),
                )),
            Container(
                width: Get.width * 0.9,
                height: 50,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: ColorConstants.aqua, width: 2),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Make', border: InputBorder.none),
                    controller: avc.makeCont.value,
                  ),
                )),
            Container(
                width: Get.width * 0.9,
                height: 50,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: ColorConstants.aqua, width: 2),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Mobile Number', border: InputBorder.none),
                    controller: avc.mobileCont.value,
                  ),
                )),
            const SizedBox(
              height: 50,
            ),
            PCIconButton(
              onPressed: () {
                avc.addVehicle(context);
              },
              text: 'Save',
              width: Get.width * 0.9,
              height: 50,
              textColor: Colors.white,
              backgroundColor: ColorConstants.aqua,
            ),
          ],
        ),
      )),
    );
  }
}
