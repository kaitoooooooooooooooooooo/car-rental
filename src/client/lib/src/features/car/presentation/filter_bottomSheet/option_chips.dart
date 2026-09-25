import 'package:car_rent_client/src/constants/app_sizes.dart';
import 'package:car_rent_client/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OptionChips extends StatelessWidget {
  const OptionChips({
    super.key,
    required this.title,
    required this.options,
    required this.selected,
    required this.available,
    required this.onTap,
  });

  final String title;
  final List<String> options;
  final Set<String> selected;
  final Set<String> available;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        gapH8,
        Row(
          children: options.map((option) {
            final bool isSelected = selected.contains(option);
            final bool isAvailable = isSelected || available.contains(option);
            return Expanded(
              child: GestureDetector(
                onTap: isAvailable ? () => onTap(option) : null,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 280),
                    opacity: isAvailable ? 1 : 0.35,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 280),
                      curve: Curves.easeInOut,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.accent
                            : Colors.transparent,
                        border: Border.all(color: AppColors.stoke, width: 1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          option,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? AppColors.onAccent
                                : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
