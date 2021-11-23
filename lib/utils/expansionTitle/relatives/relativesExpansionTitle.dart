// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:staff_management/utils/dropdown/dropdownButton.dart';
// import 'package:staff_management/utils/textField/textField.dart';

// class RelativesExpansionTitle extends StatelessWidget {
//   const RelativesExpansionTitle({
//     Key? key,
//     required TextEditingController relativeNameController,
//     required this.editable,
//     required TextEditingController relativeTypeController,
//     required TextEditingController relativeJobController,
//     required TextEditingController relativeBirthdayController,
//     required String expansionName,
//   })  : _relativeNameController = relativeNameController,
//         _relativeTypeController = relativeTypeController,
//         _relativeJobController = relativeJobController,
//         _relativeBirthdayController = relativeBirthdayController,
//         _expansionName = expansionName,
//         super(key: key);

//   final TextEditingController _relativeNameController;
//   final bool editable;
//   final TextEditingController _relativeTypeController;
//   final TextEditingController _relativeJobController;
//   final TextEditingController _relativeBirthdayController;
//   final String _expansionName;

//   @override
//   Widget build(BuildContext context) {
//     return ExpansionTile(
//       tilePadding: EdgeInsets.only(left: 12),
//       title: Row(
//         children: [
//           Icon(
//             Icons.person,
//             color: Colors.grey,
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           Text(
//             _expansionName,
//             style: TextStyle(
//               fontSize: 17.0,
//             ),
//           ),
//         ],
//       ),
//       children: <Widget>[
//         ChildExpansionTitle(
//             relativeNameController: _relativeNameController,
//             editable: editable,
//             relativeTypeController: _relativeTypeController,
//             relativeJobController: _relativeJobController,
//             relativeBirthdayController: _relativeBirthdayController)
//       ],
//     );
//   }
// }

// class ChildExpansionTitle extends StatelessWidget {
//   const ChildExpansionTitle({
//     Key? key,
//     required TextEditingController relativeNameController,
//     required this.editable,
//     required TextEditingController relativeTypeController,
//     required TextEditingController relativeJobController,
//     required TextEditingController relativeBirthdayController,
//   })  : _relativeNameController = relativeNameController,
//         _relativeTypeController = relativeTypeController,
//         _relativeJobController = relativeJobController,
//         _relativeBirthdayController = relativeBirthdayController,
//         super(key: key);

//   final TextEditingController _relativeNameController;
//   final bool editable;
//   final TextEditingController _relativeTypeController;
//   final TextEditingController _relativeJobController;
//   final TextEditingController _relativeBirthdayController;

//   @override
//   Widget build(BuildContext context) {
//     return ExpansionTile(
//       // tilePadding: EdgeInsets.only(left: 12),
//       title: TextFieldWidget(
//         controller: _relativeNameController,
//         icon: Icon(Icons.person),
//         hintText: "Name",
//         onEdit: editable,
//         textInputFormatter: FilteringTextInputFormatter.singleLineFormatter,
//       ),
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30),
//           child: editable
//               ? MyDropdownButton(
//                   selectedValue: _relativeTypeController.text,
//                   values: <String>["Vợ/Chồng", "Con cái"],
//                   icon: Icon(Icons.merge_type),
//                   lable: "Type",
//                   callback: (String _newValue) {
//                     _relativeTypeController.text = _newValue;
//                   },
//                 )
//               : TextFieldWidget(
//                   controller: _relativeTypeController,
//                   icon: Icon(Icons.merge_type),
//                   hintText: "Type",
//                   onEdit: false,
//                   textInputFormatter:
//                       FilteringTextInputFormatter.singleLineFormatter,
//                 ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30),
//           child: TextFieldWidget(
//             controller: _relativeJobController,
//             icon: Icon(Icons.person),
//             hintText: "Job",
//             onEdit: editable,
//             textInputFormatter: FilteringTextInputFormatter.singleLineFormatter,
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30),
//           child: TextFieldWidget(
//             controller: _relativeBirthdayController,
//             icon: Icon(Icons.person),
//             hintText: "Birthday",
//             onEdit: editable,
//             textInputFormatter: FilteringTextInputFormatter.singleLineFormatter,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:staff_management/models/relative.dart';
import 'package:staff_management/utils/dropdown/dropdownButton.dart';
import 'package:staff_management/utils/textField/textField.dart';
import 'package:intl/intl.dart';

