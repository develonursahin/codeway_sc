part of '../../view/home_view.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    required this.viewModel,
  });

  final HomeViewModel viewModel;

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: Obx(() => AnimatedSwitcher(
            duration: Durations.medium4,
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            child: !viewModel.isOpenSearch.value
                ? const Text(
                    AppText.appName,
                    style: TextStyle(fontSize: 35),
                  )
                : _buildSearchField(),
          )),
      actions: [
        Obx(() => AnimatedSwitcher(
              duration: Durations.short4,
              child: !viewModel.isOpenSearch.value
                  ? _buildActionsForClosedSearch()
                  : _buildActionsForOpenSearch(),
            )),
      ],
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: viewModel.searchController.value,
      onChanged: (value) {
        viewModel.search(value);
      },
      decoration: InputDecoration(
        fillColor: AppColor.greyLight,
        filled: true,
        hintText: AppText.searchReminder,
        hintStyle: AppTextStyle.greyDarkRegular16,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  Widget _buildPopupMenu() {
    return PopupMenuButton<int>(
      icon: const Icon(CupertinoIcons.slider_horizontal_3),
      onSelected: (priority) {
        viewModel.filter(priority: priority);
      },
      itemBuilder: (context) {
        return viewModel.priorityOptions.map((option) {
          return CheckedPopupMenuItem<int>(
            checked: viewModel.selectedPriorities.contains(option['value']),
            value: option['value'],
            key: option['key'],
            child: Row(
              children: [
                PriortiyCircleWidget(priorityId: option['value']),
                const SizedBox(width: 8),
                Text(option['label']),
              ],
            ),
          );
        }).toList();
      },
    );
  }

  Widget _buildActionsForClosedSearch() {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            viewModel.toggleSearch();
          },
          icon: const Icon(CupertinoIcons.search),
        ),
        _buildPopupMenu(),
        IconButton(
          onPressed: () {
            Get.toNamed('/settings');
          },
          icon: const Icon(CupertinoIcons.settings),
        ),
      ],
    );
  }

  Widget _buildActionsForOpenSearch() {
    return Row(
      children: [
        _buildPopupMenu(),
        IconButton(
          onPressed: () {
            viewModel.toggleSearch();
          },
          icon: const Icon(Icons.close_outlined),
        ),
      ],
    );
  }
}
