import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_firebase_ui/pages/sign_in_page.dart';
import 'package:instagram_firebase_ui/services/auth_service.dart';
import 'package:instagram_firebase_ui/services/pref_service.dart';
import 'package:instagram_firebase_ui/services/utils_service.dart';

class SignUpPage extends StatefulWidget {
  static const id = "/sign_up_page";
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isLoading = false;

  void _signUp() async {
    String fullName = fullNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirm = confirmPasswordController.text.trim();

    if(fullName.isEmpty || email.isEmpty || password.isEmpty || confirm.isEmpty) {
      Utils.snackBar("Fields cannot be null or empty", context);
      return;
    }

    isLoading = true;
    setState(() {});

    await AuthService.signUpUser(context, fullName, email, password).then((user) => _checkNewUser(user));
  }

  void _checkNewUser(User? user)  {
    if(user != null) {
      HiveDB.storeUid(user.uid);
    } else {
      Utils.snackBar("Please check your entered data, Please try again!", context);
    }

    isLoading = false;
    setState(() {});
  }

  void _callSignInPage(){
    Navigator.pushReplacementNamed(context, SignInPage.id);
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

                        // #fullName
                        Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white54.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextField(
                            controller: fullNameController,
                            textInputAction: TextInputAction.next,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: "Full Name",
                              border: InputBorder.none,
                              hintStyle: TextStyle(fontSize: 17, color: Colors.white54),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

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

                       // #confirm password
                        Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white54.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextField(
                            obscureText: true,
                            controller: confirmPasswordController,
                            textInputAction: TextInputAction.done,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: "Confirm Password",
                              border: InputBorder.none,
                              hintStyle: TextStyle(fontSize: 17, color: Colors.white54),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // #sign_up
                        GestureDetector(
                          onTap: _signUp,
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
                                "Sign Up",
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
                      const Text("Already have a account? ", style: TextStyle(color: Colors.white, fontSize: 16),),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: _callSignInPage,
                        child: const Text(
                          "Sign In",
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
