part of '../../../view/home_view.dart';

class ReminderListTileWidget extends StatelessWidget {
  final ReminderModel reminder;
  final VoidCallback? onTap;

  const ReminderListTileWidget({
    super.key,
    required this.reminder,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      
      onTap: onTap,
      leading: PriortiyCircleWidget(
        priorityId: reminder.priority!,
      ),
      title: Text(
        reminder.title ?? "",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            reminder.content ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.greyDarkRegular16,
          ),
          reminder.file != null
              ? Row(
                  children: [
                    Transform.rotate(
                      angle: 5.5,
                      child: const Icon(
                        Icons.attachment_outlined,
                        color: AppColor.greyDark,
                      ),
                    ).pOnly(right: 5),
                    Text(
                      AppText.oneAttachment,
                      style: AppTextStyle.greyDarkRegular16,
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            reminder.date!.toFormattedString(isHour: false),
            style: AppTextStyle.greyDarkRegular16,
          ),
          reminder.time != null
              ? Text(
                  reminder.time!,
                  style: AppTextStyle.greyDarkRegular16
                      .copyWith(color: reminder.priority == 0 ? AppColor.red : AppColor.greyDark),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
