import 'package:flutter/material.dart';
import 'package:clock_in_demo/Utility/app_color.dart';

final class DropMenuWidget extends StatefulWidget {
  final List<Map<String, dynamic>> dataList;
  final Function(String value) selectCallBack;
  final String? selectedValue;
  final Widget? leading;
  final Widget trailing;
  final Color? textColor;
  final Offset offset;
  final TextStyle normalTextStyle;
  final TextStyle selectTextStyle;
  final double maxHeight;
  final double maxWidth;
  final Color? bgColor;
  final bool animation;
  final int duration;
  final bool isDefaultFirstOne;

  const DropMenuWidget({
    super.key,
    this.leading,
    required this.dataList,
    required this.selectCallBack,
    this.selectedValue,
    this.trailing = const Icon(
      Icons.keyboard_arrow_down,
      color: AppColor.textGrey_0xFF6B6C71
    ),
    this.textColor = AppColor.textGrey_0xFF6B6C71,
    this.offset = const Offset(0, 30),
    this.normalTextStyle = const TextStyle(
      color: AppColor.textGrey_0xFF6B6C71,
      fontSize: 20,
    ),
    this.selectTextStyle = const TextStyle(
      color: AppColor.textBlue_0xFF4470B1,
      fontSize: 20,
    ),
    this.maxHeight = 250,
    this.maxWidth = 400,
    this.bgColor = AppColor.white_0xFFFFFFFF,
    this.animation = true,
    this.duration = 200,
    this.isDefaultFirstOne = true
  });

  @override
  State<DropMenuWidget> createState() => _DropMenuWidgetState();
}

final class _DropMenuWidgetState
    extends State<DropMenuWidget>
    with SingleTickerProviderStateMixin
{
  late AnimationController _animationController;
  late Animation<double> _animation;
  String _selectedLabel = '';
  String _currentValue = '';
  bool _isExpand = false;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.selectedValue ?? '';
    if (widget.animation) {
      _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.duration),
      );
      _animation = Tween(begin: 0.0, end: 0.5).animate(
          CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeInOut
          )
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _toggleExpand() {
    setState(() {
      if (_isExpand) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  _initLabel() {
    if (_currentValue.isNotEmpty) {
      if (widget.dataList.isNotEmpty) {
        _selectedLabel = widget.dataList
            .firstWhere((item) => item['value'] == _currentValue)['label'];
      }
    } else if (widget.dataList.isNotEmpty) {
      if (widget.isDefaultFirstOne) {
        _selectedLabel = widget.dataList[0]['label'];
        _currentValue = widget.dataList[0]['value'];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _initLabel();
    return PopupMenuButton(
        constraints: BoxConstraints(
          maxHeight: widget.maxHeight,
          maxWidth: widget.maxWidth,
          minWidth: 300,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        offset: widget.offset,
        color: widget.bgColor,
        onOpened: () {
          if (widget.animation) {
            setState(() {
              _isExpand = true;
              _toggleExpand();
            });
          }
        },
        onCanceled: () {
          if (widget.animation) {
            setState(() {
              _isExpand = false;
              _toggleExpand();
            });
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.centerLeft,
          height: 40,
          child: FittedBox(
            child: Row(
              children: [
                if (widget.leading != null) widget.leading!,
                Text(
                  _selectedLabel,
                  style: TextStyle(
                    color: widget.textColor,
                    fontSize: 20,
                  ),
                ),
                if (widget.animation)
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _animation.value * 2 * 3.14,
                        child: widget.trailing,
                      );
                    },
                  ),
                if (!widget.animation) widget.trailing,
              ],
            ),
          ),
        ),
        itemBuilder: (context) {
          return widget.dataList.map((element) {
            return PopupMenuItem(
              child: Text(
                element['label'],
                style: (element['value'] == _currentValue)
                    ? widget.selectTextStyle
                    : widget.normalTextStyle,
              ),
              onTap: () {
                setState(() {
                  _currentValue = element['value'];
                  widget.selectCallBack(element['value']);
                });
              },
            );
          }).toList();
        }
    );
  }
}