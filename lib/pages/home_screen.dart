import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:practice_projects/custom_widgets/custom_appbar.dart';
import 'package:practice_projects/custom_widgets/products_details.dart';
import 'package:practice_projects/pages/categories_details.dart';
import 'package:practice_projects/pages/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final fireStore=FirebaseFirestore.instance;
  //slider Image
  List<String> image=[
    'https://pinnaclebanner.co.uk/wp-content/uploads/2021/01/221-1.jpg',
    'https://d1xv5jidmf7h0f.cloudfront.net/circleone/images/products_gallery_images/Outdoor-Banners.jpg',
    'https://graphicsfamily.com/wp-content/uploads/edd/2024/01/Fashion-sale-web-banner-design-870x489.jpg'
  ];
  //firebaseSliderImage
 List firebaseSlider=[];
 
void getFirebaseSlider()async{
 final data= await fireStore.collection('banners').get();

 setState(() {
   firebaseSlider=data.docs;
 });
}
List<Map<String,String>> categories=[
  {
    'icon':'images/assest.png'
  },
  {
    'icon':'images/images.png'
  },
  {
    'icon':'images/images1.png'
  },
  {
    'icon':'images/images2.png'
  },
];

List<Map<String,String>> products=[
  {
    'image':'https://pngimg.com/uploads/watches/small/watches_PNG9868.png',
    'name':'Redmi Watch 5',
    'price':'\$ 500'
  },
  {
    'image':'https://static.vecteezy.com/system/resources/thumbnails/021/958/059/small/simple-computer-laptop-isolated-png.png',
    'name':'Lenovo Laptop 5',
    'price':'\$ 8000'
  },
  {
    'image':'https://pngimg.com/uploads/watches/small/watches_PNG101456.png',
    'name':'Samsung Watch 5',
    'price':'\$ 900'
  },
  {
    'image':'https://pngimg.com/uploads/watches/small/watches_PNG9868.png',
    'name':'Redmi Watch 5',
    'price':'\$ 500'
  },
  {
    'image':'https://static.vecteezy.com/system/resources/thumbnails/021/958/059/small/simple-computer-laptop-isolated-png.png',
    'name':'Lenovo Laptop 5',
    'price':'\$ 8000'
  },
  {
    'image':'https://pngimg.com/uploads/watches/small/watches_PNG101456.png',
    'name':'Samsung Watch 5',
    'price':'\$ 900'
  },
];


@override
  void initState() {
    super.initState();
    getFirebaseSlider();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: customAppBar(
        leading: IconButton(onPressed: (){
          FirebaseAuth.instance.signOut();
          Get.to(()=> LoginScreen());
          Fluttertoast.showToast(msg: ' User LogOut Successfully',
              backgroundColor:Colors.indigo,textColor: Colors.white);
        }, icon:const Icon(Icons.menu)),
        action: [
          const Icon(Icons.search_rounded)
        ]
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Deatils Product',style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),),
                Text('Last Seen Shopping')
              ],
            ),
            CarouselSlider.builder(
                itemCount: firebaseSlider.length,
                itemBuilder: (context, index, realIndex) {
                  return firebaseSlider.isEmpty?Center(child: CircularProgressIndicator(),): Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      bottom: 10,
                      top: 15
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(image: NetworkImage(firebaseSlider[index]['image']),
                      fit: BoxFit.cover)
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 150,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  // autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                )),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Top Categories',style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),),
                Text('See All',style: TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold
                ),)
              ],
            ),
            const SizedBox(height: 20,),

            //categories
           StreamBuilder(stream: fireStore.collection('categories').snapshots(),
               builder: (context, snapshot) {
                 if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                 }else{
                  return SizedBox(
                     height: 100,
                     child: ListView.builder(
                       scrollDirection: Axis.horizontal,
                       itemCount: snapshot.data!.docs.length,
                       shrinkWrap: true,
                       primary: false,
                       itemBuilder: (context, index) {
                         return InkWell(
                           onTap: () {
                             Get.to(()=> CategoriesDetails(categories: snapshot.data!.docs[index],));
                           },
                           child: Container(
                             width: 80,
                             margin: EdgeInsets.symmetric(horizontal: 5),
                             decoration: BoxDecoration(
                                 color: Colors.black.withOpacity(.1),
                                 borderRadius: BorderRadius.circular(10),
                                 border: Border.all(
                                     color: Colors.black,
                                     width: 2
                                 )
                             ),
                             child: Column(
                               children: [
                                 Center(child: Image.network(snapshot.data!.docs[index]['icon']?? 'No Image\nAvailable'),),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Text(snapshot.data!.docs[index]['name']?? 'No Name Now'),
                                     SizedBox(width: 10,),
                                     Text(snapshot.data!.docs[index]['id']?? '0')
                                   ],
                                 ),
                               ],
                             ),
                           ),
                         );
                       },),
                   );
                 }
               },),

            const SizedBox(height: 20,),

            //products
            Expanded(
              child: StreamBuilder(stream: fireStore.collection('products').snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState==ConnectionState.waiting){
                     return Center(child: CircularProgressIndicator(),);
                    }else{
                      return GridView.builder(
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        primary: false,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: .6),
                        itemBuilder: (context, index) {
                          final data=snapshot.data!.docs[index];
                          return InkWell(
                            onTap: () {
                              Get.to(()=>ProductsDetails(products: data,));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(.15),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 20,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16)
                                    ),
                                    child: Center(child: Text('50% Off'),),
                                  ),

                                  Image.network(data['image']?? 'No Image Now',fit: BoxFit.cover,
                                    height: 180,),
                                  SizedBox(height: 20,),
                                  Text(data['name']?? 'Default Title',style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),),
                                  SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 7),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(data['price']?? 'No Price',style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black
                                        ),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },);
                    }
                  },)
            )

          ],
        ),
      ),
    );
  }

}


