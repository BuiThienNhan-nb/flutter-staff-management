import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staff_management/screens/dashboard/addAddition/addEmployeeAddition.dart';
import 'package:staff_management/screens/dashboard/addAddition/addNewAddition.dart';

class AddAdditionScreen extends StatefulWidget {
  const AddAdditionScreen({Key? key}) : super(key: key);

  @override
  _AddAdditionScreenState createState() => _AddAdditionScreenState();
}

class _AddAdditionScreenState extends State<AddAdditionScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Add Addition",
            style: GoogleFonts.varelaRound(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.card_giftcard_rounded),
                text: 'Add new Addition',
              ),
              Tab(
                icon: Icon(Icons.list_alt_rounded),
                text: 'Add Employee Addition',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AddNewAddition(),
            AddEmployeeAddition(),
          ],
        ),
      ),
    );
  }
}
