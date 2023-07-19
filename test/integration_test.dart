// import 'package:flutter_driver/flutter_driver.dart';
// import 'package:test/test.dart';

// void main() {
//   group('Example Integration Test', () {
//     FlutterDriver driver;

//     // Connect to the Flutter driver before running the tests.
//     setUpAll(() async {
//       driver = await FlutterDriver.connect();
//     });

//     // Close the connection to the driver after the tests have completed.
//     tearDownAll(() async {
//       if (driver != null) {
//         driver.close();
//       }
//     });

//     test('Test App Launch', () async {
//       // Verify initial screen
//       expect(await driver.getText(find.text('Welcome to MyApp')), 'Welcome to MyApp');

//       // Perform interaction
//       await driver.tap(find.byType('RaisedButton').first);

//       // Verify the changes
//       expect(await driver.getText(find.text('Button Pressed: 1')), 'Button Pressed: 1');
//     });
//   });
// }
