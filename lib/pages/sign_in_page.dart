import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_firebase_ui/pages/sign_up_page.dart';
import 'package:instagram_firebase_ui/services/auth_service.dart';
import 'package:instagram_firebase_ui/services/pref_service.dart';
import '../services/utils_service.dart';

class SignInPage extends StatefulWidget {
  static const id = "/sign_in_page";
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void _callSignUpPage(){
    Navigator.pushReplacementNamed(context, SignUpPage.id);
  }
  
  void _doSignIn() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    
    if(email.isEmpty || password.isEmpty) {
      Utils.snackBar("Fields cannot be null or empty", context);
      return;
    }

    isLoading = true;
    setState(() {});

    await AuthService.signInUser(context, email, password)?.then((value) => _getFirebaseUser(value));
  }

  void _getFirebaseUser(User? user) {
    if(user != null) {
      HiveDB.storeUid(user.uid);
    } else {
      Utils.snackBar("Please check your entered data, Please try again!", context);
    }

    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Utils.initNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(193, 53, 132, 1),
                Color.fromRGBO(131, 58, 180, 1),
              ]
            )
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        const Text(
                          "Instagram",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 45,
                            fontFamily: "billabong",
                          ),
                        ),
                        const SizedBox(height: 20),

                        // #email
                        Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white54.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextField(
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: "Email",
                              border: InputBorder.none,
                              hintStyle: TextStyle(fontSize: 17, color: Colors.white54),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // #password
                        Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white54.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextField(
                            obscureText: true,
                            controller: passwordController,
                            textInputAction: TextInputAction.done,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: "Password",
                              border: InputBorder.none,
                              hintStyle: TextStyle(fontSize: 17, color: Colors.white54),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // #sign_in
                        GestureDetector(
                          onTap: _doSignIn,
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white54,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: const Center(
                              child: Text(
                                "Sign In",
                                style: TextStyle(fontSize: 17, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have a account? ", style: TextStyle(color: Colors.white, fontSize: 16),),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: _callSignUpPage,
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              isLoading
              ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

