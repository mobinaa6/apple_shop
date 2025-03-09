import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_shop/bloc/authentication/auth_bloc.dart';
import 'package:flutter_ecommerce_shop/bloc/authentication/auth_event.dart';
import 'package:flutter_ecommerce_shop/bloc/authentication/auth_state.dart';
import 'package:flutter_ecommerce_shop/main.dart';
import 'package:flutter_ecommerce_shop/screens/dashbord_screen.dart';
import 'package:flutter_ecommerce_shop/screens/login_screen.dart';
import 'package:widget_loading/widget_loading.dart';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  final _usernameTextController = TextEditingController(text: 'mobinccv');
  final _PasswordTextController = TextEditingController(text: '12345678');
  final _PasswordConfirmTextController =
      TextEditingController(text: '12345678');
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: ViewContainer(
          usernameTextController: _usernameTextController,
          PasswordTextController: _PasswordTextController,
          PasswordConfirmTextController: _PasswordConfirmTextController),
    );
  }
}

class ViewContainer extends StatelessWidget {
  ViewContainer({
    super.key,
    required TextEditingController usernameTextController,
    required TextEditingController PasswordTextController,
    required TextEditingController PasswordConfirmTextController,
  })  : _usernameTextController = usernameTextController,
        _PasswordTextController = PasswordTextController,
        _PasswordConfirmTextController = PasswordConfirmTextController;

  final TextEditingController _usernameTextController;
  final TextEditingController _PasswordTextController;
  final TextEditingController _PasswordConfirmTextController;

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
                    height: 40,
                  ),
                  Image.asset(
                    'images/register_photo.jpg',
                    height: 200,
                  ),
                  const Text(
                    'ثبت نام در اپلیکیشن ',
                    style: TextStyle(
                      fontFamily: 'dana',
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      // FilePickerResult? result =
                      //     await FilePicker.platform.pickFiles();

                      // if (result != null) {
                      //   File file =
                      //       File(result.files.single.path ?? " ");
                      //   String filename = file.path.split('/').last;
                      //   String filePath = file.path;

                      //   FormData data = FormData.fromMap({
                      //     'name': 'tokio japan',
                      //     'avatar': await MultipartFile.fromFile(
                      //         filePath,
                      //         filename: filename),
                      //     'price': 9000000000
                      //   });
                      //   var response = await dio.post(
                      //     'https://pocketbase-eqnwz2.chbk.run/api/collections/product/records',
                      //     data: data,
                      //     onSendProgress: (int sent, int total) {
                      //       print('$sent,$total');
                      //     },
                      //   );
                      // } else {
                      //   print('reslut is null');
                      // }
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                          color: Colors.grey, shape: BoxShape.circle),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'انتخاب عکس',
                    style: TextStyle(fontFamily: 'dana'),
                  ),
                  InputUserName(
                      usernameTextController: _usernameTextController),
                  InputPassword(_PasswordTextController),
                  InputPasswordConfirm(_PasswordConfirmTextController),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is AuthResponseState) {
                            state.response.fold((l) => null, (r) {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
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
                                if (_PasswordConfirmTextController
                                        .text.isNotEmpty &&
                                    _PasswordTextController.text.isNotEmpty &&
                                    _usernameTextController.text.isNotEmpty) {
                                  context
                                      .read<AuthBloc>()
                                      .add(AuthRegisterRequest(
                                        _usernameTextController.text,
                                        _PasswordTextController.text,
                                        _PasswordConfirmTextController.text,
                                      ));
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
                                'ثبت نام',
                                style: TextStyle(
                                  fontFamily: 'SB',
                                  fontSize: 18,
                                ),
                              ),
                            );
                          }
                          if (state is AuthLoadingState) {
                            return const WiperLoading(
                              direction: WiperDirection.down,
                              child: Padding(padding: EdgeInsets.all(2)),
                            );
                          }
                          if (state is AuthResponseState) {
                            return state.response.fold((l) {
                              return Text(l);
                            }, (r) {
                              return Text(r);
                            });
                          }
                          return const Text('خطای نامشخص');
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return BlocProvider(
                            create: (context) {
                              var authBloc = AuthBloc();
                              authBloc.stream.forEach((state) {
                                if (state is AuthResponseState) {
                                  state.response.fold((l) => null, (r) {
                                    globalNavigatorKey.currentState
                                        ?.pushReplacement(MaterialPageRoute(
                                      builder: (context) => DashbordScreen(),
                                    ));
                                  });
                                }
                              });
                              return authBloc;
                            },
                            child: const LoginScreen(),
                          );
                        }));
                      },
                      child: const Text(
                        'اگر حساب کاربری دارید وارد شوید',
                        style: TextStyle(
                          fontFamily: 'dana',
                          fontSize: 16,
                        ),
                      )),
                ],
              ),
            ),
          )),
    );
  }
}

