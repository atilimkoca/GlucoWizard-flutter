import 'package:another_flushbar/flushbar.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/dropdown_alert.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:email_validator/email_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glucowizard_flutter/providers/language_provider.dart';
import 'package:glucowizard_flutter/providers/register_provider.dart';
import 'package:glucowizard_flutter/views/home_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../providers/login_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    errorAlert(String text) {
      Flushbar(
        icon: const Icon(Icons.error),
        duration: const Duration(seconds: 3),
        title: '',
        message: text,
        backgroundGradient:
            const LinearGradient(colors: [Colors.red, Colors.orange]),
        backgroundColor: Colors.red,
        boxShadows: const [
          BoxShadow(
            color: Colors.red,
            offset: Offset(0.0, 2.0),
            blurRadius: 3.0,
          )
        ],
      ).show(context);
    }

    successAlert(String text) {
      Flushbar(
        icon: const Icon(Icons.check),
        duration: const Duration(seconds: 3),
        title: "Hey Ninja",
        message: text,
        backgroundGradient:
            const LinearGradient(colors: [Colors.green, Colors.teal]),
        backgroundColor: Colors.green,
        boxShadows: const [
          BoxShadow(
            color: Colors.green,
            offset: Offset(0.0, 2.0),
            blurRadius: 3.0,
          )
        ],
      ).show(context);
    }

    var verified = false;
    var recoverStatus = false;
    var process = 'none';
    var registerStatus = false;
    var loginStatus = false;
    var status;
    var googleSign = false;
    FirebaseAuth auth = FirebaseAuth.instance;

    Future<void> signInWithGoogle() async {
      try {
        context.read<LoginPageProvider>().setLogin(true);
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        // Obtain the auth details from the request
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        // Once signed in, return the UserCredential
        await FirebaseAuth.instance.signInWithCredential(credential);
        context.read<LoginPageProvider>().setUserId(auth.currentUser!.uid);
      } catch (e) {
        context.read<LoginPageProvider>().setLogin(false);
      }
      // Trigger the authentication flow
    }

    Future<String?>? _recoverPassword(String p1) async {
      try {
        process = 'recover';
        recoverStatus = true;
        var _userCredential = await auth.sendPasswordResetEmail(email: p1);
        var test = _userCredential;
      } catch (e) {
        recoverStatus = false;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    }

    Future<String?>? _signupUser(SignupData p1) async {
      try {
        process = 'register';
        registerStatus = true;
        loginStatus = false;
        var _userCredential = await auth.createUserWithEmailAndPassword(
            email: p1.name!, password: p1.password!);
        status = _userCredential.credential;
        var currentUser = _userCredential.user;
        context.read<RegisterPageProvider>().addUser(auth.currentUser!.uid);
        if (!currentUser!.emailVerified) {
          await _userCredential.user!.sendEmailVerification();
        } else {
          verified = true;
        }
      } catch (e) {
        registerStatus = false;
        print('here2');
      }
    }

    Future<String?>? _authUser(LoginData p1) async {
      try {
        process = 'login';
        loginStatus = true;
        registerStatus = false;
        var _userCredential = await auth.signInWithEmailAndPassword(
            email: p1.name, password: p1.password);
        status = _userCredential;
        var currentUser = _userCredential.user;
        if (!currentUser!.emailVerified) {
        } else {
          verified = true;
          context.read<LoginPageProvider>().setUserId(auth.currentUser!.uid);
        }
      } catch (e) {
        print('here');
        loginStatus = false;
      }
    }

    const users = {
      'atilimkoca44@gmail.com': '123456',
      'hunter@gmail.com': 'hunter',
    };
    print(users.keys.first);
    return FlutterLogin(
      loginProviders: <LoginProvider>[
        LoginProvider(
          icon: FontAwesomeIcons.google,
          label: 'Google',
          callback: () async {
            await signInWithGoogle();
          },
        ),
        LoginProvider(
            callback: () {}, icon: FontAwesomeIcons.person, label: 'offline')
      ],
      navigateBackAfterRecovery: false,
      savedEmail: users.keys.first.toString(),
      savedPassword: users.values.first.toString(),
      title: 'GlucoWizard',
      logo: const AssetImage('assets/images/wizard-hat.png'),
      onLogin: _authUser,
      onSignup: _signupUser,
      disableCustomPageTransformer: true,
      messages: LoginMessages(
        recoverCodePasswordDescription: 'test',
        recoverPasswordSuccess:
            AppLocalizations.of(context)!.recoverPasswordSuccess,
        passwordHint: AppLocalizations.of(context)!.password,
        forgotPasswordButton: AppLocalizations.of(context)!.forgot_password,
        loginButton: AppLocalizations.of(context)!.login,
        signupButton: AppLocalizations.of(context)!.register,
        confirmPasswordError: AppLocalizations.of(context)!.password_match,
        confirmPasswordHint: AppLocalizations.of(context)!.confirm_password,
        recoverPasswordButton: AppLocalizations.of(context)!.resetPassword,
        goBackButton: AppLocalizations.of(context)!.back,
        recoverPasswordIntro:
            AppLocalizations.of(context)!.recoverPasswordIntro,
      ),
      userValidator: (value) {
        final bool isValid = EmailValidator.validate(value!);

        print('Email is valid? ' + (isValid ? 'yes' : 'no'));
        if (value.isEmpty) {
          return AppLocalizations.of(context)!.empty_email;
        } else if (!isValid) {
          return AppLocalizations.of(context)!.invalid_email;
        }

        return null;
      },
      passwordValidator: (value) {
        if (value!.isEmpty) {
          return AppLocalizations.of(context)!.empty_password;
        } else if (value.length < 6) {
          return AppLocalizations.of(context)!.short_password;
        }

        return null;
      },
      onRecoverPassword: _recoverPassword,
      onSubmitAnimationCompleted: () {
        var loginProvider =
            Provider.of<LoginPageProvider>(context, listen: false);
        if (loginProvider.isLogin!) {
          googleSign = false;
          print('here*********');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else {
          print(GoogleSignIn().currentUser);
          if (process == 'register') {
            if (!registerStatus) {
              print('object');

              registerStatus = false;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
              errorAlert(AppLocalizations.of(context)!.register_error);
              //showAlert(AppLocalizations.of(context)!.register_error,TypeAlert.error);
            } else if (registerStatus) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
              successAlert(AppLocalizations.of(context)!.register_success);
              //showAlert(AppLocalizations.of(context)!.register_success, TypeAlert.success);
            }
          } else if (process == 'login') {
            if (!loginStatus) {
              print('object');

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
              errorAlert(AppLocalizations.of(context)!.register_error);
              //showAlert(AppLocalizations.of(context)!.login_error, TypeAlert.error);
            } else if (loginStatus && verified) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            } else if (loginStatus && !verified) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
              errorAlert(AppLocalizations.of(context)!.register_error);
              //showAlert(AppLocalizations.of(context)!.email_not_verified, TypeAlert.error);
            } else if (process == 'recover') {
              if (!recoverStatus) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
                errorAlert(AppLocalizations.of(context)!.register_error);
                //showAlert(AppLocalizations.of(context)!.recoverPasswordFailed,  TypeAlert.error);
              } else if (recoverStatus) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
                successAlert(AppLocalizations.of(context)!.register_error);
                //showAlert(AppLocalizations.of(context)!.recoverPasswordSuccess, TypeAlert.success);
              }
            }
          }
        }
      },
    );
  }
}
