import 'package:plantist/presentation/home/imports/home_view_model_imports.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  final AuthRepository _authRepository = AuthRepositoryImpl();
  final ReminderRepository _reminderRepository = ReminderRepositoryImpl();

  // Common UI elements
  final Rx<TextEditingController> searchController = TextEditingController().obs;
  final Rx<FocusNode> searchNode = FocusNode().obs;
  final Rx<TextEditingController> titleController = TextEditingController().obs;
  final Rx<TextEditingController> contentController = TextEditingController().obs;
  final Rx<FocusNode> titleNode = FocusNode().obs;
  final Rx<FocusNode> contentNode = FocusNode().obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Status variables
  final Rx<LoadingStatus> loadingStatus = LoadingStatus.initial.obs;
  final Rx<LoadingStatus> createStatus = LoadingStatus.initial.obs;
  final Rx<LoadingStatus> deleteStatus = LoadingStatus.initial.obs;
  final Rx<LoadingStatus> updateStatus = LoadingStatus.initial.obs;

  // Search and filtering
  final RxBool isOpenSearch = false.obs;
  final RxBool hasSearched = false.obs;
  final RxBool hasFiltered = false.obs;
  final RxSet<int> selectedPriorities = <int>{}.obs;
  final RxList<ReminderModel> reminders = RxList.empty();
  final RxList<ReminderModel> filteredReminders = RxList<ReminderModel>.empty();

  // Date, time, and priority
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;
  final RxInt selectedPriority = 3.obs;
  final RxBool isSelectedPriority = false.obs;
  final RxBool isSelectedFile = false.obs;
  final RxBool isDatePicker = false.obs;
  final RxBool isTimePicker = false.obs;
  final RxString dateString = "".obs;
  final Rx<File?> file = Rx<File?>(null);

  // Constants
  final List<Map<String, dynamic>> priorityOptions = [
    {'label': 'High', 'value': 0, 'color': AppColor.red},
    {'label': 'Medium', 'value': 1, 'color': AppColor.orange},
    {'label': 'Low', 'value': 2, 'color': AppColor.green},
    {'label': 'Default', 'value': 3, 'color': AppColor.blue},
  ];

  @override
  void onInit() {
    super.onInit();
    fetchReminders();
  }

  //Pickers
  void datePickerToogle(bool value) {
    isDatePicker.value = value;
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
    );

    if (picked != null && picked != selectedTime.value) {
      selectedTime.value = picked;
    }
  }

  void timePickerToogle(bool value) {
    isTimePicker.value = value;
  }

  bool isSameDate({required DateTime date}) {
    return selectedDate.value.year == date.year &&
        selectedDate.value.month == date.month &&
        selectedDate.value.day == date.day;
  }

  //Search functions
  void toggleSearch() {
    isOpenSearch.value = !isOpenSearch.value;
    if (!isOpenSearch.value) {
      searchController.value.clear();
      filteredReminders.clear();
      search("");
      hasSearched.value = false;
    }
  }

  void search(String query) {
    hasSearched.value = true;
    if (query.isEmpty) {
      _applyPriorityFilter();
    } else {
      filteredReminders.assignAll(reminders.where((reminder) {
        bool matchesQuery = reminder.title!.toLowerCase().contains(query.toLowerCase()) ||
            reminder.content!.toLowerCase().contains(query.toLowerCase());
        bool matchesPriority =
            selectedPriorities.isEmpty || selectedPriorities.contains(reminder.priority);
        return matchesQuery && matchesPriority;
      }).toList());
    }
  }

  //Filter functions
  void _applyPriorityFilter() {
    if (selectedPriorities.isEmpty) {
      filteredReminders.assignAll(reminders);
      hasFiltered.value = false;
    } else {
      filteredReminders.assignAll(
          reminders.where((reminder) => selectedPriorities.contains(reminder.priority)).toList());
      hasFiltered.value = true;
    }
  }

  void filter({int? priority}) {
    if (priority != null) {
      selectedPriorities.contains(priority)
          ? selectedPriorities.remove(priority)
          : selectedPriorities.add(priority);
    }
    search(searchController.value.text);
  }

  //Reminder form cleaner
  void clearForm() {
    selectedDate.value = DateTime.now();
    selectedTime.value = TimeOfDay.now();
    titleController.value.clear();
    contentController.value.clear();
    dateString.value = "";
    selectedPriority.value = 3;
    isSelectedPriority.value = false;
    isSelectedFile.value = false;
    isDatePicker.value = false;
    isTimePicker.value = false;
  }

  //Function to pull reminders from Firebase
  Future<void> fetchReminders() async {
    var user = _authRepository.getCurrentUser();
    loadingStatus.value = LoadingStatus.loading;
    var getAll = await _reminderRepository.getAll(userId: user.data!.uid);
    if (!getAll.isSuccess) {
      loadingStatus.value = LoadingStatus.failure;
      showErrorSnackbar(message: AppText.getReminders);
      return;
    }
    reminders.value = getAll.data ?? [];
    reminders.sort((a, b) {
      DateTime dateA = DateTime(a.date!.year, a.date!.month, a.date!.day);
      DateTime dateB = DateTime(b.date!.year, b.date!.month, b.date!.day);
      int dateComparison = dateA.compareTo(dateB);
      return dateComparison != 0 ? dateComparison : a.priority!.compareTo(b.priority!);
    });
    loadingStatus.value = LoadingStatus.success;
  }

  //Reminder CRUD Functions

  //Function that creates reminders
  Future<void> createReminder() async {
    await _saveReminder(isUpdate: false);
  }

  //Function that updates reminders
  Future<void> updateReminder(ReminderModel reminderToUpdate) async {
    await _saveReminder(isUpdate: true, existingReminder: reminderToUpdate);
  }

  //Common function for update and create properties
  Future<void> _saveReminder({required bool isUpdate, ReminderModel? existingReminder}) async {
    createStatus.value = LoadingStatus.loading;
    var user = _authRepository.getCurrentUser();
    if (user.data == null) {
      return _handleError('User not authenticated');
    }

    var combinedDateTime = _getCombinedDateTime(selectedDate.value, selectedTime.value);
    var notificationTimes = _calculateNotificationTimes(combinedDateTime);

    ReminderModel reminder = _buildReminderModel(isUpdate, existingReminder, notificationTimes.ids);

    if (file.value != null && !await _uploadFile(reminder, user.data!.uid)) {
      return;
    }

    var result = await (isUpdate
        ? _reminderRepository.update(userId: user.data!.uid, model: reminder)
        : _reminderRepository.create(userId: user.data!.uid, model: reminder));

    if (!result.isSuccess) {
      return _handleError(isUpdate ? AppText.reminderUpdate : AppText.reminderCreate);
    }

    if (isUpdate) {
      _updateLocalReminder(existingReminder!, reminder);
    } else {
      _addNewReminder(reminder, result.data);
    }

    await _scheduleNotifications(notificationTimes, reminder);
    _finalizeSuccess(isUpdate);
  }

  //ReminderModel create function
  ReminderModel _buildReminderModel(
      bool isUpdate, ReminderModel? existingReminder, List<int> notificationIds) {
    return ReminderModel(
      date: selectedDate.value,
      time: selectedTime.value.toTimeOfDay(),
      title: titleController.value.text,
      content: contentController.value.text,
      priority: selectedPriority.value,
      createdAt: isUpdate ? existingReminder!.createdAt : DateTime.now(),
      notificationIds: notificationIds,
      id: existingReminder?.id,
    );
  }

  //File upload function
  Future<bool> _uploadFile(ReminderModel reminder, String userId) async {
    var uploadImage = await _reminderRepository.uploadImage(
      file: file.value!,
      uuid: reminder.id ?? const Uuid().v4(),
      userId: userId,
    );
    if (!uploadImage.isSuccess) {
      _handleError('Failed to upload image');
      return false;
    }
    reminder.file = uploadImage.data;
    return true;
  }

  //Notification time calculator function
  NotificationTimes _calculateNotificationTimes(DateTime combinedDateTime) {
    return NotificationTimes(
      dayBefore: combinedDateTime.subtract(const Duration(days: 1)),
      fiveMinutesBefore: combinedDateTime.subtract(const Duration(minutes: 5)),
      ids: [_generateRandomNotificationId(), _generateRandomNotificationId()],
    );
  }

  //Notification schedule function
  Future<void> _scheduleNotifications(
      NotificationTimes notificationTimes, ReminderModel reminder) async {
    if (notificationTimes.dayBefore.isAfter(DateTime.now())) {
      await LocalNotificationHelper.scheduleRecurringNotifications(
        startDate: notificationTimes.dayBefore,
        title: reminder.title ?? "",
        body: reminder.content ?? "",
        id: notificationTimes.ids[0],
      );
    }
    if (notificationTimes.fiveMinutesBefore.isAfter(DateTime.now())) {
      await LocalNotificationHelper.scheduleRecurringNotifications(
        startDate: notificationTimes.fiveMinutesBefore,
        title: reminder.title ?? "",
        body: reminder.content ?? "",
        id: notificationTimes.ids[1],
      );
    }
  }

  void _handleError(String message) {
    createStatus.value = LoadingStatus.failure;
    showErrorSnackbar(message: message);
    Get.offAllNamed('/welcome');
  }

  void _updateLocalReminder(ReminderModel oldReminder, ReminderModel newReminder) {
    int index = reminders.indexWhere((r) => r.id == oldReminder.id);
    if (index != -1) reminders[index] = newReminder;
  }

  void _addNewReminder(ReminderModel reminder, String id) {
    reminder.id = id;
    reminders.add(reminder);
  }

  void _finalizeSuccess(bool isUpdate) {
    createStatus.value = LoadingStatus.success;
    showSuccessSnackbar(message: isUpdate ? AppText.reminderUpdate : AppText.reminderCreate);
    Get.back();
  }

  void fillData(ReminderModel reminder) {
    titleController.value.text = reminder.title ?? "";
    contentController.value.text = reminder.content ?? "";

    selectedPriority.value = reminder.priority!;
    if (reminder.time != null) {
      selectedTime.value = reminder.time.toTimeOfDay()!;
      isTimePicker.value = true;
    }
    if (reminder.date != null) {
      selectedDate.value = reminder.date!;
      isDatePicker.value = true;
    }
  }

  //reminder delete function
  Future<void> deleteReminder(ReminderModel model) async {
    deleteStatus.value = LoadingStatus.loading;
    var user = _authRepository.getCurrentUser();
    reminders.removeWhere((element) => element.id == model.id);
    filteredReminders.removeWhere((element) => element.id == model.id);
    update();
    var delete = await _reminderRepository.delete(
      userId: user.data!.uid,
      reminderId: model.id ?? "",
    );
    if (!delete.isSuccess) {
      deleteStatus.value = LoadingStatus.failure;
      showErrorSnackbar(message: 'Failed to delete reminder: $e');
      return;
    }
    if (model.notificationIds != null || model.notificationIds!.isNotEmpty) {
      LocalNotificationHelper.unScheduleAllNotification();
    }
    Get.back();
    deleteStatus.value = LoadingStatus.success;
    showSuccessSnackbar(message: 'Reminder deleted successfully');
  }

  //Function to delete all reminders
  Future<void> deleteAllReminders() async {
    deleteStatus.value = LoadingStatus.loading;
    var user = _authRepository.getCurrentUser();
    var response = await _reminderRepository.deleteByUserId(
        userId: user.data!.uid, collectionName: 'reminders');
    if (!response.isSuccess) {
      deleteStatus.value = LoadingStatus.failure;
      showErrorSnackbar(message: 'Failed to delete all reminders: $e');
      return;
    }
    LocalNotificationHelper.unScheduleAllNotification();
    Get.back();
    deleteStatus.value = LoadingStatus.success;
  }

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    var xFile = await picker.pickImage(source: source);
    if (xFile != null) {
      file.value = File(xFile.path);
    }
  }

  int _generateRandomNotificationId() {
    return Random.secure().nextInt(1000000) + 100000;
  }

  //Function that combines the selected date and time
  DateTime _getCombinedDateTime(DateTime date, TimeOfDay time) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }
}
