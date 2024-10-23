part of '../../../view/home_view.dart';

class ReminderDetailsWidget extends StatelessWidget with HomeMixin {
  final HomeViewModel viewModel;

  const ReminderDetailsWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                    viewModel.selectedPriority.value = 3;
                    Get.back();
                  },
                  child: const Text(AppText.cancel, style: TextStyle(fontSize: 16)),
                ),
                TextButton(
                  onPressed: () {
                    viewModel.dateString.value = viewModel.selectedDate.value.dateRefactoring();
                    Get.back();
                  },
                  child: Text(AppText.add, style: AppTextStyle.blackBold16),
                ),
              ],
            ),
            CustomListTile(
              isBorder: false,
              containerColor: AppColor.red,
              icon: CupertinoIcons.calendar,
              contentText: getContentText(viewModel),
              titleText: AppText.date,
              onChanged: viewModel.datePickerToogle,
              value: viewModel.isDatePicker.value,
            ),
            const Divider(
              color: AppColor.grey,
              thickness: 0.5,
              indent: 65,
            ),
            viewModel.isDatePicker.value
                ? AdoptiveCalendar(
                    initialDate: DateTime.now(),
                    datePickerOnly: true,
                    backgroundColor: AppColor.transparent,
                    selectedColor: AppColor.blue,
                    disablePastDates: true,
                    onSelection: (selectedDate) {
                      if (selectedDate!.isAfter(DateTime.now()) ||
                          selectedDate.isAtSameMomentAs(DateTime.now())) {
                        viewModel.selectedDate.value = selectedDate;
                      }
                    },
                  )
                : const SizedBox.shrink(),
            CustomListTile(
              isBorder: false,
              containerColor: AppColor.blue,
              icon: CupertinoIcons.clock_fill,
              titleText: AppText.time,
              onChanged: (value) {
                viewModel.timePickerToogle(value);
                if (value) {
                  viewModel.selectTime(context);
                }
              },
              value: viewModel.isTimePicker.value,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Obx(
                () => Column(
                  children: [
                    CustomListTile(
                      containerColor: AppColor.red,
                      isBorder: true,
                      reminderText: getSelectedPriorityText(viewModel),
                      titleText: AppText.priority,
                      onTap: () {
                        showCustomPriorityPicker(
                          context: context,
                          pickerList: AppText.priorityList,
                          initialValue: 0,
                          onSelectedItemChanged: (value) {
                            viewModel.selectedPriority.value = value;
                            viewModel.isSelectedPriority.value = true;
                          },
                        );
                      },
                      icon: CupertinoIcons.right_chevron,
                    ).pSymmetric(vertical: 15),
                    CustomListTile(
                      isBorder: true,
                      reminderText: viewModel.isSelectedFile.value ? AppText.oneAttachment : "None",
                      titleText: AppText.attach,
                      onTap: () async {
                        await viewModel.pickImage(ImageSource.gallery);
                        viewModel.isSelectedFile.value = true;
                      },
                      icon: CupertinoIcons.paperclip,
                      iconSize: 18,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
