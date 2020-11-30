import 'package:flutter/material.dart';
import 'package:minimart/model/user_model.dart';
import 'package:minimart/screen/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter",
        style: TextStyle(
          fontSize: 18.0,
        ),),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
              child: Text("Sign Up",
              style: TextStyle(
                fontSize: 15.0,
              ),),
              textColor: Colors.white,
              onPressed: (){ // after signup, user is logged in: pushReplacement
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignupScreen())
                );
              },)
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          if(model.isLoading)
            return Center(child: CircularProgressIndicator(),);
          return Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
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
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: (){},
                  child: Text('Forgot your password?',
                    textAlign: TextAlign.right,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
              SizedBox(height: 16.0,),
              SizedBox(
                height: 48.0,
                child: RaisedButton(
                    child: Text('Log In',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: (){
                      if (_formKey.currentState.validate()){
                      }
                      model.signIn();

                    }),
              ),
            ],
          ),
        );
      } // builder
    )
    );
  }
}
