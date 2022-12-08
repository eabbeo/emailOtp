import 'package:flutter/material.dart';
import 'package:email_otp/email_otp.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController emailText = TextEditingController();
  TextEditingController otp = TextEditingController();
  EmailOTP myauth = EmailOTP();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Enter your email'),
                  hintText: 'Email address',
                ),
                controller: emailText,
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                  onPressed: () async {
                    myauth.setConfig(
                        appEmail: "waawolotechnologies@gmail.com",
                        appName: "Waawolo Test OTP",
                        userEmail: emailText.text,
                        otpLength: 4,
                        otpType: OTPType.digitsOnly);
                    if (await myauth.sendOTP() == true) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("OTP has been sent"),
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Oops, OTP send failed"),
                      ));
                    }
                  },
                  child: const Text('Send me otp')),
              const Divider(
                height: 5,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Enter otp'),
                  hintText: 'Enter otp',
                ),
                controller: otp,
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                  onPressed: () async {
                    if (await myauth.verifyOTP(otp: otp.text) == true) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("OTP is verified"),
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Invalid OTP"),
                      ));
                    }
                  },
                  child: const Text('Verify')),
            ],
          ),
        ),
      ),
    );
  }
}
