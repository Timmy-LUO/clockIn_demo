import 'package:flutter/material.dart';

final class ToggleSwitch extends StatefulWidget {
  final double minWidth;
  final double cornerRadius;
  final List<List<Color>> activeBgColors;
  final Color activeFgColor;
  final Color inactiveBgColor;
  final Color inactiveFgColor;
  final int initialLabelIndex;
  final int totalSwitches;
  final List<String>? labels;
  final bool radiusStyle;
  final Function(int) onToggle;

  const ToggleSwitch({
    super.key,
    required this.minWidth,
    required this.cornerRadius,
    required this.activeBgColors,
    required this.activeFgColor,
    required this.inactiveBgColor,
    required this.inactiveFgColor,
    required this.initialLabelIndex,
    required this.totalSwitches,
    this.labels,
    required this.radiusStyle,
    required this.onToggle,
  });

  @override
  State<ToggleSwitch> createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<ToggleSwitch> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialLabelIndex;
  }

  void _toggleSwitch() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % widget.totalSwitches;
    });
    widget.onToggle(_currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSwitch,
      child: Container(
        width: widget.minWidth,
        height: 40,
        decoration: BoxDecoration(
          color: widget.inactiveBgColor,
          borderRadius: (widget.radiusStyle)
              ? BorderRadius.circular(widget.cornerRadius)
              : null,
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: _currentIndex * (widget.minWidth / widget.totalSwitches),
              child: Container(
                width: widget.minWidth / widget.totalSwitches,
                height: 40,
                decoration: BoxDecoration(
                  color: widget.activeBgColors[_currentIndex][0],
                  borderRadius: (widget.radiusStyle)
                      ? BorderRadius.circular(widget.cornerRadius)
                      : null,
                ),
                child: (widget.labels == null) ? Container()
                  : Center(
                      child: Text(
                        widget.labels![_currentIndex],
                        style: TextStyle(
                          color: widget.activeFgColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              ),
            ),
          ],
        )
      ),
    );
  }
}