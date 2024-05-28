import 'package:flutter/material.dart';
import 'package:soko_fresh/Service/database.dart';
import 'package:soko_fresh/Service/shared_preference.dart';
import 'package:soko_fresh/pages/chat.dart';
import 'package:soko_fresh/pages/wallet.dart';
import 'package:soko_fresh/widgets/widget_support.dart';

class Details extends StatefulWidget {
  String image, name, detail, price, phoneNumber;
  Details(
      {super.key,
      required this.detail,
      required this.image,
      required this.name,
      required this.price,
            required this.phoneNumber,

      });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int a = 1, total = 0;
  String? userId;
String? phoneNumber;
  getthesharedpref() async {
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

  String? id;
  @override
  void initState() {
    super.initState();
    total = int.parse(widget.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.black,
                )),
            const SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.network(widget.image,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                    fit: BoxFit.fill),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        overflow: TextOverflow.ellipsis,
                       maxLines: 2,
                      widget.name,
                      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    if (a > 1) {
                      --a;
                      total = total - int.parse(widget.price);
                    }

                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 18,
                ),
                Text(
                  a.toString(),
                  style: AppWidget.semiBoldTextFieldStyle(),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    ++a;
                    total = total + int.parse(widget.price);
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
                overflow: TextOverflow.ellipsis,

              widget.detail,
              style: const TextStyle(fontSize: 18, ),
              maxLines: 6,
            ),
            const SizedBox(
              height: 20,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Row(children: [  Text(
                        widget.phoneNumber,
                        style: AppWidget.semiBoldTextFieldStyle(),
                      ),]  ),
                      Text(
                        'Total price',
                        style: AppWidget.semiBoldTextFieldStyle(),
                      ),
                      Text(
                        'Ksh$total',
                        style: AppWidget.semiBoldTextFieldStyle(),
                      )
                    ],
                  ),
                  GestureDetector(
                      onTap: () async {
                        Map<String, dynamic> addFoodtoCart = {
                          'Name': widget.name,
                          'Quantity': a.toString(),
                          'Total': total.toString(),
                          'Image': widget.image,
                          'PhoneNumber':widget.phoneNumber.toString(),


                        };
                        await DatabaseMethods()
                            .addFoodtoCart(addFoodtoCart, id!);
                      },
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Wallet()),
                                );
                              },
                              child: Material(
                                elevation: 3,
                                child: Container(
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                                  child: const Row(
                                    children: [
                                      Text(
                                        'Checkckout',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ChatPage()),
                                );
                              },
                              child: Material(
                                elevation: 3,
                                child: Container(
                                  
                                  decoration:
                                      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                                  child: const Row(
                                    children: [
                                      Text(
                                        'Whatsapp Me!',
                                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const ChatPage()),
                                  );
                                },
                                child: const Icon(
                                  Icons.message,
                                  color: Colors.green,
                                ))
                          ]))
                ],
              ),
            )
          ])),
    );
  }
}
