part of '../../../view/home_view.dart';

class ReminderItem extends StatelessWidget {
  final ReminderModel reminder;
  final HomeViewModel viewModel;
  const ReminderItem({
    super.key,
    required this.reminder,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slidable(
          key: Key(reminder.id.toString()),
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: (context) => showCreateReminderBottomSheet(
                    context, viewModel,
                    reminderModel: reminder),
                backgroundColor: AppColor.grey,
                foregroundColor: AppColor.white,
                icon: CupertinoIcons.pen,
                autoClose: true,
                label: AppText.edit,
              ),
              SlidableAction(
                onPressed: (context) async =>
                    await viewModel.deleteReminder(reminder),
                backgroundColor: AppColor.redHot,
                foregroundColor: AppColor.white,
                icon: CupertinoIcons.delete,
                autoClose: true,
                label: AppText.delete,
              ),
            ],
          ),
          child: ReminderListTileWidget(
            reminder: reminder,
            onTap: () =>
                showReminderBottomSheet(reminder: reminder, context: context),
          ),
        ),
      ],
    );
  }
}
