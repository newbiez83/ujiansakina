import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rsusakina/screen/register.dart';

class SignInLogin extends StatefulWidget {
  const SignInLogin({super.key});

  @override
  State<SignInLogin> createState() => _SignInLoginState();
}

class _SignInLoginState extends State<SignInLogin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _passwordController = TextEditingController();

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 15), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  bool emailValidate(String email) {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }

  void _signInWithEmailAndPassword() async {
    try {
      final User? user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
      if (user!.emailVerified) {
        await user.sendEmailVerification();
      }
      // ignore: use_build_context_synchronously
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    } catch (e) {
      final snackBar = SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
            Text(" There was a problem signing you in"),
          ],
        ),
      );
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: Builder(
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  logo(size.height / 15, size.height / 5),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  richText(20.42),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Image.network(
                    'https://cdn-icons-png.flaticon.com/128/4003/4003791.png',
                    height: 80,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                    child: withEmailPassword(),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  buildFooter(size),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget welcomeText() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text.rich(
          TextSpan(
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.black,
              height: 1.59,
            ),
            children: const [
              TextSpan(
                text: 'RSU ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'SAKINA ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'IDAMAN',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget logo(double height_, double width_) {
    return Image.network(
      'https://sakinaidaman.com/wp-content/uploads/elementor/thumbs/Logo-Sakina-qqjll7myultpdn6rtvavxk7jvezwbfj3xjqi2n0jxw.png',
      height: height_,
      width: width_,
    );
  }

  Widget richText(double fontSize) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: fontSize,
          color: const Color(0xFF21899C),
          letterSpacing: 2.000000061035156,
        ),
        children: const [
          TextSpan(
            text: 'SILAHKAN ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: 'LOGIN',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFooter(Size size) {
    return Center(
      child: Column(
        children: [
          Text('Pilih Metode Login '),
          SizedBox(
            height: size.height * 0.03,
          ),
          SizedBox(
            width: size.width * 0.6,
            height: 44.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //facebook logo here
                Container(
                  alignment: Alignment.center,
                  width: 44.0,
                  height: 44.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: const Color.fromRGBO(246, 246, 246, 1)),
                  child: Image.network(
                    'https://cdn-icons-png.flaticon.com/128/281/281764.png',
                    width: 22.44,
                    height: 22.44,
                  ),
                ),
                const SizedBox(width: 16),

                //google logo here
                Container(
                  alignment: Alignment.center,
                  width: 44.0,
                  height: 44.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: const Color.fromRGBO(246, 246, 246, 1)),
                  child: Image.network(
                    // Group 59
                    'https://cdn-icons-png.flaticon.com/128/15047/15047435.png',
                    width: 22.92,
                    height: 22.92,
                  ),
                ),
                const SizedBox(width: 16),

                //apple logo here
                Container(
                  alignment: const Alignment(0.02, 0.04),
                  width: 44.0,
                  height: 44.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: const Color.fromRGBO(246, 246, 246, 1)),
                  child: Image.network(
                    'https://cdn-icons-png.flaticon.com/128/1240/1240942.png',
                    width: 18.62,
                    height: 22.92,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Belum Punya Akun ?',
                style: TextStyle(fontSize: 14),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: ((context) => Register())));
                },
                child: Text(
                  ' Silahkan Registrasi',
                  style: TextStyle(color: Colors.green, fontSize: 14),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget withEmailPassword() {
    return Form(
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              focusNode: f1,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: 'Email',
                hintStyle: TextStyle(
                  color: Colors.black26,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {
                f1.unfocus();
                FocusScope.of(context).requestFocus(f2);
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the Email';
                } else if (!emailValidate(value)) {
                  return 'Please enter correct Email';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 25.0,
            ),
            TextFormField(
              focusNode: f2,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              //keyboardType: TextInputType.visiblePassword,
              controller: _passwordController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: Colors.black26,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {
                f2.unfocus();
                FocusScope.of(context).requestFocus(f3);
              },
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value!.isEmpty) return 'Please enter the Passord';
                return null;
              },
              obscureText: true,
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Lupa Password ?',
                style: TextStyle(
                  fontSize: 14.0,
                  color: const Color(0xFF6A6F7D),
                ),
                textAlign: TextAlign.right,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 25.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  focusNode: f3,
                  onPressed: () async {
                    // if (_formKey.currentState!.validate()) {
                    showLoaderDialog(context);
                    _signInWithEmailAndPassword();
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    backgroundColor: Colors.green,
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
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
