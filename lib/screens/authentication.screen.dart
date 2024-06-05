
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../Provider/auth.provider.dart';
import '../Utils/toast.dart';
import '../components/custom_ElevatedButton.dart';
import '../components/custom_InputTextField.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});
  static const pageName = '/authentication';
  @override
  State<AuthenticationScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<AuthenticationScreen> {
  // Variable to store the selected tab
  late int _selectedTabIndex;

  @override
  // Callback function to be called when a tab is selected
  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final arguments = (ModalRoute.of(context)?.settings.arguments ?? 0) as int;
    setState(() {
      _selectedTabIndex = arguments;
    });
    print(arguments);
    print(_selectedTabIndex);
    return Scaffold(
      backgroundColor: const Color(0xFF1C2129),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 40),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/onlylogo.png',
                    height: 50.h,
                    fit: BoxFit.fitWidth,
                  ),
                  Image.asset(
                    'assets/images/logotext.png',
                    height: 50.h,
                    fit: BoxFit.fitWidth,
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  initialIndex: arguments,
                  child: Column(
                    children: [
                      TabBar(
                        dividerHeight: 0,
                        indicator: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .secondary, // Set the background color of the selected tab
                          borderRadius: BorderRadius.circular(
                              50), // Optional: Set border radius
                        ),
                        tabs: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: Text(
                              'Login',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: Text('Sign Up',
                                style:
                                Theme.of(context).textTheme.displayLarge),
                          )
                        ],
                        onTap: (index) {
                          // Call the callback function with the selected tab index
                          _onTabSelected(index);
                        },
                      ),
                      const Expanded(
                        child: TabBarView(
                          children: [


                            LoginPage(),
                            // // SignUp
                            SignUpPage(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController(),
      _emailController = TextEditingController();

  void _togglePasswordVisibility() {
    if (mounted) {
      setState(() {
        _obscureText = !_obscureText;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    final provider = Provider.of<AuthProvider>(context);
    return Container(
      width: double.infinity,
      // height: 600,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/logo.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.1),
              Theme.of(context).primaryColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.center,
            stops: const [0.0, 0.9],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Center(
                  child: Text("Login",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 24, fontWeight: FontWeight.w700)),
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomInputField(
                  validator: (v) {
                    if (v!.isEmpty ||
                        !v.contains(RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        ))) {
                      return 'Please Enter Valid Email';
                    }
                    return null;
                  },
                  obscureText: false,
                  controller: _emailController,
                  hint: 'Email',
                  icon: Icons.mail_outlined,
                  isPassword: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomInputField(
                  validator: (v) {
                    if (v!.isEmpty || v.length < 6) {
                      return 'Please Enter Valid Password';
                    }
                    return null;
                  },
                  hint: 'Password',
                  icon: Icons.safety_check,
                  controller: _passwordController,
                  obscureText: _obscureText,
                  onPressed: _togglePasswordVisibility,
                  isPassword: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                AnimatedCrossFade(
                    firstChild: CustomElevatedButton(
                      // onPressed: () {
                      //   if (_formKey.currentState!.validate()) {
                      //     FocusScope.of(context).unfocus();
                      //     Navigator.pushReplacementNamed(context, MainActivity.pageName);
                      //     // _logIn(
                      //     //     password:
                      //     //         _passwordController.text.trim(),
                      //     //     email: _emailController.text.trim());
                      //   }
                      //   return;
                      // },
                        onPressed: () {
                          provider.loginUser(
                              email: _emailController.text,
                              password: _passwordController.text,
                              context: context);
                        },
                        text: 'Login',
                        width: size.width),
                    secondChild: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    crossFadeState: provider.isButtonLoading
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 1))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _email = TextEditingController(),
      _name = TextEditingController(),
      _password = TextEditingController(),
      _confirmPassword = TextEditingController(),
      _userName = TextEditingController(),
      _registerationNo = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _usernamerex =
  RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$"),
      _registerrex = RegExp(r"^[A-Za-z0-9 ]");

  bool _obscureText = true;

  // SignUpModel modal = SignUpModel();
  String cp = '';

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    final provider = Provider.of<AuthProvider>(context);
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/logo.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor.withOpacity(0.1),
                Theme.of(context).primaryColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.center,
              stops: const [0.0, 0.9],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  Center(
                    child: Text("SignUp",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 24, fontWeight: FontWeight.w700)),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Column(
                    children: [
                      CustomInputField(
                        validator: (v) {
                          if (v!.isNotEmpty || _usernamerex.hasMatch(v)) {
                            return null;
                          }
                          return 'Please Enter Valid User Name';
                        },
                        controller: _userName,
                        hint: 'Username',
                        icon: Icons.person_2_outlined,
                        isPassword: false,
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomInputField(
                        validator: (v) {
                          if (v!.isEmpty || v.length < 3) {
                            return 'Please Enter Valid Name';
                          }
                          return null;
                        },
                        controller: _name,
                        hint: "Name",
                        icon: Icons.person_2_outlined,
                        isPassword: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomInputField(
                        validator: (v) {
                          if (v!.isEmpty ||
                              !v.contains(RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                              ))) {
                            return 'Please Enter Valid Email';
                          }
                          return null;
                        },
                        controller: _email,
                        icon: Icons.mail_outline,
                        hint: 'Email',
                        isPassword: false,
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomInputField(
                        validator: (v) {
                          if (v!.isEmpty || v.length < 6) {
                            return 'Please Enter Valid Password';
                          }
                          return null;
                        },
                        controller: _password,
                        icon: Icons.safety_check_sharp,
                        isPassword: true,
                        obscureText: _obscureText,
                        hint: 'Password',
                        onPressed: _togglePasswordVisibility,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomInputField(
                        validator: (v) {
                          if (v != _password.text) {
                            return 'Confirm Password don\'t Match';
                          }
                          return null;
                        },
                        isPassword: true,
                        obscureText: _obscureText,
                        onPressed: _togglePasswordVisibility,
                        controller: _confirmPassword,
                        hint: 'Confirm Password',
                        icon: Icons.safety_check,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomInputField(
                        validator: (v) {
                          if (v!.isEmpty || _registerrex.hasMatch(v)) {
                            return null;
                          }
                          return 'Please Enter Valid Company Registration Number';
                        },
                        controller: _registerationNo,
                        hint: 'Company Registration Number/UTR',
                        icon: Icons.horizontal_split,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AnimatedCrossFade(
                      firstChild: CustomElevatedButton(
                        onPressed: () {
                          provider.registerUser(

                              email: _email.text,
                              username: _userName.text,

                              password: _password.text,

                              context: context);
                        },
                        text: 'Sign Up',
                        width: size.width,
                      ),
                      secondChild: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      crossFadeState: provider.isButtonLoading
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 1)),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}