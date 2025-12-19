// AccountBalanceCard widget
import 'package:bolddesksdk_flutter_sample/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AccountBalanceCard extends StatefulWidget {
  const AccountBalanceCard({super.key});

  @override
  State<AccountBalanceCard> createState() => _AccountBalanceCardState();
}

class _AccountBalanceCardState extends State<AccountBalanceCard> {
  bool _revealed = false;
  final double _amount = 12345.67;

  String get _masked => '\$********.**';

  String get _formatted {
    final nf = NumberFormat('#,##0.00', 'en_US');
    return '\$${nf.format(_amount)}';
  }

  void _toggleReveal() => setState(() => _revealed = !_revealed);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1018280F),
            blurRadius: 4,
            spreadRadius: -2,
            offset: Offset(0, 2),
          ),
          BoxShadow(
            color: Color(0x1018281A),
            blurRadius: 8,
            spreadRadius: -2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Account Balance',
                style: TextStyle(
                  color: AppColors.darkText,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: _toggleReveal,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  child: Text(
                    _revealed ? 'Hide' : 'Show',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Large masked amount
          Text(
            _revealed ? _formatted : _masked,
            style: TextStyle(
              color: AppColors.secondaryText,
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 22),

          // Buttons row
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Add money',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.lightCard,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFCDB8FF), width: 2),
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    'Withdraw',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



class SegmentedSelector extends StatefulWidget {
  final List<String> segments;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const SegmentedSelector({
    super.key,
    required this.segments,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  State<SegmentedSelector> createState() => _SegmentedSelectorState();
}

class _SegmentedSelectorState extends State<SegmentedSelector> {
  late List<bool> _selections;

  @override
  void initState() {
    super.initState();
    _selections = widget.segments.map((_) => false).toList();
    _selections[widget.selectedIndex] = true;
  }

  @override
  void didUpdateWidget(SegmentedSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _updateSelections(widget.selectedIndex);
    }
  }

  void _updateSelections(int index) {
    setState(() {
      for (int i = 0; i < _selections.length; i++) {
        _selections[i] = i == index;
      }
    });
    widget.onChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ToggleButtons(
            isSelected: _selections,
            onPressed: _updateSelections,
            borderRadius: BorderRadius.circular(12),
            selectedBorderColor: Colors.grey[300],
            borderColor: Colors.grey[300],
            color: AppColors.grey,
            // selectedColor: widget.selectedColor,
            // fillColor: widget.unselectedColor,
            borderWidth: 1,

            constraints: const BoxConstraints(minHeight: 32),
            children: widget.segments.map((label) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
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

// Alternative using CupertinoSegmentedControl for native iOS feel (requires Cupertino import).
class NativeIOSSementedControl extends StatefulWidget {
  final List<String> segments;
  final int selectedIndex;
  final ValueChanged<int>? onChanged;

  const NativeIOSSementedControl({
    super.key,
    required this.segments,
    required this.selectedIndex,
    this.onChanged,
  });

  @override
  State<NativeIOSSementedControl> createState() =>
      _NativeIOSSementedControlState();
}

class _NativeIOSSementedControlState extends State<NativeIOSSementedControl> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CupertinoSegmentedControl<int>(
            // padding: EdgeInsets.all(16),
            children: {
              for (int i = 0; i < widget.segments.length; i++)
                i: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.lightBg,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    widget.segments[i],
                    style: TextStyle(color: AppColors.darkText),
                  ),
                ),
            },
            groupValue: _selectedIndex,
            onValueChanged: widget.onChanged != null
                ? (value) {
                    setState(() => _selectedIndex = value);
                    widget.onChanged?.call(value);
                  }
                : (value) {},
          ),
        ),
      ],
    );
  }
}
