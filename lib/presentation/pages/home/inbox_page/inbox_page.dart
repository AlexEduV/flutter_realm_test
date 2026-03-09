import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/presentation/bloc/home/inbox_page/inbox_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/inbox_page/inbox_page_state.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_futter_project/presentation/pages/home/inbox_page/widgets/inbox_list_item.dart';
import 'package:test_futter_project/presentation/pages/search/widgets/empty_search_placeholder_widget.dart';
import 'package:test_futter_project/utils/l10n.dart';

import '../../../../common/app_text_styles.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: Text(AppLocalisations.of(context).inboxPageTitle, style: AppTextStyles.zonaPro20),
        centerTitle: true,
      ),
      body: BlocBuilder<UserDataCubit, UserDataState>(
        builder: (context, state) {
          if (!state.isUserAuthenticated) {
            return EmptyResultsPlaceholderWidget(
              text: AppLocalisations.of(context).inboxPageLoggedOutText,
            );
          }

          return BlocBuilder<InboxPageCubit, InboxPageState>(
            builder: (context, state) {
              final items = state.messages;

              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.messages.isEmpty) {
                return EmptyResultsPlaceholderWidget(
                  text: AppLocalisations.of(context).inboxPageEmptyText,
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.only(top: AppDimensions.normalL),
                itemBuilder: (context, index) {
                  return InboxListItem(message: items[index]);
                },
                itemCount: items.length,
              );
            },
          );
        },
      ),
    );
  }
}
