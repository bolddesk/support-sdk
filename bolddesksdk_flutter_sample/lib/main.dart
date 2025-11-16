import 'dart:io';

import 'package:bd_support_sdk/bolddesk_support_sdk.dart';
import 'package:bolddesksdk_flutter_sample/firebase_options.dart';
import 'package:bolddesksdk_flutter_sample/notification_service.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize firebase services
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    sound: true,
    alert: true,
    badge: true,
  );
  // Request Notification permission when user enter into application
  await FirebaseMessaging.instance.requestPermission();
  // Initialize Firebase Messaging services to receive Notifications
  NotificationService.firebaseMessagingInitialize();
  // Get FCM Token Based
  NotificationService.getFCMToken();

  // Handle notification when app is terminated state (iOS only)
  if (Platform.isIOS) {
    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      if (message != null) {
        // BoldDeskSupportSDK.handleNotification(message.data);
      }
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter SDK Demo Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _appIdController = TextEditingController();
  final TextEditingController _brandUrlController = TextEditingController();
  final TextEditingController _secretKeyController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _statusMessage = '';
  String loginMessage = "";

  // Initialize SDK
  void _initializeSDK() {
    initializeMethods();
    final appId = _appIdController.text.trim();
    final brandUrl = _brandUrlController.text.trim();

    if (appId.isEmpty || brandUrl.isEmpty) {
      setState(() => _statusMessage = 'Please fill both App ID and Brand URL.');
      return;
    }

    BoldDeskSupportSDK.initialize(
      appId,
      brandUrl,
      onSuccess: (message) {
        setState(() {
          _statusMessage = '✅ $message';
        });
      },
      onError: (error) {
        setState(() => _statusMessage = '❌ $error');
      },
    );
  }

  String generateJwt({required String secretKey, required String email}) {
    // iat in seconds since epoch (UTC)
    final issuedAt = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;

    final jwt = JWT({'email': email, 'name': "", 'iat': issuedAt});

    // Sign with HS256
    final token = jwt.sign(SecretKey(secretKey), algorithm: JWTAlgorithm.HS256);

    return token;
  }

  // Login using secret key & email
  void _loginUser() {
    final secretkey = _secretKeyController.text;
    final email = _emailController.text;

    final jwtToken = generateJwt(secretKey: secretkey, email: email);

    if (jwtToken.isEmpty) {
      setState(() => loginMessage = 'Please enter Secret Key and Email ID.');
      return;
    }

    BoldDeskSupportSDK.loginWithJWTToken(
      jwtToken,
      onSuccess: (success) {
        setState(() {
          loginMessage = '✅ $success';
        });
      },
      onError: (error) {
        setState(() {
          loginMessage = '❌ $error';
        });
      },
    );
  }

  void initializeMethods() {
    // We can logging debug logging enable/disable
    BoldDeskSupportSDK.setLoggingEnabled(true);
    // Customize theme, accent color and primary color
    BoldDeskSupportSDK.applyTheme("#FF0000", "#00FF00");
    // Set preferred theme - light/dark/system
    BoldDeskSupportSDK.setPreferredTheme("system");
    // Set system font size enable/disable
    BoldDeskSupportSDK.setSystemFontSize(true);
    if (Platform.isAndroid) {
      // Customize font family in Android
      // Need to add font files in android/app/src/main/res/font/
      // BoldDeskSupportSDK.applyCustomFontFamilyInAndroid(
      //   bold: "dancingscript_bold",
      //   semiBold: "dancingscript_semibold",
      //   medium: "dancingscript_medium",
      //   regular: "dancingscript_regular",
      // );
    } else {
      // Customize font family in iOS
      BoldDeskSupportSDK.applyCustomFontFamilyInIOS("Times New Roman");
    }
    // Set custom logo in home screen
    BoldDeskSDKHome.setHeaderLogo(
      "https://images.google.com/images/branding/googlelogo/2x/googlelogo_light_color_272x92dp.png",
    );
    // Set custom content in home screen
    BoldDeskSDKHome.setHomeDashboardContent(
      headerName: "Custom Header",
      headerDescription: "This is custom header description",
      kbTitle: "Custom KB Title",
      kbDescription: "This is custom KB description",
      ticketTitle: "Custom Ticket Title",
      ticketDescription: "This is custom Ticket description",
      submitButtonText: "Send Now",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BoldDesk Support SDK Example')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _appIdController,
              decoration: const InputDecoration(labelText: 'App ID'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _brandUrlController,
              decoration: const InputDecoration(labelText: 'Brand URL'),
            ),
            SizedBox(height: _statusMessage.isEmpty ? 0 : 10),
            Text(
              _statusMessage,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _initializeSDK,
              child: const Text('Initialize SDK'),
            ),
            TextField(
              controller: _secretKeyController,
              decoration: const InputDecoration(labelText: 'Secret Key'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email ID'),
            ),
            SizedBox(height: loginMessage.isEmpty ? 0 : 10),
            Text(
              loginMessage,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _loginUser,
                  child: const Text('Login'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: BoldDeskSupportSDK.logout,
                  child: const Text('Logout'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: BoldDeskSupportSDK.showHome,
              child: const Text('Show Home Screen'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: BoldDeskSupportSDK.showCreateTicket,
              child: const Text('Show Create ticket'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: BoldDeskSupportSDK.showKB,
              child: const Text('Show KB'),
            ),
          ],
        ),
      ),
    );
  }
}
