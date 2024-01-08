import 'package:fic10_cbt/data/datasources/auth_local_datasource.dart';
import 'package:fic10_cbt/data/datasources/content_remote_datasource.dart';
import 'package:fic10_cbt/data/datasources/onboarding_local_datasource.dart';
import 'package:fic10_cbt/data/datasources/ujian_remote_datasource.dart';
import 'package:fic10_cbt/data/models/responses/auth_response_model.dart';
import 'package:fic10_cbt/presentations/auth/bloc/logout/logout_bloc.dart';
import 'package:fic10_cbt/presentations/auth/pages/login_page.dart';
import 'package:fic10_cbt/presentations/home/bloc/bloc/content_bloc.dart';
import 'package:fic10_cbt/presentations/home/pages/dashboard_page.dart';
import 'package:fic10_cbt/presentations/materi/bloc/materi/materi_bloc.dart';
import 'package:fic10_cbt/presentations/quiz/bloc/answer/answer_bloc.dart';
import 'package:fic10_cbt/presentations/quiz/bloc/create_ujian/create_ujian_bloc.dart';
import 'package:fic10_cbt/presentations/quiz/bloc/daftar_soal/daftar_soal_bloc.dart';
import 'package:fic10_cbt/presentations/quiz/bloc/hitung_nilai/hitung_nilai_bloc.dart';
import 'package:fic10_cbt/presentations/quiz/bloc/ujian_by_kategori/ujian_by_kategori_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk_mode/kiosk_mode.dart';

import 'presentations/auth/bloc/login/login_bloc.dart';
import 'presentations/auth/bloc/register/register_bloc.dart';
import 'presentations/onboarding/pages/onboarding_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await startKioskMode();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => ContentBloc(ContentRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => MateriBloc(),
        ),
        BlocProvider(
          create: (context) => UjianByKategoriBloc(),
        ),
        BlocProvider(
          create: (context) => CreateUjianBloc(UjianRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => AnswerBloc(),
        ),
        BlocProvider(
          create: (context) => DaftarSoalBloc(),
        ),
        BlocProvider(
          create: (context) => HitungNilaiBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: FutureBuilder<AuthResponseModel>(
            future: AuthLocalDatasource().getAuthData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const DashboardPage();
              } else {
                return FutureBuilder<bool>(
                    future: OnboardingLocalDatasource().getIsFisrtTime(),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? const LoginPage()
                          : const OnBoardingPage();
                    });
              }
            }),
      ),
    );
  }
}
