import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_shop/bloc/authentication/auth_bloc.dart';
import 'package:flutter_ecommerce_shop/bloc/authentication/auth_event.dart';
import 'package:flutter_ecommerce_shop/bloc/authentication/auth_state.dart';
import 'package:flutter_ecommerce_shop/constants/colors.dart';
import 'package:flutter_ecommerce_shop/screens/dashbord_screen.dart';
import 'package:flutter_ecommerce_shop/screens/register_screen.dart';
import 'package:flutter_ecommerce_shop/widgets/loading_animatin.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const ViewContainer(),
    );
  }
}

class ViewContainer extends StatefulWidget {
  const ViewContainer({super.key});

  @override
  State<ViewContainer> createState() => _ViewContainerState();
}

class _ViewContainerState extends State<ViewContainer> {
  final _usernameTextController = TextEditingController(text: 'mobin');
  final _passwordTextController = TextEditingController(text: '12345678');
  bool _isHideNumber = true;
  bool _isType = true;
  bool _isTextUsernameEmpty = false;
  bool _isTextpasswordEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Image.asset(
                  'images/login_photo.jpg',
                  height: 200,
                ),
                const Text(
                  'ورود به اپلیکیشن ',
                  style: TextStyle(
                    fontFamily: 'dana',
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'نام کاربری:',
                        style: TextStyle(
                          fontFamily: 'dana',
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [
                          TextField(
                            onChanged: (value) {
                              if (value.length >= 1) {
                                setState(() {
                                  _isType = true;
                                  _isTextUsernameEmpty = false;
                                });
                              } else {
                                setState(() {
                                  _isType = false;
                                  _isTextUsernameEmpty = true;
                                });
                              }
                            },
                            controller: _usernameTextController,
                            decoration: InputDecoration(
                              errorText: _isTextUsernameEmpty
                                  ? 'لطفا مقادیر مورد نیاز را پر کنید'
                                  : null,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              labelStyle: const TextStyle(
                                fontFamily: 'Sm',
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              fillColor: Colors.grey[300],
                              filled: true,
                            ),
                          ),
                          Positioned(
                              top: 18,
                              left: 15,
                              child: GestureDetector(
                                onTap: () {
                                  _usernameTextController.text = '';
                                  setState(() {
                                    _isType = false;
                                    _isTextUsernameEmpty = true;
                                  });
                                },
                                child: Visibility(
                                  visible: _isType,
                                  child: Image.asset(
                                    'images/icon_delete_text.png',
                                    height: 24,
                                    width: 24,
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 24, right: 24, bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'رمز عبور',
                        style: TextStyle(
                          fontFamily: 'dana',
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                if (value.isNotEmpty) {
                                  _isTextpasswordEmpty = false;
                                } else {
                                  _isTextpasswordEmpty = true;
                                }
                              });
                            },
                            obscureText: _isHideNumber,
                            obscuringCharacter: '*',
                            controller: _passwordTextController,
                            decoration: InputDecoration(
                              errorText: _isTextpasswordEmpty
                                  ? 'لطفا مقادیر درخواستی را پر کنید'
                                  : null,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              fillColor: Colors.grey[300],
                              filled: true,
                            ),
                          ),
                          Positioned(
                              top: 17,
                              left: 12,
                              child: SizedBox(
                                height: 24,
                                width: 24,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isHideNumber = !_isHideNumber;
                                    });
                                  },
                                  child: Image.asset(
                                    _isHideNumber
                                        ? 'images/icon_hide_number.png'
                                        : 'images/icon_show_number.png',
                                  ),
                                ),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthResponseState) {
                      state.response.fold((errroMessage) {
                        _usernameTextController.text = '';
                        _passwordTextController.text = '';
                        var snackbar = SnackBar(
                          content: Text(
                            errroMessage,
                            style: TextStyle(fontFamily: 'dana', fontSize: 16),
                          ),
                          backgroundColor: CustomColors.blue,
                          behavior: SnackBarBehavior.floating,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }, (r) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return DashbordScreen();
                        }));
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthInitiateState) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(200, 48),
                          backgroundColor: Colors.blue[700],
                        ),
                        onPressed: () {
                          if (_usernameTextController.text.isNotEmpty &&
                              _passwordTextController.text.isNotEmpty) {
                            context.read<AuthBloc>().add(
                                  AuthLoginRequest(_usernameTextController.text,
                                      _passwordTextController.text),
                                );
                          } else {
                            // Fluttertoast.showToast(
                            //     msg: 'لطفا همه مقادیر را پر کنید',
                            //     toastLength: Toast.LENGTH_SHORT,
                            //     gravity: ToastGravity.BOTTOM,
                            //     timeInSecForIosWeb: 1,
                            //     textColor: Colors.white,
                            //     fontSize: 16.0);
                          }
                        },
                        child: const Text(
                          'ورود به حساب کاربری',
                          style: TextStyle(
                            fontFamily: 'dana',
                            fontSize: 18,
                          ),
                        ),
                      );
                    }
                    if (state is AuthLoadingState) {
                      return const LoadingAnimation();
                    }
                    if (state is AuthResponseState) {
                      return state.response.fold((errormessage) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(200, 48),
                            backgroundColor: Colors.blue[700],
                          ),
                          onPressed: () {
                            context.read<AuthBloc>().add(
                                  AuthLoginRequest(_usernameTextController.text,
                                      _passwordTextController.text),
                                );
                          },
                          child: const Text(
                            'ورود به حساب کاربری',
                            style: TextStyle(
                              fontFamily: 'dana',
                              fontSize: 18,
                            ),
                          ),
                        );
                      }, (response) {
                        return Text(response);
                      });
                    }
                    return const Text('خطای نامشخص');
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return const Registerscreen();
                      }));
                    },
                    child: const Text(
                      'اگر حساب کاربری ندارید ثبت نام کنید',
                      style: TextStyle(
                        fontFamily: 'dana',
                        fontSize: 16,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
