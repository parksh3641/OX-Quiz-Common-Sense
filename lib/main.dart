import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = context.read<AuthService>().currentUser();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: user == null ? LoginPage() : HomePage(),
    );
  }
}

/// 로그인 페이지
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(builder: (context, authService, child) {
      User? user = authService.currentUser();
      return Scaffold(
        appBar: AppBar(title: Text("로그인")),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// 현재 유저 로그인 상태
              Center(
                child: Text(
                  user == null ? "로그인해 주세요 🙂" : "${user.email}님 안녕하세요 👋",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(height: 32),

              /// 이메일
              TextField(
                controller: emailController,
                decoration: InputDecoration(hintText: "이메일"),
              ),

              /// 비밀번호
              TextField(
                controller: passwordController,
                obscureText: false, // 비밀번호 안보이게
                decoration: InputDecoration(hintText: "비밀번호"),
              ),
              SizedBox(height: 32),

              /// 로그인 버튼
              ElevatedButton(
                child: Text("로그인", style: TextStyle(fontSize: 21)),
                onPressed: () {
// 로그인
                  authService.signIn(
                    email: emailController.text,
                    password: passwordController.text,
                    onSuccess: () {
                      // 로그인 성공
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("로그인 성공"),
                      ));

                      // HomePage로 이동
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    onError: (err) {
                      // 에러 발생
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(err),
                        ),
                      );
                    },
                  );
                },
              ),

              /// 회원가입 버튼
              ElevatedButton(
                child: Text("회원가입", style: TextStyle(fontSize: 21)),
                onPressed: () {
                  authService.signUp(
                    email: emailController.text,
                    password: passwordController.text,
                    onSuccess: () {
                      // 회원가입 성공
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("회원가입 성공"),
                      ));
                    },
                    onError: (err) {
                      // 에러 발생
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(err),
                      ));
                    },
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}

/// 홈페이지
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("버킷 리스트"),
        actions: [
          TextButton(
            child: Text(
              "로그아웃",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              // 로그아웃
              context.read<AuthService>().signOut();
              // 로그인 페이지로 이동
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          /// 입력창
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                /// 텍스트 입력창
                Expanded(
                  child: TextField(
                    controller: jobController,
                    decoration: InputDecoration(
                      hintText: "하고 싶은 일을 입력해주세요.",
                    ),
                  ),
                ),

                /// 추가 버튼
                ElevatedButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    // create bucket
                    if (jobController.text.isNotEmpty) {
                      print("create bucket");
                    }
                  },
                ),
              ],
            ),
          ),
          Divider(height: 1),

          /// 버킷 리스트
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                String job = "$index";
                bool isDone = false;
                return ListTile(
                  title: Text(
                    job,
                    style: TextStyle(
                      fontSize: 24,
                      color: isDone ? Colors.grey : Colors.black,
                      decoration: isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  // 삭제 아이콘 버튼
                  trailing: IconButton(
                    icon: Icon(CupertinoIcons.delete),
                    onPressed: () {
                      // 삭제 버튼 클릭시
                    },
                  ),
                  onTap: () {
                    // 아이템 클릭하여 isDone 업데이트
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
