import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:note_app/base_presentation/theme/theme.dart';
import 'package:note_app/data/collection/note_collection.dart';
import 'package:note_app/data/entity/collection_mapping.dart';
import 'package:note_app/data/entity/note_entity.dart';
import 'package:note_app/data/observer_data.dart';
import 'package:note_app/data/observer_data/note_observer_data.dart';
import 'package:note_app/data/observer_data/note_observer_data_impl.dart';
import 'package:note_app/data/repository/note_repository_impl.dart';
import 'package:note_app/database/database.dart';
import 'package:note_app/database/isar_database.dart';
import 'package:note_app/feature/home/bloc/crud_note_bloc.dart';
import 'package:note_app/feature/home/bloc/group_bloc.dart';
import 'package:note_app/util/app_life_cycle_mixin.dart';
import 'package:note_app/util/navigator/app_navigator.dart';
import 'package:note_app/util/navigator/app_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

import 'main_setting/app_setting.dart';

class AppLocale {
  final List<Locale> supportedLocales = [
    const Locale('ar', 'EG'),
    const Locale('en', 'US'),
    const Locale('es', 'ES'),
    const Locale('hi', 'IN'),
    const Locale('ja', 'JP'),
    const Locale('pt', 'BR'),
    const Locale('vi', 'VN'),
    const Locale('zh', 'CN'),
  ];

  Locale get defaultLocale => const Locale('en', 'US');

  String get path => 'assets/translations';
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Database database = IsarDatabase();

  await database.initialize();

  await AppSetting().initApp();

  final AppLocale appLocale = AppLocale();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final isar = Isar.getInstance();
  @override
  void initState() {
    super.initState();

    print('isar: ${isar}');
  }

  @override
  Widget build(BuildContext context) {
    AppTheme.initFromRootContext(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ListNoteGroupCubit(
            groupRepository: NoteGroupRepositoryImpl(),
            groupObserverData: NoteGroupObserverDataIsarImpl(),
          ),
        ),
        BlocProvider(
          create: (context) => CrudNoteBloc(
            noteRepository: NoteRepositoryImpl(),
          ),
        ),
      ],
      child: ListenableBuilder(
        listenable: AppTheme.instance,
        builder: (context, _) {
          return MaterialApp(
            themeMode: AppTheme.instance.mode,
            theme: ThemeData.light(),
            debugShowCheckedModeBanner: false,
            home: GetHomePage().getPage(null),
            navigatorKey: AppNavigator.navigatorKey,
            navigatorObservers: [
              AppLifeCycleMixin.routeObserver,
            ],
            builder: (context, child) {
              return GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: child,
              );
            },
          );
        },
      ),
    );
  }
}

class HomeTestDatabase extends StatefulWidget {
  const HomeTestDatabase({super.key});

  @override
  State<HomeTestDatabase> createState() => _HomeTestDatabaseState();
}

class _HomeTestDatabaseState extends State<HomeTestDatabase> {
  @override
  void initState() {
    super.initState();
    init();
  }

  final NoteGroupObserverData _noteGroupObserver = NoteGroupObserverDataIsarImpl();

  Future init() async {
    _noteGroupObserver.listener(
      (value) {
        g = value;
        setState(() {});
      },
    );
  }

  List<NoteGroupEntity> g = [];

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(g.map((e) => e.name ?? '').join('\n')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // final r = await isar.writeTxn(() async {
          //   final noteGroup = NoteGroupCollection();
          //   noteGroup.name = '${count++}';
          //   await isar.noteGroupCollections.put(noteGroup);
          // });
        },
      ),
    );
  }

  @override
  void dispose() {
    _noteGroupObserver.cancelListen();
    super.dispose();
  }
}
