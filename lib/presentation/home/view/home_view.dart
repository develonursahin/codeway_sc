import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:plantist/core/extension/string/string_extension.dart';
import 'package:plantist/core/extension/widget/widget_extension.dart';
import 'package:plantist/presentation/home/imports/home_imports.dart';
import 'package:plantist/presentation/home/widgets/body/reminder_body_content_widget.dart';

part '../widgets/body/reminder/reminder_day_group_section_widget.dart';
part '../widgets/body/reminder/reminder_item.dart';
part '../widgets/appBar/home_app_bar_widget.dart';
part '../../../core/widgets/text/empty_state_text_widget.dart';
part '../widgets/body/dialogs/show_create_reminder_bottomsheet_dialog_widget.dart';
part '../widgets/body/dialogs/reminders_details_widget.dart';
part '../widgets/body/dialogs/show_reminder_bottom_sheet_dialog.dart';
part '../widgets/body/reminder/reminder_list_tile_widget.dart';
part '../widgets/body/priority/priority_circle_widget.dart';
part '../widgets/body/priority/custom_priority_picker_widget.dart';

class HomeView extends StatelessWidget with HomeMixin {
  final HomeViewModel viewModel = Get.put(HomeViewModel());

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(viewModel: viewModel),
      body: ReminderBodyContent(viewModel: viewModel),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: CustomElevatedButton(
        onPressed: () async {
          showCreateReminderBottomSheet(context, viewModel);
        },
        title: AppText.newReminder,
        icon: const Icon(CupertinoIcons.add),
      ),
    );
  }
}
