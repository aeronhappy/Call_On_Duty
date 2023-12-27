import 'dart:io';

import 'package:call_on_duty/bloc/question/bloc/question_bloc.dart';
import 'package:call_on_duty/designs/colors/app_colors.dart';
import 'package:call_on_duty/designs/fonts/text_style.dart';
import 'package:call_on_duty/repository/injection_container.dart';
import 'package:call_on_duty/views/highscore_page.dart';
import 'package:call_on_duty/views/game_mode_page.dart';
import 'package:call_on_duty/views/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int currentIndex = 0;
  bool isOpenPrivacy = false;
  bool isAgreed = false;
  PageController pageController = PageController(initialPage: 0);

  agreePrivacyPolicy() async {
    var sharedPref = await SharedPreferences.getInstance();
    isAgreed = sharedPref.getBool('PrivacyPolicy') ?? false;
  }

  @override
  void initState() {
    super.initState();
    agreePrivacyPolicy();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/icon/splash_screen.png',
              fit: BoxFit.cover,
            )),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                    radius: 120,
                    child: Image.asset('assets/icon/call_on_duty.png')),
                SizedBox(height: 50),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        maintainState: false,
                        builder: (context) {
                          return MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) => QuestionBloc(
                                    questionRepository: sl(),
                                    networkInfoServices: sl()),
                              ),
                            ],
                            child: const GameModePage(),
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        'PLAY',
                        style: titleText(16, FontWeight.bold, Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) => QuestionBloc(
                                    questionRepository: sl(),
                                    networkInfoServices: sl()),
                              ),
                            ],
                            child: const HighscorePage(),
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        'HIGHSCORE',
                        style: titleText(16, FontWeight.bold, Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) => QuestionBloc(
                                    questionRepository: sl(),
                                    networkInfoServices: sl()),
                              ),
                            ],
                            child: const SettingsPage(),
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Hero(
                      tag: "settings-tag",
                      child: Center(
                        child: Text(
                          'SETTINGS',
                          style: titleText(16, FontWeight.bold, Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    exit(0);
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        'QUIT',
                        style: titleText(16, FontWeight.bold, Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedPositioned(
          duration: Duration(microseconds: 500),
          top: 40,
          right: 20,
          bottom: isOpenPrivacy ? 40 : null,
          left: isOpenPrivacy ? 20 : null,
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(100),
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                setState(() {
                  isOpenPrivacy = !isOpenPrivacy;
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius:
                        BorderRadius.circular(isOpenPrivacy ? 12 : 100)),
                child: !isOpenPrivacy
                    ? Icon(Icons.question_mark_rounded, color: Colors.white)
                    : Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Privacy Policy and \n Terms of Use',
                                textAlign: TextAlign.center,
                                style: titleText(
                                    28, FontWeight.bold, Colors.white),
                              ),
                              Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: lightPrimarybgColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                  textPrivacy,
                                  textAlign: TextAlign.center,
                                  style: bodyText(
                                      18, FontWeight.normal, Colors.black),
                                ),
                              ),
                              isAgreed
                                  ? Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: Colors.white38,
                                                  width: .5)),
                                          height: 50,
                                          child: Center(
                                            child: Text(
                                                'I agreed in privacy policy.',
                                                style: titleText(
                                                    14,
                                                    FontWeight.w500,
                                                    Colors.white38)),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          'Tap to close',
                                          style: bodyText(12, FontWeight.w300,
                                              Colors.white),
                                        )
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            var sharedPref =
                                                await SharedPreferences
                                                    .getInstance();
                                            sharedPref.setBool(
                                                'PrivacyPolicy', true);
                                            setState(() {
                                              isAgreed = true;
                                            });
                                          },
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: lightPrimarybgColor,
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            child: Center(
                                              child: Text(
                                                'Naiintindihan',
                                                style: titleText(
                                                    18,
                                                    FontWeight.bold,
                                                    Colors.red),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        InkWell(
                                          onTap: () {
                                            exit(0);
                                          },
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: lightPrimarybgColor,
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            child: Center(
                                              child: Text(
                                                'Umalis',
                                                style: titleText(
                                                    18,
                                                    FontWeight.bold,
                                                    Colors.red),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                            ]),
                      ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

String textPrivacy =
    'Ang larong ito ay naglalaman ng pangkalahatang impormasyon tungkol sa mga kondisyong medikal at paggamot. Ang impormasyon ay payo, at hindi dapat ituring na ganoon. Ang aming kurso sa aplikasyon ng first aid ay hindi kapalit para sa hands-on na pagsasanay sa first aid ng isang akreditado at awtorisadong tagapagbigay ng pagsasanay sa first aid at hindi dapat gamitin sa ganitong paraan.';
