
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = new GlobalKey<FormState>();
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  FocusNode focus;
  @override
  void initState() {
    super.initState();
    focus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    focus.dispose();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.white,
     body: Stack(
       alignment: Alignment.center,
       children: <Widget>[_showBody(context)],
     ));
  }
  Widget _showBody(context) {
    return new Container(
      alignment: Alignment.center,
      child: new Form(
        key: _formKey,
        child: new SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
          child: Column(
            children: <Widget>[
              _logoImage(),
              _showUserName(),
              _showPassword(),
              _showBtnLogin(),
            ],
          ),
        ),
      ));
  }
  Widget _logoImage() {
    return Container(
      margin: EdgeInsets.only(bottom: 64.0),
      alignment: Alignment.center,
      child: Image(
        image: AssetImage("assets/flutter_logo.png"),

      ),
    );
  }
  Widget _showUserName() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: new TextFormField(
        controller: userNameController,
        maxLines: 1,
        cursorColor: Colors.lightBlue,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.go,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16.0,
          color: Colors.black,
          fontFamily: 'Montserrat'),
        decoration: new InputDecoration(
          border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.grey[300]),
          ),
          labelStyle: TextStyle(color: Colors.grey),
          labelText: "userName",
        ),
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(focus);
        },
        validator: (value) {
          //RegExp regex = new RegExp(pattern);
          if (value.isEmpty) {
            return "User name should not be empty";
          } //else if (!regex.hasMatch(value)) {
          //return "Invalid email address";
          //}
          return null;
        },
        onSaved: (value) => userNameController.text = value,
      ),
    );
  }
  Widget _showPassword() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: new TextFormField(
        controller: passwordController,
        maxLines: 1,
        cursorColor: Colors.lightBlue,
        obscureText: true,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16.0,
          color: Colors.black,
          fontFamily: 'Montserrat'),
        decoration: new InputDecoration(
          border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.grey[300]),
          ),
          labelStyle: TextStyle(color: Colors.grey),
          labelText: "Password",
        ),
        focusNode: focus,
        validator: (value) {
          if (value.isEmpty) {
            return "Password should not be empty";
          } else if (value.length < 8) {
            return "Password should have more than 8 characters";
          }
          return null;
        },
        onSaved: (value) => passwordController.text = value,
      ),
    );
  }
  Widget _showBtnLogin() {
    return Padding(
      padding: EdgeInsets.only(left: 56.0, right: 56.0, bottom: 16.0, top: 16.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 56.0,
        decoration: BoxDecoration(
          borderRadius: new BorderRadius.circular(30.0),
        ),
        child: new Material(
          child: MaterialButton(
            child: Text(
              "Login",
              style: Theme.of(context).textTheme.button.copyWith(
                color: Colors.white,
                fontSize: 18.0,
                fontFamily: 'Montserrat'),
            ),
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              _validateAndSave(context);
            },
            highlightColor: Colors.black54,
            splashColor: Colors.black87,
          ),
          color: Colors.black87,
          borderRadius: new BorderRadius.circular(0.0),
        ),
      ),
    );
  }
  Future<bool> _validateAndSave(context) async {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      if (userNameController.text == "username" &&
        passwordController.text == "password!23") {
        setIsLogin();
        Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
        Toast.show("Login successfully!", context);
      } else {
        Toast.show("Invalid credentials", context);
      }

      return true;
    }

    return false;
  }
  setIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', true);
  }

}
