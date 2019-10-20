import 'package:flutter/material.dart';

class LabeledSwitch extends StatelessWidget {
  const LabeledSwitch({
    this.label,
    this.labelSize,
    this.padding,
    this.groupValue,
    this.value,
    this.onChanged,
    this.activeColor,
  });

  final String label;
  final double labelSize;
  final EdgeInsets padding;
  final bool groupValue;
  final bool value;
  final Function onChanged;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(
                child: Text(
              label,
              style: TextStyle(fontSize: labelSize),
            )),
            Switch(
              activeColor: activeColor,
              value: value,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}
