import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/enums/message_status.dart';
import 'package:test_futter_project/domain/models/message_model.dart';
import 'package:test_futter_project/presentation/pages/home/inbox_page/widgets/inbox_list_item.dart';

import '../../../../common/app_text_styles.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  //todo: get from the service
  final List<MessageModel> items = [
    MessageModel(
      'James Morrison',
      MessageStatus.unknown,
      'Some Message here.',
      DateTime.now().subtract(const Duration(hours: 4)),
    ),
    MessageModel(
      'Jennifer Williams',
      MessageStatus.sent,
      'Some Message here.',
      DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(title: const Text('Inbox', style: AppTextStyles.zonaPro20), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: AppDimensions.normalL),
        itemBuilder: (context, index) {
          return InboxListItem(message: items[index]);
        },
        itemCount: items.length,
      ),
    );
  }
}
