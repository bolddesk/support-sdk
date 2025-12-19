import 'package:flutter/material.dart';

class PeriodSelector extends StatefulWidget {
  const PeriodSelector({
    required this.period,
    this.optionalHorizontalPadding,
    this.onChanged,
    super.key,
  });

  final String period; // '1D', '1W', '1M'
  final double? optionalHorizontalPadding;
  final ValueChanged<String>? onChanged;

  @override
  State<PeriodSelector> createState() => _PeriodSelectorState();
}

class _PeriodSelectorState extends State<PeriodSelector> {
  late String _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.period;
  }

  @override
  void didUpdateWidget(covariant PeriodSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.period != widget.period) {
      _selected = widget.period;
    }
  }

  void _setSelected(String p) {
    if (_selected == p) return;
    setState(() => _selected = p);
    widget.onChanged?.call(p);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.optionalHorizontalPadding ?? 16,
      ),
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: ["1D", "1W", "1M"].map((p) {
            final active = p == _selected;
            return Expanded(
              child: GestureDetector(
                onTap: () => _setSelected(p),
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: active
                      ? BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 2,
                              offset: Offset(0, 1),
                            ),
                          ],
                        )
                      : null,
                  alignment: Alignment.center,
                  child: Text(
                    p,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: active ? FontWeight.w600 : FontWeight.normal,
                      color: active
                          ? const Color(0xFF1A1A1A)
                          : const Color(0xFF6B7280),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
