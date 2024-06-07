import 'package:flutter/material.dart';
import 'package:flutter_bi0_metric_testing/next.dart';
import 'package:local_auth/local_auth.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                // Bio ya ma ya sit
                final bool canCheckBiometrics =
                    await _localAuth.canCheckBiometrics;
                print(canCheckBiometrics);
                if (canCheckBiometrics) {
                  try {
                    final bool didAuth = await _localAuth.authenticate(
                      localizedReason: 'Please Register to Enroll',
                      options:
                          const AuthenticationOptions(biometricOnly: false),
                    );
                    if (didAuth) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NextPage()),
                      );
                    }
                  } catch (e) {
                    print(e);
                  }
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: 110,
                height: 30,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: const Text(
                  'Check in',
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
