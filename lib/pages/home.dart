import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soko_fresh/Service/database.dart';
import 'package:soko_fresh/consts/app_constants.dart';
import 'package:soko_fresh/pages/details.dart';
import 'package:soko_fresh/pages/search.dart';
import 'package:soko_fresh/widgets/widget_support.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ... existing Home code
 bool farmer = false,
      distributor = false,
      grocerystore = false,
      consumer = false;

  Stream? fooditemStream;

  void updateCategorySelection(String category) async {
    try {
      farmer = category == "Farmer";
      distributor = category == "Distributor";
      grocerystore = category == "Grocery Store";
      consumer = category == "Consumer";
      fooditemStream = await DatabaseMethods().getFoodItem(category);
    } catch (error) {
      // Handle error, e.g. display a message to the user
      print("Error fetching data: $error");
    } finally {
      setState(() {});
    }
  }


  Widget allItems() {
    return StreamBuilder(
        stream: fooditemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsetsDirectional.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Details(
                                      detail: ds['Detail'],
                                      image: ds['Image'],
                                      name: ds['Name'],
                                      price: ds['Price'],
                                       phoneNumber: ds['PhoneNumber'],
                                    )));
                      },
                      child: Material(
                        elevation: 5,
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          padding: const EdgeInsets.all(13),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  ds['Image'],
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    ds['Name'],
                                    style: AppWidget.semiBoldTextFieldStyle(),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                 
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Ksh' + ds['Price'],
                                    style: AppWidget.semiBoldTextFieldStyle(),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : const CircularProgressIndicator();
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('android/assets/images/wallet.png'),
        ),
        title: const Text('SOKO_FRESH'),
      ),
      body:
        Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Swiper(
                    autoplay: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Material(
                          elevation: 6,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Image.asset(
                              AppConstants.bannersImages[index],
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: AppConstants.bannersImages.length,
                    pagination: const SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                          activeColor: Colors.red, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Container(
                    margin: const EdgeInsets.only(
                      right: 20,
                    ),
                    child: showItem()),
              ),
              const SizedBox(
                height: 20,
              ),
             // Container(height: 200, child: allItems()),
            ],
          ),
        ),
      
    );
  }

  Widget showItem() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      children: [
        GestureDetector(
          onTap: () async {
            farmer = true;
            distributor = false;
            grocerystore = false;
            consumer = false;
            fooditemStream = await DatabaseMethods().getFoodItem('Farmer');
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SearchPage( ),
      ),
    );
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(10),
              child: Column(
                children: [
                  const Text(
                    'Farmer',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      'android/assets/images/farmer.jpg',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            farmer = false;
            distributor = true;
            grocerystore = false;
            consumer = false;
            fooditemStream = await DatabaseMethods().getFoodItem('Distributor');
Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SearchPage( ),
      ),
    );
            setState(() {
             
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: [
                    const Text('Distributor',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'android/assets/images/distributors.jpg',
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                )),
          ),
        ),
        GestureDetector(
          onTap: () async {
            farmer = false;
            distributor = false;
            grocerystore = true;
            consumer = false;
            fooditemStream = fooditemStream =
                await DatabaseMethods().getFoodItem('Grocery Store');
Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SearchPage( ),
      ),
    );
            setState(() {
              
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: [
                    const Text('Grocery Store',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'android/assets/images/grocerystore.jpg',
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                )),
          ),
        ),
        GestureDetector(
          onTap: () async {
            farmer = false;
            distributor = false;
            grocerystore = false;
            consumer = true;
            fooditemStream = await DatabaseMethods().getFoodItem('Consumer');
Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SearchPage( ),
      ),
    );
            setState(() {
          
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: [
                    const Text('Çonsumer',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'android/assets/images/consumer.jpg',
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        )),
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
