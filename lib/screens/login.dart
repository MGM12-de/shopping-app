import 'package:flutter/material.dart';
import '../services/services.dart';

class LoginScreen extends StatefulWidget {
  createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  AuthService auth = AuthService();


  @override
  void initState(){
    super.initState();

    auth.getUser().then((user) => {
      if( user != null){
        Navigator.pushReplacementNamed(context, '/home')
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        padding:  EdgeInsets.all(30),
        decoration: BoxDecoration(),
        child: Column(
          children: [
            FlutterLogo(
              size: 150,
            ),
            Text(
              'Login to Start',
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
            ),
            Text('Test'),
            LoginButton(
              text: 'LOGIN WITH GOOGLE',
              icon: Icons.login,
              loginMethod: auth.signInWithGoogle
            )
          ],
        ),
      ),
    );
  }
}


class LoginButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function loginMethod;


  const LoginButton({this.text, this.icon, this.loginMethod});

  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: FlatButton.icon(
        padding: EdgeInsets.all(30),
        icon: Icon(icon),
        label: Expanded(
          child: Text('$text', 
          textAlign: TextAlign.center,
          ),
        ),
        onPressed: () async{
          var user = await loginMethod();
          if(user != null){
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
      ),
    );
  }
  
}