import 'package:flutter/material.dart';
import 'onboarding.dart';

class Register extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Registers(),
    );
  }
}

class Registers extends StatefulWidget {

  @override
  _RegistersState createState() => _RegistersState();
}

class _RegistersState extends State<Registers> {
bool _isObscurePassword = true;
bool _isObscurePasswordConfirmation = true;
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
        padding: EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Text('Welcome !!!', style: TextStyle(
              fontSize: 30
            ),),
            Text('Signed up to Continue...', style: TextStyle(
              fontSize: 14,
              color: Colors.grey
            ),),
            SizedBox(height: 50,),
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
            SizedBox(height: 35,),
            Text('Password', style: TextStyle(
              fontSize: 20,
            ),),
            TextFormField(
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
            SizedBox(height: 35,),
            Text('Password Confirmation', style: TextStyle(
              fontSize: 20,
            ),),
            TextField(
              obscureText: _isObscurePasswordConfirmation,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscurePasswordConfirmation ? Icons.visibility : Icons.visibility_off
                  ),
                  onPressed: (){
                    setState(() {
                      _isObscurePasswordConfirmation = !_isObscurePasswordConfirmation;                      
                    });
                  },
                )
              ),
              style: TextStyle(
                fontSize: 16
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: Center(
                child: GestureDetector(
                  onTap: registerFunction,
                  child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 130, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    color: Colors.red[400]
                  ),
                  child: Text('Sign Up', style: TextStyle(
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
  registerFunction(){}
}