class RelativesExpansionTitle extends StatelessWidget {
  final List<Relative> _relatives;
  final bool _onEdit;
  const RelativesExpansionTitle(
      {Key? key, required List<Relative> relatives, required bool onEdit})
      : _relatives = relatives,
        _onEdit = onEdit,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.only(left: 12),
      title: Row(
        children: [
          Icon(
            Icons.family_restroom,
            color: Colors.grey,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Relatives",
            style: TextStyle(
              fontSize: 17.0,
            ),
          ),
        ],
      ),
      children: [
        ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: _relatives.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(12),
            child: ChildRelativeExpansionTitle(
              relative: _relatives[index],
              onEdit: _onEdit,
            ),
          ),
        )
      ],
    );
  }
}

// ignore: must_be_immutable
class ChildRelativeExpansionTitle extends StatefulWidget {
  Relative _relative;
  final bool _onEdit;
  ChildRelativeExpansionTitle(
      {Key? key, required Relative relative, required bool onEdit})
      : _relative = relative,
        _onEdit = onEdit,
        super(key: key);

  @override
  State<ChildRelativeExpansionTitle> createState() =>
      _ChildRelativeExpansionTitleState();
}

class _ChildRelativeExpansionTitleState
    extends State<ChildRelativeExpansionTitle> {
  final TextEditingController _relativeNameController = TextEditingController();
  final TextEditingController _relativeTypeController = TextEditingController();
  final TextEditingController _relativeJobController = TextEditingController();
  final TextEditingController _relativeBirthdateController =
      TextEditingController();

  @override
  void initState() {
    _relativeNameController.text = widget._relative.name;
    _relativeTypeController.text = widget._relative.type;
    _relativeJobController.text = widget._relative.job;
    _relativeBirthdateController.text =
        "${DateFormat('MM/dd/yyyy').format(DateTime.fromMicrosecondsSinceEpoch(widget._relative.birthdate.seconds * 1000))}";
    super.initState();
  }

  void updateVariables() {
    widget._relative.name = _relativeNameController.text;
    widget._relative.type = _relativeTypeController.text;
    widget._relative.job = _relativeJobController.text;
  }

  @override
  void dispose() {
    updateVariables();
    _relativeNameController.dispose();
    _relativeTypeController.dispose();
    _relativeJobController.dispose();
    _relativeBirthdateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: TextFieldWidget(
        controller: _relativeNameController,
        icon: Icon(Icons.person),
        hintText: "Name",
        onEdit: widget._onEdit,
        textInputFormatter: FilteringTextInputFormatter.singleLineFormatter,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: widget._onEdit
              ? MyDropdownButton(
                  selectedValue: widget._relative.type,
                  values: <String>["Vợ/Chồng", "Con cái"],
                  icon: Icon(Icons.merge_type),
                  lable: "Type",
                  callback: (String _newValue) {
                    widget._relative.type = _newValue;
                    _relativeNameController.text = _newValue;
                  },
                )
              : TextFieldWidget(
                  controller: _relativeTypeController,
                  icon: Icon(Icons.merge_type),
                  hintText: "Type",
                  onEdit: false,
                  textInputFormatter:
                      FilteringTextInputFormatter.singleLineFormatter,
                ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextFieldWidget(
            controller: _relativeJobController,
            icon: Icon(Icons.person),
            hintText: "Job",
            onEdit: widget._onEdit,
            textInputFormatter: FilteringTextInputFormatter.singleLineFormatter,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextFieldWidget(
            controller: _relativeBirthdateController,
            icon: Icon(Icons.person),
            hintText: "Birthday",
            onEdit: widget._onEdit,
            textInputFormatter: FilteringTextInputFormatter.singleLineFormatter,
          ),
        ),
      ],
    );
  }
}
