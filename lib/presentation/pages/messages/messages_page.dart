import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/usecases/owners/get_owner_by_id_use_case.dart';
import 'package:test_futter_project/presentation/widgets/avatar_widget.dart';

import '../../../common/app_text_styles.dart';

class MessagesPage extends StatefulWidget {
  final String ownerId;

  const MessagesPage({required this.ownerId, super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final messageInputTextController = TextEditingController();
  final messageInputFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final owner = serviceLocator<GetOwnerByIdUseCase>().call(widget.ownerId);
    final textFieldBorderRadius = BorderRadius.circular(AppDimensions.normalM);

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: Text(owner.name, style: AppTextStyles.zonaPro20),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppDimensions.normalS),
            child: AvatarWidget(imageSrc: owner.imageSrc, size: AppDimensions.appBarIconSize * 1.5),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: AppDimensions.majorM,
            left: AppDimensions.minorL,
            right: AppDimensions.minorL,
            child: Row(
              spacing: AppDimensions.minorL,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.attach_file),
                  style: const ButtonStyle(
                    iconSize: WidgetStatePropertyAll(AppDimensions.bottomMessageBarIconSize),
                    foregroundColor: WidgetStatePropertyAll(AppColors.headerColor),
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    focusNode: messageInputFocusNode,
                    controller: messageInputTextController,
                    decoration: InputDecoration(
                      hintText: 'Message',
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: AppDimensions.normalM,
                        horizontal: AppDimensions.normalS,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: textFieldBorderRadius,
                        borderSide: const BorderSide(color: AppColors.accentColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: textFieldBorderRadius,
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: textFieldBorderRadius,
                        borderSide: const BorderSide(
                          color: AppColors.accentColor,
                          width: AppDimensions.minorXS,
                        ),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      errorBorder: OutlineInputBorder(
                        borderRadius: textFieldBorderRadius,
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                    ),
                    style: AppTextStyles.zonaPro16,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.send),
                  style: const ButtonStyle(
                    iconSize: WidgetStatePropertyAll(AppDimensions.bottomMessageBarIconSize),
                    foregroundColor: WidgetStatePropertyAll(AppColors.headerColor),
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
