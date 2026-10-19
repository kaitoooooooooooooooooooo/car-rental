import 'package:car_rent_client/src/common_widgets/liquid_glass.dart';
import 'package:car_rent_client/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';

class LiquidGlassTabItem {
  const LiquidGlassTabItem({
    required this.icon,
    this.selectedIcon,
    required this.label,
    this.isSearch = false,
  });

  final IconData icon;
  final IconData? selectedIcon;
  final String label;
  final bool isSearch;
}

class LiquidGlassTabBar extends StatefulWidget {
  const LiquidGlassTabBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onTap,
  });

  final List<LiquidGlassTabItem> items;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  State<LiquidGlassTabBar> createState() => _LiquidGlassTabBarState();
}

class _LiquidGlassTabBarState extends State<LiquidGlassTabBar>
    with SingleTickerProviderStateMixin {
  static const _height = 64.0;
  static const _pad = 4.0;
  static const _spring = SpringDescription(
    mass: 1,
    stiffness: 420,
    damping: 24,
  );

  late final List<int> _tabs = [
    for (var i = 0; i < widget.items.length; i++)
      if (!widget.items[i].isSearch) i,
  ];
  late final int _search = widget.items.indexWhere((it) => it.isSearch);
  late final AnimationController _pos = AnimationController.unbounded(
    vsync: this,
    value: _tabs
        .indexOf(widget.selectedIndex)
        .clamp(0, _tabs.length)
        .toDouble(),
  );
  bool _dragging = false;

  bool get _searchSelected => widget.selectedIndex == _search;

  @override
  void didUpdateWidget(LiquidGlassTabBar old) {
    super.didUpdateWidget(old);
    final target = _tabs.indexOf(widget.selectedIndex);
    if (target >= 0 && !_dragging) _springTo(target, _pos.velocity);
  }

  @override
  void dispose() {
    _pos.dispose();
    super.dispose();
  }

  void _springTo(int target, double velocity) => _pos.animateWith(
    SpringSimulation(_spring, _pos.value, target.toDouble(), velocity),
  );

  void _select(int index) {
    if (index == widget.selectedIndex) return;
    HapticFeedback.selectionClick();
    widget.onTap(index);
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, bottom > 0 ? bottom : 16),
      child: SizedBox(
        height: _height,
        child: Row(
          children: [
            Expanded(
              child: LiquidGlass(
                child: LayoutBuilder(
                  builder: (context, c) => _buildTabs(c.maxWidth),
                ),
              ),
            ),
            if (_search >= 0) ...[
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => _select(_search),
                child: SizedBox.square(
                  dimension: _height,
                  child: LiquidGlass(
                    child: Icon(
                      widget.items[_search].icon,
                      size: 26,
                      color: _searchSelected
                          ? AppColors.accent
                          : AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTabs(double width) {
    final w = (width - 2 * _pad) / _tabs.length;
    final h = _height - 2 * _pad;
    double toPos(Offset p) =>
        ((p.dx - _pad) / w - 0.5).clamp(-0.2, _tabs.length - 0.8);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragStart: (d) {
        setState(() => _dragging = true);
        _pos.value = toPos(d.localPosition);
      },
      onHorizontalDragUpdate: (d) => _pos.value = toPos(d.localPosition),
      onHorizontalDragEnd: (d) {
        setState(() => _dragging = false);
        final target = _pos.value.round().clamp(0, _tabs.length - 1);
        _springTo(target, d.velocity.pixelsPerSecond.dx / w);
        _select(_tabs[target]);
      },
      child: AnimatedBuilder(
        animation: _pos,
        builder: (context, _) {
          final hidden = _searchSelected && !_dragging;
          final stretch = (_pos.velocity.abs() * 0.06).clamp(0.0, 0.45);
          final lens = _dragging ? 1.12 : 1.0;
          final iw = w * (1 + stretch) * lens;
          final ih = h * (1 - stretch * 0.25) * lens;

          return Stack(
            children: [
              Positioned(
                left: _pad + _pos.value * w + (w - iw) / 2,
                top: _pad + (h - ih) / 2,
                width: iw,
                height: ih,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: hidden ? 0 : 1,
                  child: CustomPaint(
                    painter: GlassRimPainter(intensity: _dragging ? 1.2 : 0.5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: _dragging
                            ? Colors.white.withValues(alpha: 0.10)
                            : AppColors.accentSoft,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  const SizedBox(width: _pad),
                  for (var i = 0; i < _tabs.length; i++)
                    SizedBox(
                      width: w,
                      child: _tab(
                        widget.items[_tabs[i]],
                        hidden
                            ? 0
                            : (1 - (_pos.value - i).abs()).clamp(0.0, 1.0),
                        () => _select(_tabs[i]),
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _tab(LiquidGlassTabItem item, double t, VoidCallback onTap) {
    final color = Color.lerp(AppColors.textPrimary, AppColors.accent, t)!;
    final selected = t > 0.5;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 1 + 0.08 * t,
            child: Icon(
              selected ? (item.selectedIcon ?? item.icon) : item.icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            item.label,
            style: TextStyle(
              color: color,
              fontSize: 10.5,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
