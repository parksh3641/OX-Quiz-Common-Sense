import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({Key? key}) : super(key: key);

  @override
  State<FoodPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<FoodPage> {
  List<Map<String, dynamic>> dataList = [
    {
      "category": "수제버거",
      "imgUrl":
          "https://i.ibb.co/HBGKYn4/foodiesfeed-com-summer-juicy-beef-burger.jpg",
    },
    {
      "category": "건강식",
      "imgUrl":
          "https://i.ibb.co/mB5YNs2/foodiesfeed-com-pumpkin-soup-with-pumpkin-seeds-on-top.jpg",
    },
    {
      "category": "한식",
      "imgUrl":
          "https://i.ibb.co/Kzzpc97/Beautiful-vibrant-shot-of-traiditonal-Korean-meals.jpg",
    },
    {
      "category": "디저트",
      "imgUrl":
          "https://i.ibb.co/DL5vJVZ/foodiesfeed-com-carefully-putting-a-blackberry-on-tiramisu.jpg",
    },
    {
      "category": "피자",
      "imgUrl": "https://i.ibb.co/qsm8QH4/pizza.jpg",
    },
    {
      "category": "볶음밥",
      "imgUrl":
          "https://i.ibb.co/yQDkq2X/foodiesfeed-com-hot-shakshuka-in-a-cast-iron-pan.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Recipe"),
        actions: [
          IconButton(
            icon: Icon(Icons.place),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "상품을 검색해주세요",
                  suffixIcon: Icon(Icons.search)),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data = dataList[index];
                String category = data["category"];
                String imgUrl = data["imgUrl"];

                return Card(
                  margin: EdgeInsets.all(8),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.network(
                        imgUrl,
                        width: double.infinity,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        width: double.infinity,
                        height: 120,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      Text(
                        category,
                        style: TextStyle(color: Colors.white, fontSize: 36),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Column(children: [
          DrawerHeader(
            margin: EdgeInsets.all((0)),
            decoration: BoxDecoration(
              color: Colors.amber,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Column(children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image.network(
                      "https://i.ibb.co/CwzHq4z/trans-logo-512.png",
                      width: 62,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "닉네임",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Hello@world.com",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                )
              ]),
            ),
          ),
          AspectRatio(
            aspectRatio: 12 / 4,
            child: PageView(children: [
              Image.network(
                "https://i.ibb.co/Q97cmkg/sale-event-banner1.jpg",
              ),
              Image.network(
                "https://i.ibb.co/GV78j68/sale-event-banner2.jpg",
              ),
              Image.network(
                "https://i.ibb.co/R3P3RHw/sale-event-banner3.jpg",
              ),
              Image.network(
                "https://i.ibb.co/LRb1VYs/sale-event-banner4.jpg",
              ),
            ]),
          ),
          ListTile(
            title: Text(
              '구매내역',
              style: TextStyle(fontSize: 18),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(
              '저장한 레시피',
              style: TextStyle(fontSize: 18),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ]),
      ),
    );
  }
}
