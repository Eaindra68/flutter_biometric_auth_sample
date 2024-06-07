import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isAuthenticated = false;
  final LocalAuthentication _localAuth = LocalAuthentication();

  @override
  void initState() {
    _isAuthenticated = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Welcome To DashBoard'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (!_isAuthenticated) {
              // Bio ya ma ya sit
              final bool canCheckBiometrics =
                  await _localAuth.canCheckBiometrics;
              print(canCheckBiometrics);
              if (canCheckBiometrics) {
                try {
                  final bool didAuth = await _localAuth.authenticate(
                    localizedReason: 'Please Register to Enroll',
                    options: AuthenticationOptions(biometricOnly: false),
                  );
                  setState(() {
                    _isAuthenticated = didAuth;
                  });
                } catch (e) {
                  print(e);
                }
              } else {
                setState(() {
                  _isAuthenticated = !_isAuthenticated;
                });
              }
            }
            // auth->show balance if it is not -> show **
            else {
              setState(() {
                _isAuthenticated = false;
              });
            }
          },
          child: Icon(
            _isAuthenticated ? Icons.lock : Icons.lock_open,
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Account Balance',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 20),
              if (_isAuthenticated)
                const Text(
                  '\$ 25,632',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              const SizedBox(height: 20),
              if (!_isAuthenticated)
                const Text(
                  '*******',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              const SizedBox(height: 20),
            ],
          ),
        ));
  }
}
