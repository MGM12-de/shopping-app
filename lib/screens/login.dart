import 'package:flutter/material.dart';
import '../services/services.dart';

class LoginScreen extends StatefulWidget {
  createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  AuthService auth = AuthService();

  @override
  void initState() {
    super.initState();

    auth.getUser().then((user) => {
          if (user != null) {Navigator.pushReplacementNamed(context, '/home')}
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/images/icon.png'),
            Text(
              'Login to Start',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            Text('For the best experience please login'),
            LoginButton(
              text: 'LOGIN WITH GOOGLE',
              icon: Icons.login,
              loginMethod: auth.signInWithGoogle,
            ),
            LoginButton(text: 'Continue as Guest', loginMethod: auth.anonLogin)
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  final Function loginMethod;

  const LoginButton({this.text, this.icon, this.color, this.loginMethod});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextButton.icon(
        icon: Icon(icon),
        label: Expanded(
          child: Text(
            '$text',
            textAlign: TextAlign.center,
          ),
        ),
        style:
            TextButton.styleFrom(primary: color, padding: EdgeInsets.all(30)),
        onPressed: () async {
          var user = await loginMethod();
          if (user != null) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
      ),
    );
  }
}
