import 'package:flutter/material.dart';
import 'package:minimart/model/user_model.dart';
import 'package:minimart/screen/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _emailController    =   TextEditingController();
  final _passController     =   TextEditingController();
  final _formKey            =   GlobalKey<FormState>();
  final _scaffoldKey        =   GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                controller: _emailController,
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
                controller: _passController,
                decoration: InputDecoration(
                    hintText: 'Password'
                ),
                obscureText: true,
                validator: (text){
                  // ignore: missing_return
                  if ( text.isEmpty || text.length < 6) return "Invalid Password";
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: (){
                    if (_emailController.text.isEmpty)
                    _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text("Please inform your email to recover password!"),
                          backgroundColor: Theme.of(context).errorColor,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    else{
                      model.recoverPass(_emailController.text);

                    _scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        content: Text("Check your Email inbox!"),
                        backgroundColor: Theme.of(context).primaryColor,
                        duration: Duration(seconds: 2),
                      ),
                    );
                    }
                  },
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
                      model.signIn(
                        email: _emailController.text,
                        pass: _passController.text,
                        onSuccess: _onSuccess,
                        onFail: _onFail
                      );

                    }),
              ),
            ],
          ),
        );
      } // builder
    )
    );
  }

  void _onSuccess(){
    Navigator.of(context).pop();
    //copied from signUp
    // _scaffoldKey.currentState.showSnackBar(
    //   SnackBar(
    //     content: Text("User created successfully!"),
    //     backgroundColor: Theme.of(context).primaryColor,
    //     duration: Duration(seconds: 2),
    //   ),
    // );
    // Future.delayed(Duration(seconds: 2)).then((_){
    //   Navigator.of(context).pop();
    // });
  }

  void _onFail(){
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Cannot login! Maybe it's the Password!"),
        backgroundColor: Theme.of(context).errorColor,
        duration: Duration(seconds: 2),
      ),
    );
  }



}
