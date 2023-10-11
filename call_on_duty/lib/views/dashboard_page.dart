import 'package:call_on_duty/bloc/question/bloc/question_bloc.dart';
import 'package:call_on_duty/designs/colors/app_colors.dart';
import 'package:call_on_duty/designs/fonts/text_style.dart';
import 'package:call_on_duty/repository/injection_container.dart';
import 'package:call_on_duty/views/information_page.dart';
import 'package:call_on_duty/views/game_mode_page.dart';
import 'package:call_on_duty/views/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int currentIndex = 0;
  bool isOpenPrivacy = false;
  PageController pageController = PageController(initialPage: 0);

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
                            child: const InforamtionPage(),
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
                        'HOW TO PLAY',
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
                    child: Center(
                      child: Text(
                        'SETTINGS',
                        style: titleText(16, FontWeight.bold, Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
        AnimatedPositioned(
          duration: Duration(microseconds: 500),
          top: 40,
          right: 20,
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
                duration: Duration(microseconds: 500),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(100)),
                child: Icon(Icons.question_mark_rounded, color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}
