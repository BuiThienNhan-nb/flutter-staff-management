import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staff_management/models/relative.dart';
import 'package:staff_management/utils/expansionTitle/relatives/relativesExpansionTitle.dart';

class AddRelative extends StatefulWidget {
  final Relative _relative;
  final Callback _callback;
  const AddRelative({
    Key? key,
    required Relative relative,
    required Callback callback,
  })  : _relative = relative,
        _callback = callback,
        super(key: key);

  @override
  _AddRelativeState createState() => _AddRelativeState();
}

class _AddRelativeState extends State<AddRelative> {
  @override
  void dispose() {
    super.dispose();
    widget._callback(widget._relative);
  }

  @override
  Widget build(BuildContext context) {
    ChildRelativeExpansionTitle _relativeExpansionWidget =
        ChildRelativeExpansionTitle(onEdit: true, relative: widget._relative);
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _relativeExpansionWidget.createState().build(context),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _relativeExpansionWidget.createState().dispose();
                Get.back();
                final snackBar = SnackBar(
                  duration: Duration(milliseconds: 500),
                  content: Text(
                    "Add relative successful",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text("Add Relative"),
            ),
          ],
        ),
      ),
    );
  }
}

typedef Callback = void Function(Relative _newRelative);
