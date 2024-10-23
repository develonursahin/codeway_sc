part of '../../../view/home_view.dart';

class ReminderDayGroupSectionWidget extends StatelessWidget {
  final String dateTitle;
  final List<ReminderModel> reminders;
  final HomeViewModel viewModel;
  const ReminderDayGroupSectionWidget({
    super.key,
    required this.dateTitle,
    required this.reminders,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(dateTitle, style: AppTextStyle.greyDarkRegular16).pOnly(left: context.pageHorizontal),
        ...reminders.map(
          (reminder) => ReminderItem(
            reminder: reminder,
            viewModel: viewModel,
          ),
        ),
      ],
    );
  }
}
