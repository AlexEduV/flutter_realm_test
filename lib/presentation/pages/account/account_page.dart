import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_futter_project/presentation/pages/authentication/login_page.dart';

import '../../../common/app_text_styles.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, state) {
        if (!state.isUserAuthenticated) {
          return const LoginPage();
        }

        return Scaffold(
          backgroundColor: AppColors.scaffoldColor,
          appBar: AppBar(
            title: const Text('My Account', style: AppTextStyles.zonaPro20),
            centerTitle: true,
          ),
          body: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(child: CircleAvatar(radius: 50, backgroundColor: Colors.white)),
              ),

              ListTile(title: Text('Personal Details')),
              ListTile(title: Text('Location')),
              ListTile(title: Text('Clear History')),
              ListTile(title: Text('Log out')),
            ],
          ),
        );
      },
    );
  }
}
