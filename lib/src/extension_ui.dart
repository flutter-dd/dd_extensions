part of dd_extensions;


extension Context on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  double get widthR => !isVertical ? width : height;
  double get heightR => !isVertical ? height : width;
  bool get isVertical => MediaQuery.of(this).orientation.index == 1;
}

extension Stateless on StatelessWidget {

  Map<String, WidgetBuilder> get route =>
      {'${runtimeType.toString()}': (context) => this};

  Future<T> push<T extends Object>(BuildContext context,
      {Object arguments}) async {
    return Navigator.of(context)
        .pushNamed(this.runtimeType.toString(), arguments: arguments);
  }

  Future<T> pushReplace<T extends Object>(BuildContext context,
      {Object arguments}) async {
    return Navigator.of(context).pushReplacementNamed(
        this.runtimeType.toString(),
        arguments: arguments);
  }

  Future<void> popRoot(BuildContext context) async {
    return Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Future<dynamic> pop(BuildContext context) async {
    if (Navigator.of(context).canPop()) {
      return Navigator.of(context).pop();
    }
  }

  Object arguments(BuildContext context) =>
      ModalRoute.of(context).settings.arguments;

  bool isVertical(BuildContext context) =>
      MediaQuery.of(context).orientation.index == 1;

  String get title => "${this.runtimeType.toString()}";

  Widget buildView(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: isVertical(context) ? null : appBar(context),
      child: SafeArea(child: content(context)),
    );
  }

  CupertinoNavigationBar appBar(BuildContext context) =>
      CupertinoNavigationBar(middle: Text(title));

  Widget content(BuildContext context) => Container();

}

extension Stateful on StatefulWidget {

  Map<String, WidgetBuilder> get route =>
      {'${runtimeType.toString()}': (context) => this};

  Future<T> push<T extends Object>(BuildContext context,
      {Object arguments}) async {
    return Navigator.of(context)
        .pushNamed(this.runtimeType.toString(), arguments: arguments);
  }

  Future<T> pushReplace<T extends Object>(BuildContext context,
      {Object arguments}) async {
    return Navigator.of(context).pushReplacementNamed(
        this.runtimeType.toString(),
        arguments: arguments);
  }

}

extension States on State {

  Object get arguments => ModalRoute.of(context).settings.arguments;

  bool get isVertical => MediaQuery.of(context).orientation.index == 1;

  String get title => "${widget.runtimeType.toString()}";

  Future<void> popRoot() async {
    return Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Future<void> pop() async {
    if (Navigator.of(context).canPop()) {
      return Navigator.of(context).pop();
    }
  }

  Widget buildView() {
    return CupertinoPageScaffold(
        resizeToAvoidBottomInset: !isVertical,
        navigationBar: isVertical ? null : appBar(),
        child: SafeArea(
            child: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: content())));
  }
  CupertinoNavigationBar appBar() => CupertinoNavigationBar(middle: Text(title));
  Widget content() => Container();
}

