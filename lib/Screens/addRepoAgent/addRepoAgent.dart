import 'package:flutter/material.dart';

import '../../core/constants/color_constants.dart';

class AddRepoAgent extends StatefulWidget {
  const AddRepoAgent({super.key});

  @override
  State<AddRepoAgent> createState() => _AddRepoAgentState();
}

class _AddRepoAgentState extends State<AddRepoAgent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        title: Text('Add Repo Agent'),
        titleTextStyle: TextStyle(
          color: ColorConstants.white,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: ColorConstants.aqua,
        automaticallyImplyLeading: false,
      ),
    );
  }
}
