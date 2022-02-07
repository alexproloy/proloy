import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:proloy/const/appcolor.dart';
import 'package:proloy/const/custombutton.dart';
import 'package:proloy/ui/loginpage.dart';
import 'package:proloy/ui/userform.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class registration extends StatefulWidget {
  const registration({ Key? key }) : super(key: key);

  @override
  _registrationState createState() => _registrationState();
}

class _registrationState extends State<registration> {
  @override
  final _formkeys = GlobalKey <FormState>();
  final passwordValidator = MultiValidator([  
    RequiredValidator(errorText: 'password is required'),  
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),  
    PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')  
 ]);


  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  signup () async{
    try {
  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: _emailController.text,
    password: _passwordController.text,
  );
  var autoCredential = userCredential.user;
  print(autoCredential!.uid);
  if(autoCredential.uid.isNotEmpty){
    Navigator.push(context, MaterialPageRoute(builder: (_)=>Userwidget()));
  }
  else{
    Fluttertoast.showToast(msg: "Something went wrong");
  }
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    // print('The password provided is too weak.');
    Fluttertoast.showToast(msg: "The password provided is too weak");
  } else if (e.code == 'email-already-in-use') {
    // print('The account already exists for that email.');
    Fluttertoast.showToast(msg: "The account already exists for that email");
  }
} catch (e) {
  print(e);
}
  }
  Widget build(BuildContext context) {
    String password;
    return Scaffold(
      
      backgroundColor: appcolor.mycolor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 150.h,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 22.sp,color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: ScreenUtil().screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28.r),
                    topRight: Radius.circular(28.r),
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Form(
                      autovalidateMode: AutovalidateMode.always,
                      key: _formkeys,
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Text("Welcome to Sign Up",
                        style: TextStyle(
                          fontSize: 22.sp,color: appcolor.mycolor
                        ),
                        ),
                        Text("Glad to see you",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Color(0xFFBBBBBB),
                        ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 48.h,
                              width: 41.h,
                              decoration: BoxDecoration(
                                color: appcolor.mycolor,
                                borderRadius: BorderRadius.circular(12.r)
                              ),
                              child: Center(
                                child: Icon(Icons.email_outlined,
                                color: Colors.white,
                                size: 20.h,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(child: TextFormField(
                              validator: EmailValidator(errorText:"Enter a valid email"
                              ),
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: "Enter your Email Address",
                                hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color(0xFF414041),
                                ),
                                labelText: "Email",
                                labelStyle: TextStyle(
                                  fontSize: 15.sp,
                                  color: appcolor.mycolor
                                ),
                              ),
                            ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 48.h,
                              width: 41.h,
                              decoration: BoxDecoration(
                                color: appcolor.mycolor,
                                borderRadius: BorderRadius.circular(12.r)
                              ),
                              child: Center(
                                child: Icon(Icons.lock_outlined,
                                color: Colors.white,
                                size: 20.w,
                                ),
                                ),
                             ),
                             SizedBox(
                               width: 10.w,
                             ),
                             Expanded(child: TextFormField(
                               controller: _passwordController,
                               obscureText: _obscureText,
                            decoration: InputDecoration(
                              hintText: "Password must be 8 character",
                              hintStyle: TextStyle(
                                fontSize: 14.sp,
                                color: Color(0xFF414041),
                              ),
                              labelText: "Password",
                              labelStyle: TextStyle(
                                fontSize: 15.sp,
                                color: appcolor.mycolor,
                              ),
                              suffixIcon: _obscureText == true
                                        ? IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _obscureText = false;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.remove_red_eye,
                                              size: 20.w,
                                            ))
                                        : IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _obscureText = true;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.visibility_off,
                                              size: 20.w,
                                            ),
                                            ),
                            ),
                          ),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   width: 1.sw,
                      //   height: 56.w,
                      //   child: ElevatedButton(onPressed: (){
                      //     if(_formkeys.currentState!.validate()){
                      //       return signup();
                      //     }
                      //   },
                      //    child: Text("Sing up",style: TextStyle(
                      //      color: Colors.white,
                      //      fontSize: 18.w
                      //    ),
                      //    ),
                      //    style: ElevatedButton.styleFrom(
                      //      primary: appcolor.mycolor,elevation: 3),
                         
                      //    ),
                      // ),
                      CustomButton("Sign Up", (){
                        if (_formkeys.currentState!.validate()){
                          return signup();
                        }
                      }),
                      SizedBox(
                        height: 20.h,
                      ),
                      Wrap(
                        children: [
                          Text("Already have an account?",
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          GestureDetector(
                            child: Text("Sing in",style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: appcolor.mycolor,
                            ),
                            ),
                            onTap: (){
                              Navigator.push(context, 
                              MaterialPageRoute(builder: (context) => Loginwidget()));
                            },
                          ),
                        ],
                      )
                      ],
                                      ),
                    ),
                 ),
                ),
              ),
              ),
            ],
           ),
         ),
       );
    }
}