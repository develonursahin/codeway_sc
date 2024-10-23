part of '../../../view/home_view.dart';

class PriortiyCircleWidget extends StatelessWidget {
  final int priorityId;
  const PriortiyCircleWidget({
    super.key,
    required this.priorityId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        color: getPriorityColor(priorityId).withOpacity(0.1),
        shape: BoxShape.circle,
        border: Border.all(color: getPriorityColor(priorityId), width: 2),
      ),
    );
  }
}
