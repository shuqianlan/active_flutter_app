import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Active Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TabBoxA(),
    );
  }
}

class TabBoxA extends StatefulWidget {
  TabBoxA({Key key}): super(key: key);


  @override
  State createState() {
    print("=====================> ");
    return _TabBoxAState();
  }

}

class _TabBoxAState extends State<TabBoxA> {
  static GlobalKey<FormState> _formKey = GlobalKey();

  bool _active = false;
  bool _isOpened = false;
  bool _isChecked = false;

  TextEditingController _useridController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();

  FocusNode focusnode1 = FocusNode();
  FocusNode focusnode2 = FocusNode();
  FocusScopeNode node;

  void _handleTap() {
    setState(() {
      _active = !_active;
      print("hello,"*3);
    });
  }

  LongPressGestureRecognizer _longPressGestureRecognizer;

  @override
  Widget build(BuildContext context) {
    print("rebuild ......");
    return Scaffold(
//      onTap: _handleTap,
      body: Container(
        child: Center(
//          child: Text(
//            _active ? 'Active' : 'Inactive',
//            textAlign: TextAlign.left,
//            maxLines: 1,
//            overflow: TextOverflow.ellipsis,
//            textScaleFactor: 1,
//            style: TextStyle(fontSize: 32.0, color: Colors.white),
//          ),
        child: Column(children: [
          Text.rich(TextSpan(
              children: [
                TextSpan(
                    text: 'Home: '
                ),
                TextSpan(
                    text: 'http://ilifesmart.com',
                    style: TextStyle(
                        color: Colors.blue
                    ),
                    recognizer: _longPressGestureRecognizer
                ),
              ]
          )),
          RaisedButton.icon(onPressed: ()=> print('click '), icon: Icon(Icons.add), label: Text('添加')),
          FlatButton.icon(onPressed: ()=> print('click '), icon: Icon(Icons.add), label: Text('添加')),
          OutlineButton.icon(onPressed: ()=> print('click '), icon: Icon(Icons.add), label: Text('添加')),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton.icon(onPressed: (){
                if (node == null) {
                  node = FocusScope.of(context);
                }
                node.requestFocus(focusnode2);
              }, label: Text("焦点移动"), icon: Icon(Icons.four_k)),
              RaisedButton.icon(onPressed: (){
                print("user: ${_useridController.text}, pwd: ${_pwdController.text}");
              }, label: Text("数据"), icon: Icon(Icons.access_alarms)),
              RaisedButton.icon(onPressed: (){
                focusnode2.unfocus();
                focusnode1.unfocus();
              }, label: Text("隐藏键盘"), icon: Icon(Icons.access_alarms)),
              RaisedButton.icon(onPressed: (){
                if ((_formKey.currentState as FormState)?.validate() ?? false) {
                  print("validate --------------");
                }
              }, label: Text("验证"), icon: Icon(Icons.access_alarms)),
            ],
          ),
          Image(image: AssetImage('images/icon_filter.png'), width: 100.0,),
          Image.asset('images/icon_filter.png', width: 100,color: Colors.blue,colorBlendMode: BlendMode.darken),
          Image.network('https://avatars2.githubusercontent.com/u/20411648?s=460&v=4', width: 100.0,),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Icon(Icons.accessible, color:Colors.green),
            Icon(Icons.error, color:Colors.green),
            Icon(Icons.fingerprint, color:Colors.green),
          ],),
          Switch(value: _isOpened, onChanged: (value) {
            setState(() {
              _isOpened = value;
            });
          }),
          Checkbox(value: _isChecked, activeColor: Colors.green, onChanged: (value){
            setState(()=>_isChecked = value) ;
          }),
          Form(key: _formKey,
            autovalidate: true,
            child: TextFormField(
            autofocus: true,
            controller: _useridController,
            focusNode: focusnode1,
            decoration: InputDecoration(
                labelText: '用户名',
                hintText: '用户名或邮箱或手机号',
                prefixIcon: Icon(Icons.person)
            ),
            validator: (value) {
              return value.trim().length > 0 ? null : "用户名不能为空!";
            },
//            onChanged: (str) {
//              print("nick: $str");
//            },
          ),
          ),
          TextField(
            controller: _pwdController,
            focusNode: focusnode2,
            autofocus: false,
            decoration: InputDecoration(
                labelText: "密码",
                hintText: "您的登录密码",
                prefixIcon: Icon(Icons.lock)
            ),
            obscureText: true,
          ),

        ])
        ),
//        width: 100.0,
//        height: 100.0,
//        decoration: BoxDecoration(
//          color: _active ? Colors.white : Colors.grey[600]
//        ),
//        constraints: BoxConstraints(),
      ),
      resizeToAvoidBottomPadding: false,
    );

  // -- invalid raiseup
//    return RaisedButton(onPressed: () {
//      print("Hello, onpressed");
//      ScaffoldState _state = Scaffold.of(context);
////      assert(_state == null);
//      print("_state ${_state == null}");
//      _state.showSnackBar(SnackBar(content: Text("Snack bar")));
//    }, child: Text("显示SnackBar"),);
  }

  @override
  void didUpdateWidget(TabBoxA oldWidget) {
    print("old value: ${oldWidget.key} ");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {

    print("initState ...");
    _longPressGestureRecognizer = LongPressGestureRecognizer()
      ..onLongPress = _handlePress;

    _useridController..addListener(() {
      print("change: ${_useridController.text}");
    });
    super.initState();
  }

  @override
  void dispose() {
    _longPressGestureRecognizer.dispose();
    focusnode2.dispose();
    focusnode1.dispose();
    node?.dispose();
    super.dispose();
  }

  void _handlePress() {
    HapticFeedback.vibrate();
  }
}

class ParentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ParentWidgetState();
  }
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
//      child: Tab,
    );
  }
}

class TapBoxA extends StatelessWidget {
  TapBoxA({Key key, this.active, @required this.onChanged}):super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!active);
  }

  @override
  Widget build(BuildContext context) {
    GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(active ? 'Active' : 'Inactive',
          style: TextStyle(fontSize: 32.0, color: Colors.white),),

        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[600]
        ),
      ),
    );
  }
}








