import 'package:plantist/core/widgets/progressIndicator/custom_circular_progress_indicator_widget.dart';
import 'package:plantist/presentation/home/imports/home_imports.dart';
import 'package:plantist/presentation/home/view/home_view.dart';

class ReminderBodyContent extends StatelessWidget with HomeMixin {
  final HomeViewModel viewModel;

  const ReminderBodyContent({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (isLoading(viewModel)) {
        return const CustomCircularProgressIndicator();
      }
      var resultReminders = getResultReminders(viewModel);
      if (viewModel.hasSearched.value && resultReminders.isEmpty) {
        return const EmptyStateTextWidget(message: AppText.noRemindersForSearch);
      }
      if (viewModel.hasFiltered.value && resultReminders.isEmpty) {
        return const EmptyStateTextWidget(message: AppText.noRemindersWithSelectedFilters);
      }
      if (viewModel.reminders.isEmpty) {
        return const EmptyStateTextWidget(message: AppText.noRemindersAddedYet);
      }
      var groupedReminders = groupRemindersByDate(resultReminders);
      return RefreshIndicator(
        color: AppColor.secondary,
        onRefresh: () => viewModel.fetchReminders(),
        child: ListView.separated(
          padding: EdgeInsets.only(top: context.pageHorizontal, bottom: 140),
          itemCount: groupedReminders.length,
          itemBuilder: (context, index) {
            String dateTitle = groupedReminders.keys.elementAt(index);
            List<ReminderModel> reminders = groupedReminders[dateTitle]!;
            return ReminderDayGroupSectionWidget(
              dateTitle: dateTitle,
              reminders: reminders,
              viewModel: viewModel,
            );
          },
          separatorBuilder: (BuildContext context, int index) => Divider(
            indent: Get.width * 0.13,
            color: AppColor.grey,
            thickness: 0.5,
          ),
        ),
      );
    });
  }
}

