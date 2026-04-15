import 'package:flutter/material.dart';
import 'package:test_flutter_project/presentation/pages/details/widgets/owner_widget.usecase.dart';
import 'package:test_flutter_project/presentation/pages/search/widgets/results_widget.usecase.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(const WidgetBookApp());
}

class WidgetBookApp extends StatelessWidget {
  const WidgetBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: [
        WidgetbookFolder(
          name: 'Pages',
          children: [
            WidgetbookFolder(
              name: 'Search',
              children: [
                WidgetbookComponent(
                  name: 'ResultsWidget',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Default',
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
                  name: 'OwnerWidget',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Default',
                      builder: (context) => buildOwnerWidgetUseCase(context),
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
