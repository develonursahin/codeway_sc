part of '../../../view/home_view.dart';

Future<void> showCreateReminderBottomSheet(BuildContext context, HomeViewModel viewModel,
    {ReminderModel? reminderModel}) {
  if (reminderModel != null) {
    viewModel.fillData(reminderModel);
  } else {
    viewModel.clearForm();
  }

  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColor.primary,
    builder: (BuildContext context) {
      return PopScope(
        canPop: true,
        onPopInvoked: (didPop) => viewModel.clearForm(),
        child: Container(
          height: Get.height * 0.8,
          decoration: BoxDecoration(borderRadius: context.borderVerticalTop10Radius),
          padding: context.normalPadding,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        viewModel.clearForm();
                        Get.back();
                      },
                      child: const Text(AppText.cancel, style: TextStyle(fontSize: 16)),
                    ),
                    Text(
                      reminderModel != null ? AppText.editReminder : AppText.newReminder,
                      style: AppTextStyle.blackBold18,
                    ),
                    TextButton(
                      onPressed: () async {
                        if (!viewModel.formKey.currentState!.validate()) {
                          return;
                        }
                        showLoadingDialog(context);
                        try {
                          if (reminderModel != null) {
                            await viewModel.updateReminder(reminderModel);
                          } else {
                            await viewModel.createReminder();
                          }
                          if (Get.isDialogOpen == true) {
                            Get.back();
                          }
                        } catch (e) {
                          showErrorSnackbar(message: AppText.errorSaveReminder);
                        } finally {
                          viewModel.clearForm();
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        reminderModel != null ? AppText.update : AppText.add,
                        style: AppTextStyle.blackBold16,
                      ),
                    ),
                  ],
                ),
                Form(
                  key: viewModel.formKey,
                  child: Column(
                    children: [
                      ReminderTextField(
                        controller: viewModel.titleController.value,
                        node: viewModel.titleNode.value,
                        hintStyle: AppTextStyle.blackBold16,
                        enabled: true,
                        hintText: AppText.title,
                        maxLines: 1,
                        minLines: 1,
                        validator: (value) {
                          return value == null || value.isEmpty ? AppText.pleaseEnterATitle : null;
                        },
                      ),
                      const Divider(color: AppColor.grey, thickness: 0.5),
                      ReminderTextField(
                        controller: viewModel.contentController.value,
                        node: viewModel.contentNode.value,
                        hintText: AppText.notes,
                        minLines: 5,
                        maxLines: 10,
                        validator: (value) {
                          return value == null || value.isEmpty ? AppText.pleaseEnterANote : null;
                        },
                      ),
                    ],
                  ),
                ).pAll(context.heighVal),
                Obx(
                  () => CustomListTile(
                    isBorder: true,
                    titleText: AppText.details,
                    icon: Icons.arrow_forward_ios_outlined,
                    onTap: () {
                      showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: AppColor.primary,
                        builder: (BuildContext context) {
                          return Container(
                            padding: context.normalPadding,
                            height: Get.height * 0.9,
                            decoration:
                                BoxDecoration(borderRadius: context.borderVerticalTop10Radius),
                            child: ReminderDetailsWidget(viewModel: viewModel),
                          );
                        },
                      );
                    },
                    contentText: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          !viewModel.isDatePicker.value
                              ? AppText.today
                              : viewModel.dateString.value,
                          style: const TextStyle(
                            color: AppColor.greyDark,
                            fontSize: 14,
                          ),
                        ),
                        viewModel.isTimePicker.value
                            ? Text(
                                viewModel.selectedTime.value.toTimeOfDay(),
                                style: const TextStyle(
                                  color: AppColor.greyDark,
                                  fontSize: 14,
                                ),
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
