import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Sign Up",
          style: TextStyle(
            fontSize: 18.0,
          ),),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'Full Name'
              ),
              validator: (text){
                // ignore: missing_return
                if( text.isEmpty ) return "Invalid Name";
              },
            ),
            SizedBox(height: 16.0,),
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'E-mail'
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (text){
                // ignore: missing_return
                if( text.isEmpty || !text.contains("@")) return "Invalid E-mail";
              },
            ),
            SizedBox(height: 16.0,),
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'Password'
              ),
              obscureText: true,
              validator: (text){
                if ( text.isEmpty || text.length < 6) return "Invalid Password";
              },
            ),
            SizedBox(height: 16.0,),
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'Addess'
              ),
              validator: (text){
                if ( text.isEmpty) return "Invalid Address";
              },
            ),

            SizedBox(height: 16.0,),

            SizedBox(
              height: 48.0,
              child: RaisedButton(
                  child: Text('Sign Up',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  onPressed: (){
                    if (_formKey.currentState.validate()){
                    }

                  }),
            ),
          ],
        ),
      ),
    );
  }
}
