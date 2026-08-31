import 'package:car_rent_client/src/constants/colors.dart';
import 'package:flutter/material.dart';

class CarTypeToggle extends StatefulWidget {
  const CarTypeToggle({super.key, this.onChanged});

  final ValueChanged<String>? onChanged;

  @override
  State<CarTypeToggle> createState() => _CarTypeToggleState();
}

class _CarTypeToggleState extends State<CarTypeToggle> {
  final List<String> options = const [
    'All Cars',
    'Regular Cars',
    'Luxury Cars',
  ];

  String selected = 'All Cars';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.stoke, width: 1),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: options.map((option) {
              final bool isSelected = selected == option;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = option;
                    });

                    widget.onChanged?.call(option);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 280),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF000000)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(46),
                      boxShadow: isSelected
                          ? const [
                              BoxShadow(
                                color: Color.fromARGB(0, 0, 0, 0),
                                blurRadius: 16,
                                offset: Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Text(
                      option,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
