import 'package:flutter/cupertino.dart';
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
//      home: TabBoxA(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => TabBoxA(),
        'container': (context) => ContainerPage(),
        'containWidget': (context) => ContainWidgetPage(),
        'activity': (context) => ScaffoldRoute(),
      },
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

class ScaffoldRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScaffoldRouteState();
  }
}

class _ScaffoldRouteState extends State<ScaffoldRoute> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List tabs = ["新闻", "历史", "图片"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity'),
//        leading: Builder(builder: (context) {return IconButton(
//          icon: Icon(Icons.arrow_back),
//        );}),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share), onPressed: () => print("click share button")),
        ],
        bottom: TabBar(tabs: tabs.map((e)=>Tab(text: e,)).toList(),
        controller: _tabController,),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabs.map((e) {return Container(
        alignment: Alignment.center, child: Text(e, textScaleFactor: 5,));
      }).toList()),
//      drawer: MyDrawer(),
    bottomNavigationBar: BottomNavigationBar(items: [
      BottomNavigationBarItem(icon: Icon(Icons.arrow_back), title: Text('')),
      BottomNavigationBarItem(icon: Icon(Icons.arrow_forward), title: Text('')),
    ], ),
    floatingActionButton: FloatingActionButton(onPressed: ()=>print("click add"),
      child: Icon(Icons.add),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: MediaQuery.removePadding(context: context,
        removeTop: true,child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 38),
          child: Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.symmetric(horizontal: 16),
                child: ClipOval(
                  child: Image.asset('images/icon_filter.png', width: 60,),
                ),),
              Text('wuzh', style: TextStyle(fontWeight: FontWeight.bold),),
              Expanded(child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('设置'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('添加'),
                  ),
                ],
              ))
            ],
          ),)
        ],
      )),
    );
  }
}

class ContainWidgetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text('容器类组件'),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.share), onPressed: () => print('share')),
      ],
    ),
    body: Column(
      children: <Widget>[
        ConstrainedBox(constraints: BoxConstraints(
          minWidth: 60, minHeight: 60,
        ), child: Text("alalalallala"),),
        SizedBox(
          width: double.infinity,
          height: 100,
          child: Text('A'),
        ),
        Padding(padding: EdgeInsets.all(20),
        child: SizedBox(
          width: double.infinity,
          height: 100,
          child: DecoratedBox(decoration: BoxDecoration(
              color: Colors.amber,
//              image: DecorationImage(image: AssetImage('/images/icon_filter.png')),
              borderRadius: BorderRadius.circular(20.0),
              boxShadow:[
                BoxShadow(
                    color: Colors.black54,
                    offset: Offset(2,2),
                    blurRadius: 4
                )
              ]
          ),
            child: Center(
              child: Text('============================='),
            )),

        )
      ,),
        Container(
          child: ClipRRect(
            child: Image.asset('images/icon_filter.png', width: 100, height: 100, color: Colors.blue,),
          ),
          alignment: Alignment.center,
          color: Colors.grey,
        )
      ],
    ),
//    bottomNavigationBar: BottomNavigationBar(items: [
//      BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
//      BottomNavigationBarItem(icon: Icon(Icons.business), title: Text('Business')),
//      BottomNavigationBarItem(icon: Icon(Icons.school), title: Text('School')),
//    ],
//    currentIndex: 0,
//    fixedColor: Colors.blue,),
    );

  }
}

class ContainerPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Container"),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(padding: EdgeInsets.all(3.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,

          children: <Widget>[
            // Expanded:将Container扩充整个空间
            Container(
                height: 40,
                color: Colors.red,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text("hello"),
                    Text("hello aaaaaa"),
                  ],
                ),
            ),
            Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 30,
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 30,
                    color: Colors.green,
                  ),
                )
              ],
            ),
            Padding(
            padding: EdgeInsets.all(20),
            child: SizedBox(
              height: 100,
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 30,
                      color: Colors.red,
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 30,
                      color: Colors.green,
                    ),
                  )
                ],
              ),
            ),),
            OutlineButton(onPressed: null, child: Wrap(
              direction: Axis.horizontal,
              spacing: 8,
              runSpacing: 4,
              alignment: WrapAlignment.start,
              children: <Widget>[
                Chip(label: Text("剑来"), avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('A'),),),
                Chip(label: Text("将夜"), avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('A'),),),
                Chip(label: Text("雪中悍刀行"), avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('A'),),),
                Chip(label: Text("牧神记"), avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('A'),),),
                Chip(label: Text("完美世界"), avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('A'),),),
              ],
            ),),
            Flow(
              delegate: TestFlowDelegate(margin: EdgeInsets.all(2)),
              children: <Widget>[
                Container(width: 80, height: 100, color: Colors.red,child: Center(child: Text('A', textAlign: TextAlign.center,),),),
                Container(width: 80, height: 100, color: Colors.blue,child: Center(child: Text('A', textAlign: TextAlign.center,),),),
                Container(width: 80, height: 100, color: Colors.grey,child: Center(child: Text('A', textAlign: TextAlign.center,),),),
                Container(width: 80, height: 100, color: Colors.green,child: Center(child: Text('A', textAlign: TextAlign.center,),),),
                Container(width: 60, height: 100, color: Colors.purple,child: Center(child: Text('A', textAlign: TextAlign.center,),),),
              ],
            ),
            ConstrainedBox(constraints: null)
          ],
        )),
      ),
    );
  }
}

// 自定义Container布局
class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;

  TestFlowDelegate({@required this.margin});

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;

    for(int i=0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i, transform: Matrix4.translationValues(x,y,.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    // TODO: implement getSize
    return Size(double.infinity, 400);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate != null;
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
          Image.asset('images/icon_filter.png', width: 100),//,color: Colors.blue,colorBlendMode: BlendMode.darken),
          Image(image: AssetImage('images/icon_filter.png'), width: 100.0,),
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
          Container(
            color: Colors.green,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    color: Colors.red,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text("hi"),
                        Text("wuzh"),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
//          ConstrainedBox(
//            constraints: BoxConstraints(minWidth: double.infinity),
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.center,
//              children: <Widget>[
//                Text("hi"),
//                Text("World"),
//              ],
//            ),
//          )
//          Form(key: _formKey,
//            autovalidate: true,
//            child: TextFormField(
//            autofocus: true,
//            controller: _useridController,
//            focusNode: focusnode1,
//            decoration: InputDecoration(
//                labelText: '用户名',
//                hintText: '用户名或邮箱或手机号',
//                prefixIcon: Icon(Icons.person)
//            ),
//            validator: (value) {
//              return value.trim().length > 0 ? null : "用户名不能为空!";
//            },
////            onChanged: (str) {
////              print("nick: $str");
////            },
//          ),
//          ),
//          TextField(
//            controller: _pwdController,
//            focusNode: focusnode2,
//            autofocus: false,
//            decoration: InputDecoration(
//                labelText: "密码",
//                hintText: "您的登录密码",
//                prefixIcon: Icon(Icons.lock)
//            ),
//            obscureText: true,
//          ),

        ])
        ),
//        width: 100.0,
//        height: 100.0,
//        decoration: BoxDecoration(
//          color: _active ? Colors.white : Colors.grey[600]
//        ),
//        constraints: BoxConstraints(),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
//        Navigator.pushNamed(context, 'container');
        Navigator.pushNamed(context, 'containWidget');
//          Navigator.pushNamed(context, 'activity');
      }, tooltip: 'Box', child: Icon(Icons.account_box),),
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








