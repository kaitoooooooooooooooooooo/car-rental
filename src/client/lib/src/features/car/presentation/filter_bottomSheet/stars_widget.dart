import 'package:car_rent_client/src/theme/theme.dart';
import 'package:flutter/material.dart';

class StarRatingWidget extends StatelessWidget {
  const StarRatingWidget({
    super.key,
    required this.rating,
    required this.onRatingChanged,
  });

  final double rating;
  final ValueChanged<double> onRatingChanged;

  Widget _buildStar(int index) {
    final double starValue = index + 1;
    IconData icon;

    if (rating >= starValue) {
      icon = Icons.star_rounded;
    } else if (rating >= starValue - 0.5) {
      icon = Icons.star_half_rounded;
    } else {
      icon = Icons.star_outline_rounded;
    }

    return GestureDetector(
      onTap: () => onRatingChanged(starValue),
      onLongPress: () => onRatingChanged(starValue - 0.5),
      child: Icon(icon, size: 32, color: AppColors.accentLight),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) => _buildStar(index)),
    );
  }
}