class InputPasswordConfirm extends StatefulWidget {
  final TextEditingController _passwordConfirmTextController;
  const InputPasswordConfirm(this._passwordConfirmTextController, {super.key});

  @override
  State<InputPasswordConfirm> createState() => _InputPasswordConfirmState();
}

class _InputPasswordConfirmState extends State<InputPasswordConfirm> {
  bool _isHidePassworConfirm = true;
  bool _isTextPasswordConfirmEmpty = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            ' تکرار رمز عبور:',
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
                      _isTextPasswordConfirmEmpty = false;
                    } else {
                      _isTextPasswordConfirmEmpty = true;
                    }
                  });
                },
                obscureText: _isHidePassworConfirm,
                obscuringCharacter: '*',
                controller: widget._passwordConfirmTextController,
                decoration: InputDecoration(
                  errorText: _isTextPasswordConfirmEmpty
                      ? 'لطفا مقادیر درخواستی را پرکنید'
                      : null,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
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
                          _isHidePassworConfirm = !_isHidePassworConfirm;
                        });
                      },
                      child: Image.asset(
                        _isHidePassworConfirm
                            ? 'images/icon_hide_number.png'
                            : 'images/icon_show_number.png',
                      ),
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
}

class InputPassword extends StatefulWidget {
  final TextEditingController _passwordTextController;
  const InputPassword(this._passwordTextController, {super.key});

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool _isHidePassword = true;
  bool _isTextPasswordEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'رمز عبور:',
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
                      _isTextPasswordEmpty = false;
                    } else {
                      _isTextPasswordEmpty = true;
                    }
                  });
                },
                obscureText: _isHidePassword,
                obscuringCharacter: '*',
                controller: widget._passwordTextController,
                decoration: InputDecoration(
                  errorText: _isTextPasswordEmpty
                      ? 'لطفا مقادیر درخواستی را پرکنید'
                      : null,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
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
                          _isHidePassword = !_isHidePassword;
                        });
                      },
                      child: Image.asset(
                        _isHidePassword
                            ? 'images/icon_hide_number.png'
                            : 'images/icon_show_number.png',
                      ),
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
}

class InputUserName extends StatefulWidget {
  const InputUserName({
    super.key,
    required TextEditingController usernameTextController,
  }) : _usernameTextController = usernameTextController;

  final TextEditingController _usernameTextController;

  @override
  State<InputUserName> createState() => _InputUserNameState();
}

class _InputUserNameState extends State<InputUserName> {
  bool _isTyping = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  if (value.isNotEmpty) {
                    setState(() {
                      _isTyping = true;
                    });
                  } else {
                    setState(() {
                      _isTyping = false;
                    });
                  }
                },
                controller: widget._usernameTextController,
                decoration: InputDecoration(
                  errorText:
                      _isTyping ? null : 'لطفا مقادیر درخواستی را پر کنید',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
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
                    setState(() {
                      _isTyping = false;
                    });
                    widget._usernameTextController.text = '';
                  },
                  child: Visibility(
                    visible: _isTyping,
                    child: Image.asset(
                      'images/icon_delete_text.png',
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
