import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Homescreen.dart';


class signinscreen extends StatefulWidget {
  const signinscreen({Key? key}) : super(key: key);

  @override
  State<signinscreen> createState() => _signinscreenState();
}

class _signinscreenState extends State<signinscreen> {

  TextEditingController useremailController = TextEditingController();

  TextEditingController userpasswordController = TextEditingController();
  bool _obscured = false;
  final textFieldFocusNode = FocusNode();

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
      false; // Prevents focus if tap on eye
    });
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "New User ? ",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xffA29EB6),
                      fontSize: 16),
                ),
                SizedBox(
                  width: 6,
                ),
                InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => signupscreen()));
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.blue,
                          fontSize: 16),
                    )),
              ],
            ),
            //Text("Already have an account?",style: TextStyle(fontWeight: FontWeight.w500,color: Color(0xffA29EB6),fontSize: 16),),
            padding: EdgeInsets.only(left: 22,bottom: 30),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 55,
              ),
              child: Column(
                children: [

                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/appicon.png"),
                          fit: BoxFit.cover,
                        )),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, // Only allows digits to be entered
                    ],
                    controller: useremailController,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      //Hides label on focus or if filled
                      labelText: "Primary contact number",
                      filled: true,
                      // Needed for adding a fill color
                      //fillColor: Colors.grey.shade800,
                      isDense: true,
                      // Reduces height a bit
                      border: OutlineInputBorder(
                        // borderSide: BorderSide.none,              // No border
                        borderRadius:
                        BorderRadius.circular(12), // Apply corner radius
                      ),
                      prefixIcon: Icon(Icons.phone_android, size: 24),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),



                  TextField(
                    controller: userpasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obscured,
                    focusNode: textFieldFocusNode,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      //Hides label on focus or if filled
                      labelText: "Pin",
                      filled: true,
                      // Needed for adding a fill color
                      //fillColor: Colors.grey.shade800,
                      isDense: true,
                      // Reduces height a bit
                      border: OutlineInputBorder(
                        // borderSide: BorderSide.none,              // No border
                        borderRadius:
                        BorderRadius.circular(12), // Apply corner radius
                      ),
                      prefixIcon: Icon(Icons.lock_rounded, size: 24),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                        child: GestureDetector(
                          onTap: _toggleObscured,
                          child: Icon(
                            _obscured
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      //color: Colors.red,
                      child: Text(
                        "Forgot pin?",
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.blue),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17.0),
                              // side: BorderSide(color: Colors.red)
                            ))),
                        onPressed: () async {


                          print(useremailController.text);
                          print(userpasswordController.text);

                          signin(
                            useremailController.text,
                            userpasswordController.text,
                          );
                          // signUp(
                          //   useremailController.text,
                          //   userpasswordController.text,
                          // );
                          // SharedPreferences pref =
                          // await SharedPreferences.getInstance();
                          // pref.setString("email", useremailController.text);



                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  SizedBox(height: 24),

                  SizedBox(
                    height: 16,
                  ),

                ],
              ),
            ),
          )),
    );
  }

  signin(phone,password)  async{
    try {
      final Dio dio = Dio();

      dio.options.baseUrl = 'https://rid3240.avantikain.com/api/v1/app';
      dio.options.headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Cookie':
        'laravel_session=eyJpdiI6ImxWL0dpcHNwZFYvakh4ZDVGY1BrNVE9PSIsInZhbHVlIjoiK05mVTcrWWp0MzcyWWxzWkdqcTRZYmFBZEhmZW81YU9zaGZVR2FCSDVrT2E3WGhZR01iV1lVMStYdzNBY2dpWmVlSUtaUzlRL1luUXhibkh4NnJ0MTJEa01aakwvR1dYUVQ0RGR6ZHFTbUQ0QzM2OTIzZ3o4enVWUzdzVHNiODgiLCJtYWMiOiIzNDRiNzFmY2QxNjg2MjI5ZDliODNlZTQzNWU5ZWVmYzVlMzk1NzA1N2M5Y2I3YWJlMDI1MTAyMzU2NWQzMDQyIiwidGFnIjoiIn0%3D'
      };

      final FormData formData = FormData.fromMap({
        //'primary_contact': '7086035252',
        'primary_contact': phone,
        //'password': '12345678',
        'password': password,
      });

      final Response response = await dio.post('/login', data: formData);

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "You are successfully logged in ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>  HomeScreen())
        );
        print(response.data);
      } else {
        Fluttertoast.showToast(
          msg: "Server error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Invalid Id password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print('Error occurred: $e');
    }
  }


}




