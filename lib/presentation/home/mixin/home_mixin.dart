import 'package:plantist/core/enum/loading_status.dart';
import 'package:plantist/core/extension/string/string_extension.dart';
import 'package:plantist/presentation/home/imports/home_imports.dart';

mixin HomeMixin {
  Map<String, List<ReminderModel>> groupRemindersByDate(List<ReminderModel> reminders) {
    Map<String, List<ReminderModel>> groupedReminders = {};
    DateTime now = DateTime.now();

    for (var reminder in reminders) {
      DateTime reminderDate =
          DateTime(reminder.date!.year, reminder.date!.month, reminder.date!.day);
      String formattedDate;

      if (reminderDate.isAtSameMomentAs(DateTime(now.year, now.month, now.day))) {
        formattedDate = AppText.today;
      } else if (reminderDate.isAtSameMomentAs(DateTime(now.year, now.month, now.day + 1))) {
        formattedDate = AppText.tomorrow;
      } else {
        formattedDate = reminderDate.toFormattedString(isHour: false);
      }

      if (groupedReminders[formattedDate] == null) {
        groupedReminders[formattedDate] = [];
      }
      groupedReminders[formattedDate]!.add(reminder);
    }

    groupedReminders.forEach((key, reminders) {
      reminders.sort((a, b) => a.priority!.compareTo(b.priority!));
    });

    return groupedReminders;
  }

  List<ReminderModel> getResultReminders(HomeViewModel viewModel) {
    return viewModel.hasSearched.value || viewModel.hasFiltered.value
        ? viewModel.filteredReminders
        : viewModel.reminders;
  }

  bool isLoading(HomeViewModel viewModel) {
    return viewModel.loadingStatus.value == LoadingStatus.loading;
  }

  //* reminders_details_widget
  String getSelectedPriorityText(HomeViewModel viewModel) {
    if (!viewModel.isSelectedPriority.value) {
      return "None";
    }
    int selectedPriority = viewModel.selectedPriority.value;
    if (selectedPriority >= 0 && selectedPriority < AppText.priorityList.length) {
      return AppText.priorityList[selectedPriority];
    } else {
      return "None";
    }
  }

  //* reminders_details_widget
  Widget? getContentText(HomeViewModel viewModel) {
    if (!viewModel.isDatePicker.value) {
      return null;
    }
    String dateText = viewModel.isSameDate(date: DateTime.now())
        ? AppText.today
        : viewModel.selectedDate.value.dateRefactoring();
    return Text(dateText, style: AppTextStyle.greyDarkRegular14);
  }
}
