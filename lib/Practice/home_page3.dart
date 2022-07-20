import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gosuoflife/Practice/bucket_service.dart';
import 'package:provider/provider.dart';

class HomePage3 extends StatefulWidget {
  const HomePage3({Key? key}) : super(key: key);

  @override
  State<HomePage3> createState() => _HomePage3State();
}

class Bucket {
  String job;
  bool isDone;

  Bucket(this.job, this.isDone);
}

class _HomePage3State extends State<HomePage3> {
  List<Bucket> bucketList = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<BucketService>(
      builder: (context, bucketService, child) {
        List<Bucket> bucketList = bucketService.bucketList;
        return Scaffold(
          appBar: AppBar(
            title: Text("버킷 리스트"),
          ),
          body: bucketList.isEmpty
              ? Center(child: Text("버킷 리스트를 작성해 주세요"))
              : ListView.builder(
                  itemCount: bucketList.length, // bucketList 개수 만큼 보여주기
                  itemBuilder: (context, index) {
                    Bucket bucket =
                        bucketList[index]; // index에 해당하는 bucket 가져오기
                    return ListTile(
                      // 버킷 리스트 할 일
                      title: Text(
                        bucket.job,
                        style: TextStyle(
                          fontSize: 24,
                          color: bucket.isDone ? Colors.grey : Colors.black,
                          decoration: bucket.isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      // 삭제 아이콘 버튼
                      trailing: IconButton(
                        icon: Icon(CupertinoIcons.delete),
                        onPressed: () {
                          bucketService.deleteBucket(index);
                          //showDeleteDialog(context, index);
                        },
                      ),
                      onTap: () {
                        setState(() {
                          bucket.isDone = !bucket.isDone;
                          bucketService.updateBucket(bucket, index);
                        });
                      },
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              // + 버튼 클릭시 버킷 생성 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CreatePage()),
              );
            },
          ),
        );
      },
    );
  }

  void showDeleteDialog(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("정말로 삭제하시겠습니까?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("취소"),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    bucketList.removeAt(index);
                    Navigator.pop(context);
                  });
                },
                child: Text("확인", style: TextStyle(color: Colors.pink)),
              )
            ],
          );
        });
  }
}

/// 버킷 생성 페이지
class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController textController = TextEditingController();
  String? error;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("버킷리스트 작성"),
        // 뒤로가기 버튼
        leading: IconButton(
          icon: Icon(CupertinoIcons.chevron_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 텍스트 입력창
            TextField(
              controller: textController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "하고 싶은 일을 입력하세요",
                errorText: error,
              ),
            ),
            SizedBox(height: 32),
            // 추가하기 버튼
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                child: Text(
                  "추가하기",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  String job = textController.text;
                  if (job.isEmpty) {
                    setState(() {
                      error = "내용을 입력해주세요.";
                    });
                  } else {
                    setState(() {
                      error = null;
                    });
                    BucketService bucketService = context.read<BucketService>();
                    bucketService.createBucket(job);

                    Navigator.pop(context);
                  }

                  // 추가하기 버튼 클릭시
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
