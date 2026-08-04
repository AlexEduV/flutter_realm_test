import 'package:flutter/material.dart';
import 'package:widget_catalog/search/widgets/results_widget.usecase.dart';
import 'package:widget_catalog/search/widgets/search_filter_button.usecase.dart';
import 'package:widget_catalog/widgets/animated_favorite_icon.usecase.dart';
import 'package:widget_catalog/widgets/announcement_item/announcement_list_item.usecase.dart';
import 'package:widget_catalog/widgets/dialogs/acknowledgement_dialog.usecase.dart';
import 'package:widget_catalog/widgets/dialogs/color_picker_dialog.usecase.dart';
import 'package:widget_catalog/widgets/dialogs/confirmation_dialog.usecase.dart';
import 'package:widgetbook/widgetbook.dart';

import 'account/sub_pages/location_settings/widgets/footer_text.usecase.dart';
import 'account/widgets/account_item.usecase.dart';
import 'account/widgets/account_item_separated.usecase.dart';
import 'authentication/widgets/auth_error_widget.usecase.dart';
import 'authentication/widgets/splash_button.usecase.dart';
import 'details/widgets/owner_widget.usecase.dart';
import 'details/widgets/vehicle_specs_widget.usecase.dart';
import 'home/widgets/car_list_item.usecase.dart';
import 'messages/widgets/chat_input_bar/chat_input_bar.usecase.dart';
import 'messages/widgets/date_divider.usecase.dart';
import 'messages/widgets/message_item/message_item.usecase.dart';

void main() {
  runApp(const WidgetBookApp());
}

class WidgetBookApp extends StatelessWidget {
  const WidgetBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    const defaultUseCaseName = 'Default';

    return Widgetbook.material(
      initialRoute: '/?path=general/animated-favorite-icon/default',
      directories: [
        WidgetbookCategory(
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
            WidgetbookComponent(
              name: 'Car list item',
              useCases: [
                WidgetbookUseCase(
                  name: defaultUseCaseName,
                  builder: (context) => buildCarListItemUseCase(context),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Announcement item',
              useCases: [
                WidgetbookUseCase(
                  name: defaultUseCaseName,
                  builder: (context) => buildAnnouncementListItemUseCase(context),
                ),
              ],
            ),
          ],
        ),

        WidgetbookCategory(
          name: 'Dialogs',
          children: [
            WidgetbookComponent(
              name: 'Confirmation dialog',
              useCases: [
                WidgetbookUseCase(
                  name: defaultUseCaseName,
                  builder: (context) => buildConfirmationDialogUseCase(context),
                ),
              ],
            ),

            WidgetbookComponent(
              name: 'Acknowledgement dialog',
              useCases: [
                WidgetbookUseCase(
                  name: defaultUseCaseName,
                  builder: (context) => buildAcknowledgementDialogUseCase(context),
                ),
              ],
            ),

            WidgetbookComponent(
              name: 'Color Picker dialog',
              useCases: [
                WidgetbookUseCase(
                  name: defaultUseCaseName,
                  builder: (context) => buildColorPickerDialogUseCase(context),
                ),
              ],
            ),
          ],
        ),

        WidgetbookCategory(
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

            WidgetbookComponent(
              name: 'Search filter button',
              useCases: [
                WidgetbookUseCase(
                  name: defaultUseCaseName,
                  builder: (context) => buildSearchFilterButtonUseCase(context),
                ),
              ],
            ),
          ],
        ),

        WidgetbookCategory(
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

            WidgetbookComponent(
              name: 'Vehicle specs widget',
              useCases: [
                WidgetbookUseCase(
                  name: defaultUseCaseName,
                  builder: (context) {
                    final isExpanded = context.knobs.boolean(
                      label: 'Is expanded',
                      initialValue: true,
                    );

                    return buildVehicleSpecsWidgetUseCase(context, isExpanded: isExpanded);
                  },
                ),
              ],
            ),
          ],
        ),

        WidgetbookCategory(
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

            WidgetbookComponent(
              name: 'Account item separated',
              useCases: [
                WidgetbookUseCase(
                  name: defaultUseCaseName,
                  builder: (context) => buildAccountItemSeparatedUseCase(context),
                ),
              ],
            ),

            WidgetbookComponent(
              name: 'Footer text',
              useCases: [
                WidgetbookUseCase(
                  name: defaultUseCaseName,
                  builder: (context) => buildFooterTextUseCase(context),
                ),
              ],
            ),
          ],
        ),

        WidgetbookCategory(
          name: 'Authentication',
          children: [
            WidgetbookComponent(
              name: 'Splash button',
              useCases: [
                WidgetbookUseCase(
                  name: defaultUseCaseName,
                  builder: (context) => buildSplashButtonUseCase(context),
                ),
              ],
            ),

            WidgetbookComponent(
              name: 'Auth error widget',
              useCases: [
                WidgetbookUseCase(
                  name: defaultUseCaseName,
                  builder: (context) => buildAuthErrorWidgetUseCase(context),
                ),
              ],
            ),
          ],
        ),

        WidgetbookCategory(
          name: 'Messages',
          children: [
            WidgetbookComponent(
              name: 'Chat input bar',
              useCases: [
                WidgetbookUseCase(
                  name: defaultUseCaseName,
                  builder: (context) => buildChatInputBarUseCase(context),
                ),
              ],
            ),

            WidgetbookComponent(
              name: 'Message item',
              useCases: [
                WidgetbookUseCase(
                  name: defaultUseCaseName,
                  builder: (context) => buildMessageItemUseCase(context),
                ),
              ],
            ),

            WidgetbookComponent(
              name: 'Date divider',
              useCases: [
                WidgetbookUseCase(
                  name: defaultUseCaseName,
                  builder: (context) => buildMessageDateDividerUseCase(context),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
