
import 'dart:convert';
import 'package:ecommerce/ui/Authantication/logi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String? name,phone,address,username, password;
  bool processing = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  registration(String name, phone,address,username,password )async{
    print("webservice");
    print(username);
    print(password);
    var result;
    final Map<String ,dynamic>registerData={
      "name":name,
      "phone":phone,
      "address":address,
      "username":username,
      "password":password,
    };
    final response=await http.post(Uri.parse("https://bootcamp.cyralearnings.com/registration.php"),
    body: registerData);
    print(response.statusCode);
    if(response.statusCode==200){
      if(response.body.contains("success")){
        print("registration successfully completed");
        Navigator.push(context, MaterialPageRoute(builder:(ctx)=>LoginPage()));
      }else{
        print("regitration failed");
      }
    }else{
      result={print(json.decode(response.body)["error"].toString())};
    }return result;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            children: [
               SizedBox(
                  height: 50,
                ),
                Text(
                  "Register Account",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "complete you details",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 28,
                ),
              Form(
        key: _formkey,
        child: Column(
              children: [  
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
                              InputDecoration.collapsed(hintText: "Name"),
                          onChanged: (text) {
                            setState(() {
                              name = text;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter your name text";
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
                          keyboardType: TextInputType.phone,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          decoration:
                              InputDecoration.collapsed(hintText: "Phone"),
                          onChanged: (text) {
                            setState(() {
                              phone = text;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter your phone ";
                            }else if(value.length>10 || value.length<10){
                              return "please enter valid phone number";
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
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: TextFormField(
                          maxLines: 4,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          decoration:
                              InputDecoration.collapsed(hintText: "Address"),
                          onChanged: (text) {
                            setState(() {
                              address = text;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter your address text";
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
                              InputDecoration.collapsed(hintText: "Username"),
                          onChanged: (text) {
                            setState(() {
                              username = text;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter your username text";
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
                              InputDecoration.collapsed(hintText: "Password"),
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
                    width: MediaQuery.of(context).size.width ,
                    child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            primary: Colors.white,
                            backgroundColor: Colors.black),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            print("name =" + name.toString());
                            print("phone =" + phone.toString());
                            print("address =" + address.toString());
                            print("username =" + username.toString());
                            print("password =" + password.toString());
                             registration( name!, phone,address,username,password );
                          }
                          
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                  ),
                ),
                SizedBox(height: 20,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Do you have an account?",
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder:(ctx)=>LoginPage()));
                      },
                      child: Text(
                        "Login",
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
      ),
            ],
          )),
    );
  }
}
