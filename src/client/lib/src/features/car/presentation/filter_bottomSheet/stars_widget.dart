import 'package:flutter/material.dart';

class StarRatingWidget extends StatelessWidget {
  final int starCount;
  final double rating;
  final Color? color;
  final ValueChanged<double>? onRatingChanged;

  const StarRatingWidget({
    super.key,
    this.starCount = 5,
    this.rating = 0,
    this.color,
    this.onRatingChanged,
  });

  Widget _buildStar(int index) {
    final double starValue = index + 1;
    IconData icon;

    if (rating >= starValue) {
      icon = IconData(0xf01d4, fontFamily: 'MaterialIcons');
    } else if (rating >= starValue - 0.5) {
      icon = IconData(0xf01d0, fontFamily: 'MaterialIcons');
    } else {
      icon = IconData(0xf01d1, fontFamily: 'MaterialIcons');
    }

    return GestureDetector(
      onTap: () => onRatingChanged?.call(starValue),
      onLongPress: () => onRatingChanged?.call(starValue - 0.5),
      child: Icon(icon, size: 32, color: color ?? const Color(0xFFFF8F3A)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (index) => _buildStar(index)),
    );
  }
}
