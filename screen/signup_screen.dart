import 'package:flutter/material.dart';
import 'package:minimart/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignupScreen extends StatefulWidget {

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController     =   TextEditingController();
  final _emailController    =   TextEditingController();
  final _passController     =   TextEditingController();
  final _addressController  =   TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Sign Up",
          style: TextStyle(
            fontSize: 18.0,
          ),),
        centerTitle: true,
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
                  controller:  _nameController,
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
                    if ( text.isEmpty || text.length < 6) return "Invalid Password";
                  },
                ),
                SizedBox(height: 16.0,),
                TextFormField(
                  controller:  _addressController,
                  decoration: InputDecoration(
                      hintText: 'Address'
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
                          Map<String, dynamic> userData = {
                            "name": _nameController.text,
                            "email": _emailController.text,
                            "address": _addressController.text,
                          };

                          model.signUp(
                              userData: userData,
                              pass: _passController.text,
                              onSuccess: _onSuccess,
                              onFail: _onFail
                          );
                        }

                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSuccess(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("User created successfully!"),
          backgroundColor: Theme.of(context).primaryColor,
          duration: Duration(seconds: 2),
        ),
    );
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });
  }

  void _onFail(){
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Cannot create user! Maybe user already exists!"),
        backgroundColor: Theme.of(context).errorColor,
        duration: Duration(seconds: 2),
      ),
    );
  }


}
