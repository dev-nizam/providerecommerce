import 'dart:convert';
import 'package:ecommerce/ui/Authantication/Register.dart';
import 'package:ecommerce/ui/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? username, password;
  bool processing = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCounter();
  }
  void _loadCounter()async{
final prefs =await SharedPreferences.getInstance();
bool isLoggedIn=prefs.getBool("isLoggedIn")??false;
print("isLoggedIn"+isLoggedIn.toString());
if(isLoggedIn){
    Navigator.push(context, MaterialPageRoute(builder:(ctx)=>Home()));
}
  }
  login(String username,password )async{
    print("webservice");
    print(username);
    print(password);
    var result;
    final Map<String ,dynamic>loginData={
      
      "username":username,
      "password":password,
    };
    final response=await http.post(Uri.parse("https://bootcamp.cyralearnings.com/login.php"),
    body: loginData);
    print(response.statusCode);
    if(response.statusCode==200){
      if(response.body.contains("success")){
        print("login successfully completed");
        final prefs =await SharedPreferences.getInstance();
        prefs.setBool("isLoggedIn", true);
        prefs.setString("userName", username);
        Navigator.push(context, MaterialPageRoute(builder:(ctx)=>Home()));
      }else{
        print("login failed");
      }
    }else{
      result={print(json.decode(response.body)["error"].toString())};
    }return result;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Form(
        key: _formkey,
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Text(
              "Welcome Back",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Login with your username and password",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      decoration:
                          InputDecoration.collapsed(hintText: "username"),
                      onChanged: (text) {
                        setState(() {
                          username = text;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter your Username text";
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      decoration:
                          InputDecoration.collapsed(hintText: "password"),
                      onChanged: (text) {
                        setState(() {
                          password = text;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter your password text";
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width / 2,
                child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        primary: Colors.white,
                        backgroundColor: Colors.black),
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        print("username =" + username.toString());
                        print("password =" + password.toString());
                        login(username.toString(), password.toString());
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
              ),
            ),
            SizedBox(height: 20,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder:(ctx)=>RegistrationPage()));
                  },
                  child: Text(
                    "Go to registation",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
