import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_state.dart';

import '../../../../common/app_dimensions.dart';

class PasswordStrengthBarWidget extends StatelessWidget {
  const PasswordStrengthBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final stagesAvailable = 5;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.normalM),
      child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedStageBar(
                stagesAvailable: stagesAvailable,
                currentStage: state.passwordValidationStage,
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: state.passwordStrengthHintText != null ? 1.0 : 0.0,
                child: Text('${state.passwordStrengthHintText ?? ''}\n', maxLines: 2),
              ),
            ],
          );
        },
      ),
    );
  }
}

class AnimatedStageBar extends StatefulWidget {
  final int stagesAvailable;
  final int currentStage;

  const AnimatedStageBar({required this.stagesAvailable, required this.currentStage, super.key});

  @override
  State<AnimatedStageBar> createState() => _AnimatedStageBarState();
}

class _AnimatedStageBarState extends State<AnimatedStageBar> {
  late List<bool> _activeStages;

  @override
  void initState() {
    super.initState();
    _activeStages = List.generate(widget.stagesAvailable, (i) => i < widget.currentStage);
  }

  @override
  void didUpdateWidget(covariant AnimatedStageBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentStage != oldWidget.currentStage) {
      _animateStages(oldWidget.currentStage, widget.currentStage);
    }
  }

  Future<void> _animateStages(int from, int to) async {
    final animationDuration = const Duration(milliseconds: 120);

    if (to > from) {
      // Animate up: left to right
      for (int i = from; i < to; i++) {
        setState(() => _activeStages[i] = true);
        await Future.delayed(animationDuration);
      }
    } else if (to < from) {
      // Animate down: left to right (rightmost first)
      for (int i = 0; i < from - to; i++) {
        setState(() => _activeStages[from - 1 - i] = false);
        await Future.delayed(animationDuration);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        widget.stagesAvailable,
        (index) => Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            height: 5,
            decoration: BoxDecoration(
              color: _activeStages[index] ? Colors.green : Colors.grey,
              borderRadius: BorderRadius.circular(AppDimensions.minorXS),
            ),
            margin: const EdgeInsets.symmetric(horizontal: AppDimensions.minorXS),
          ),
        ),
      ),
    );
  }
}
