import 'package:firebase_auth/firebase_auth.dart';
import 'package:staff_management/models/employee.dart';
import 'package:staff_management/services/employeeRepo.dart';

class AuthenticationServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String errorMessage = '';

  //sign in with email
  Future signIn(String _email, String _password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
              email: '$_email@gmail.com', password: _password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email';
        return null;
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user!';
        return null;
      }
    }
  }

  // Future<void> signOut() async {
  //   await FirebaseAuth.instance.signOut();
  //   EmployeeRepo.employee = Employee(
  //     uid: '',
  //     name: '',
  //     additionHistory: null,
  //     workHistory: null,
  //     salary: 0,
  //     retirementDate: null,
  //     address: '',
  //     birthdate: null,
  //     folk: '',
  //     identityCard: '',
  //     quotaHistory: null,
  //     relative: null,
  //     sex: '',
  //     workDate: null,
  //   );
  // }
}
