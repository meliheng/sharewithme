import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 203,
              height: 120,
              child: Text(
                "Share With Me",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff262626),
                  fontSize: 48,
                  fontFamily: "Lato",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 3.44),
            const SizedBox(
              width: 203,
              height: 26,
              child: Text(
                "Sign in to your account",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff262626),
                  fontFamily: "Lato",
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 3.44),
            Container(
              width: 300,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 20,
                    offset: Offset(0, 8),
                  )
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  contentPadding: const EdgeInsets.symmetric(vertical: 20),
                  hintText: "Username",
                  hintStyle: const TextStyle(
                    fontFamily: "Lato",
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.shade300),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 20,
                    offset: Offset(0, 8),
                  )
                ],
              ),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  contentPadding: const EdgeInsets.symmetric(vertical: 20),
                  hintText: "Password",
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.shade300),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 3.44),
            const SizedBox(
              width: 300,
              height: 50,
              child: Text(
                "Forgot  your password?",
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Color(0xffbebebe),
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(
              width: 300,
              height: 34,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Sign in",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Color(0xff262626),
                      fontSize: 25,
                      fontFamily: "Lato",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    width: 56,
                    height: 34,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xfff97794), Color(0xff623aa2)],
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 200),
            const SizedBox(
              width: 209,
              height: 24,
              child: Text(
                "Don’t have an account? Create",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff262626),
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
