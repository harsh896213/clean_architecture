import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pva/core/extension/context_ext.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../bloc/edit_profile_bloc.dart';
import '../widget/mini_profile_information_card.dart';
import '../widget/profile_edit_widget.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text(
          'Progress Tracker',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        titleColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            MiniProfileCard(
              imageUrl: 'assets/profile_image.png',
              name: 'Simon Riley',
              patientId: '89373652',
              gender: 'Male',
              age: 52,
            ),
            const Divider(height: 1, thickness: 1),
            Expanded(
              child: SingleChildScrollView(
                child: BlocProvider(
                  create: (context) => EditProfileBloc(),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: context.isPortrait ? MediaQuery.of(context).size.height * 0.04 : 0
                      ),
                      constraints: BoxConstraints(maxWidth: 500),
                      child: ProfileEditWidget(),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
