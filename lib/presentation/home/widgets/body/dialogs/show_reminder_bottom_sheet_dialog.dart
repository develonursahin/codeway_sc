part of '../../../view/home_view.dart';

showReminderBottomSheet(
        {required ReminderModel reminder, required BuildContext context}) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColor.primary,
      builder: (BuildContext context) {
        return Container(
          height: context.mediaQuerySize.height * 0.8,
          decoration:
              BoxDecoration(borderRadius: context.borderVerticalTop8Radius),
          padding: context.heighPadding,
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      AppText.close,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Column(
                  children: [
                    ReminderTextField(
                      enabled: false,
                      hintText: reminder.title!,
                      maxLines: 1,
                      minLines: 1,
                      color: AppColor.secondary,
                    ),
                    const Divider(color: AppColor.grey, thickness: 0.5),
                    ReminderTextField(
                      enabled: false,
                      hintText: reminder.content!,
                      maxLines: 5,
                      minLines: 5,
                      color: AppColor.grey,
                    ),
                  ],
                ).pSymmetric(horizontal: context.pageHorizontal),
                reminder.file != null
                    ? Center(
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(reminder.file!),
                                fit: BoxFit.cover),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ])),
        );
      },
    );
