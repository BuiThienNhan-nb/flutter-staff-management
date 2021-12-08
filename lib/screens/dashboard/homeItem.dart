import 'package:flutter/material.dart';

class HomeItem extends StatefulWidget {
  final String _tile;
  final IconData _icon;
  // final Function _function;
  final bool _isSelected;
  const HomeItem(
      {Key? key,
      required String title,
      required IconData icon,
      // required Function function,
      required bool isSelected})
      : _tile = title,
        _icon = icon,
        // _function = function,
        _isSelected = isSelected,
        super(key: key);

  @override
  _HomeItemState createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(
          color: widget._isSelected
              ? Colors.blue.shade100
              : Colors.grey.withOpacity(0),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(widget._icon, size: 60),
            SizedBox(height: 10),
            Text(
              "${widget._tile}",
              style: TextStyle(fontSize: 16),
            )
          ]),
    );
  }
}
