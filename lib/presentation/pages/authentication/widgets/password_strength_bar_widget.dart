import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_state.dart';

import '../../../../common/app_dimensions.dart';

class PasswordStrengthBarWidget extends StatelessWidget {
  const PasswordStrengthBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.normalM),
      child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          final stagesAvailable = 4;

          return Column(
            spacing: AppDimensions.minorXS,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: List.generate(
                  stagesAvailable,
                  (index) => Expanded(
                    child: Container(
                      height: 5,
                      decoration: BoxDecoration(
                        color: index < state.passwordValidationStage ? Colors.green : Colors.grey,
                        borderRadius: BorderRadius.circular(AppDimensions.minorXS),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: AppDimensions.minorXS),
                    ),
                  ),
                ),
              ),

              Opacity(
                opacity: state.passwordStrengthHintText != null ? 1.0 : 0.0,
                child: Text(state.passwordStrengthHintText ?? ''),
              ),
            ],
          );
        },
      ),
    );
  }
}
