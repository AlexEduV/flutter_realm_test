import 'package:flutter/material.dart';
import 'package:test_flutter_project/presentation/pages/account/widgets/account_item.usecase.dart';
import 'package:test_flutter_project/presentation/pages/details/widgets/owner_widget.usecase.dart';
import 'package:test_flutter_project/presentation/pages/search/widgets/results_widget.usecase.dart';
import 'package:test_flutter_project/presentation/widgets/animated_favorite_icon.usecase.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(const WidgetBookApp());
}

class WidgetBookApp extends StatelessWidget {
  const WidgetBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    const defaultUseCaseName = 'Default';

    return Widgetbook.material(
      directories: [
        WidgetbookFolder(
          name: 'General',
          children: [
            WidgetbookComponent(
              name: 'Animated favorite icon',
              useCases: [
                WidgetbookUseCase(
                  name: defaultUseCaseName,
                  builder: (context) => buildAnimatedFavoriteIconUseCase(context),
                ),
              ],
            ),
          ],
        ),

        WidgetbookFolder(
          name: 'Pages',
          children: [
            WidgetbookFolder(
              name: 'Search',
              children: [
                WidgetbookComponent(
                  name: 'Results widget',
                  useCases: [
                    WidgetbookUseCase(
                      name: defaultUseCaseName,
                      builder: (context) => buildResultsWidgetUseCase(context),
                    ),
                  ],
                ),
              ],
            ),

            WidgetbookFolder(
              name: 'Details',
              children: [
                WidgetbookComponent(
                  name: 'Owner widget',
                  useCases: [
                    WidgetbookUseCase(
                      name: defaultUseCaseName,
                      builder: (context) => buildOwnerWidgetUseCase(context),
                    ),
                  ],
                ),
              ],
            ),

            WidgetbookFolder(
              name: 'Account',
              children: [
                WidgetbookComponent(
                  name: 'Account item',
                  useCases: [
                    WidgetbookUseCase(
                      name: defaultUseCaseName,
                      builder: (context) => buildAccountItemUseCase(context),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
