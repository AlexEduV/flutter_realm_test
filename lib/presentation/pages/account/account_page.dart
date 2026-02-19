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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: CircleAvatar(radius: 50, backgroundColor: AppColors.placeholderColor),
                ),
              ),

              const ListTile(title: Text('Personal Details'), leading: Icon(Icons.person)),
              //todo: in the personal details -> Change password
              const ListTile(title: Text('Location'), leading: Icon(Icons.location_pin)),
              const ListTile(title: Text('My Items'), leading: Icon(Icons.checklist)),
              const ListTile(title: Text('Viewed Items'), leading: Icon(Icons.remove_red_eye)),
              const ListTile(title: Text('Clear Data'), leading: Icon(Icons.delete)),
              ListTile(
                title: const Text('Log out'),
                leading: const Icon(Icons.exit_to_app_sharp),
                onTap: () async {
                  await context.read<AuthenticationCubit>().logOut();

                  if (!context.mounted) return;

                  context.read<UserDataCubit>().logOutUser();
                },
              ),
              const Spacer(),
              Center(
                child: ListTile(title: const Text('Delete Account'), onTap: () {}),
              ),
            ],
          ),
        );
      },
    );
  }
}
