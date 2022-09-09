import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> loginPage = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool checkBoxVal = false;
  String? checkPassword;

  String? checkEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: loginPage,
            child: Column(
              children: [
                Image.asset("assets/images/login.png"),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (val) {
                    if (val != checkEmail) {
                      return "Please Enter Valid Email";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    Global.email = val;
                  },
                  controller: emailController,
                  decoration:
                      textFieldDecoration(Icons.email, "Enter Email", "Email"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (val) {
                    if (val != checkPassword) {
                      return "Please Enter Valid Password";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    Global.password = val;
                  },
                  controller: passwordController,
                  obscureText: true,
                  decoration: textFieldDecoration(
                      Icons.lock, "Enter Password", "Password"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    checkEmail = prefs.getString("email");
                    checkPassword = prefs.getString("password");

                    if (loginPage.currentState!.validate()) {
                      loginPage.currentState!.save();

                      Navigator.of(context).pushReplacementNamed("/");

                      prefs.setBool("isLogin", true);
                      prefs.setBool("isRemember", checkBoxVal);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(140, 45),
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text("Remember me Login"),
                    Checkbox(
                        value: checkBoxVal,
                        onChanged: (val) {
                          setState(() {
                            checkBoxVal = val!;
                          });
                        })
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  textFieldDecoration(icon, hint, label) {
    return InputDecoration(
      prefixIcon: Icon(icon),
      hintText: hint,
      label: Text(label),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}
