import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_futter_project/presentation/pages/authentication/login_page.dart';

import '../../../common/app_text_styles.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    //todo: the user logs out on app restart. Maybe write to persistence.

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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(child: CircleAvatar(radius: 50, backgroundColor: Colors.white)),
              ),

              const ListTile(title: Text('Personal Details')),
              const ListTile(title: Text('Location')),
              const ListTile(title: Text('My Items')),
              const ListTile(title: Text('Viewed Items')),
              const ListTile(title: Text('Clear Data')),
              ListTile(
                title: const Text('Log out'),
                onTap: () {
                  context.read<AuthenticationCubit>().logOut();
                  context.read<UserDataCubit>().logOutUser();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
