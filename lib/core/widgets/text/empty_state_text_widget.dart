part of '../../../presentation/home/view/home_view.dart';

class EmptyStateTextWidget extends StatelessWidget {
  final String message;
  const EmptyStateTextWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: AppTextStyle.greyDarkRegular16,
      ),
    );
  }
}
