part of '../../../view/home_view.dart';

showCustomPriorityPicker(
        {required BuildContext context,
        required List pickerList,
        required initialValue,
        required Function(int)? onSelectedItemChanged}) =>
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: Get.height * 0.25,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: AppColor.white,
        child: SafeArea(
          top: false,
          child: Stack(
            children: [
              CupertinoPicker(
                itemExtent: 40,
                magnification: 1.2,
                squeeze: 1.2,
                scrollController:
                    FixedExtentScrollController(initialItem: initialValue),
                onSelectedItemChanged: onSelectedItemChanged,
                children: List<Widget>.generate(
                  pickerList.length,
                  (int index) {
                    return Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PriortiyCircleWidget(
                            priorityId: index,
                          ).pOnly(right: 10),
                          Text(
                            pickerList[index],
                            style: AppTextStyle.blackRegular20,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    AppText.cancel,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: AppColor.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ).gestureDetector(onTap: () => Get.back()),
                  const Spacer(),
                  const Text(
                    AppText.add,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: AppColor.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ).gestureDetector(onTap: () {
                    FocusScope.of(context).unfocus();
                    Get.back();
                  }),
                ],
              ).pAll(context.pageHorizontal),
            ],
          ),
        ),
      ),
    );
