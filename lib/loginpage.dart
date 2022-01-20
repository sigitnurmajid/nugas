import 'package:flutter/material.dart';
import 'onboarding.dart';
import 'forgotpassword.dart';
import 'homepage.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'avenir'
      ),
      home: LoginPages(),
    );
  }
}

class LoginPages extends StatefulWidget {

  @override
  _LoginPagesState createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  bool _isObscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: openOnBoard,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text('Welcome Back!', style: TextStyle(
              fontSize: 30
            ),),
            Text('Signed in to Continue...', style: TextStyle(
              fontSize: 14,
              color: Colors.grey
            ),),
            SizedBox(height: 60,),
            Text('Username', style: TextStyle(
              fontSize: 20,
            ),),
            TextField(
              decoration: InputDecoration(
                hintText: 'John Doe'
              ),
              style: TextStyle(
                fontSize: 16
              ),
            ),
            SizedBox(height: 40,),
            Text('Password', style: TextStyle(
              fontSize: 20,
            ),),
            TextField(
              obscureText: _isObscurePassword,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscurePassword ? Icons.visibility : Icons.visibility_off
                  ),
                  onPressed: (){
                    setState(() {
                      _isObscurePassword = !_isObscurePassword;                      
                    });
                  },
                )
              ),
              style: TextStyle(
                fontSize: 16
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: openForgotPassword,
                  child: Text('Forgot Password', style: TextStyle(
                    fontSize: 16
                  ),),
                )
              ],
            ),
            Expanded(
              child: Center(
                child: GestureDetector(
                  onTap: openHome,
                  child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 130, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    color: Colors.red[400]
                  ),
                  child: Text('Sign In', style: TextStyle(
                    fontSize: 16,
                    color: Colors.white
                  ),),
                ),
                ),
                
              ),
            )
          ],
        ),
      ),
    );
  }

  void openOnBoard(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> OnBoarding()));
  }
  void openForgotPassword(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPassword()));
  }

  void openHome(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
  }
}