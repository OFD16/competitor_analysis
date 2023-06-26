// import 'package:firebase_auth/firebase_auth.dart';

// class AuthenticationService {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   Future<User?> signInWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       final UserCredential userCredential =
//           await _firebaseAuth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential.user;
//     } catch (e) {
//       print('Sign in failed: $e');
//       return null;
//     }
//   }

//   Future<User?> registerWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       final UserCredential userCredential =
//           await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential.user;
//     } catch (e) {
//       print('Registration failed: $e');
//       return null;
//     }
//   }

//   Future<void> signOut() async {
//     await _firebaseAuth.signOut();
//   }
// }
