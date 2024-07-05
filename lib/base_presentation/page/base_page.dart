import 'package:flutter/material.dart';

abstract class BuildBasePage {
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  Widget buildBody(BuildContext context);

  Widget? buildFloatingActionButton(BuildContext context) => null;
}

abstract class BasePage extends StatelessWidget implements BuildBasePage {
  const BasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  @override
  Widget buildBody(BuildContext context);

  @override
  Widget? buildFloatingActionButton(BuildContext context) => null;
}

abstract class BasePageState<T extends StatefulWidget> extends State<T> implements BuildBasePage {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  @override
  Widget buildBody(BuildContext context);

  @override
  Widget? buildFloatingActionButton(BuildContext context) => null;
}

abstract class MultiProviderBasePage extends BasePage {
  const MultiProviderBasePage({super.key});

  Widget buildMultiBlocProvider({Widget child});

  @override
  Widget build(BuildContext context) {
    return buildMultiBlocProvider(
      child: super.build(context),
    );
  }
}
