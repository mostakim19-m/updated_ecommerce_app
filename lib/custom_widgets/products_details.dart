import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:practice_projects/custom_widgets/custom_appbar.dart';
import 'package:practice_projects/custom_widgets/custom_button.dart';

class ProductsDetails extends StatefulWidget {
final QueryDocumentSnapshot<Map<String, dynamic>> products;
  const ProductsDetails({super.key, required this.products});

  @override
  State<ProductsDetails> createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {

  List<String> variant=['35','34','40','46','50','55'];

  final user=FirebaseAuth.instance.currentUser;

  final fireStore=FirebaseFirestore.instance;

  int selectedIndex=0;

String? selectedValue;

addChange(){
  setState(() {
    selectedValue=widget.products['variant'].isEmpty ? 'null': widget.products['variant'][0];
  });
}

@override
  void initState() {
    super.initState();
    addChange();
  }

  @override
  Widget build(BuildContext context) {
  print(selectedValue);
    final size=MediaQuery.sizeOf(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: customAppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height*.3,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.10)
                ),
                child: Image.network(widget.products['image']?? 'No Image Now',
                fit: BoxFit.fill,),
              ),
              const SizedBox(height: 20,),
              Text(widget.products['name']?? 'No Name Now',style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.products['price']??'No Price',style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),),
                  const Text('Avaible In Stock',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),),
                ],
              ),
              const SizedBox(height: 20,),
              const Text('About',style: TextStyle(
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
                fontSize: 25
              ),),
               Text(widget.products['description']?? 'No Description in products',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),)
            ],
          ),
        ),
      ),


      bottomNavigationBar: Container(
        height: size.height*.2,
       width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height*.06,
              child: ListView.builder(
                itemCount:widget.products['variant'].length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex=index;
                      selectedValue=widget.products['variant'][index];
                    });
                  },
                  child: Container(
                    width: size.width*.12,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color:selectedIndex==index? Colors.indigoAccent:null,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.indigo,
                        width: 2
                      )
                    ),
                    child: Center(child: Text(widget.products['variant'][index],style: TextStyle(
                      color:selectedIndex==index? Colors.white:Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),),),
                  ),
                );
              },),
            ),
            CustomButton(title: 'Add To Card',
            onTap: ()async {
              await fireStore.collection('Users').doc(user!.email).collection('Card')
                  .add({
                'Email':user!.email,
                'Name':widget.products['name'],
                'Image':widget.products['image'],
                'Price':widget.products['price'],
                'Cat_id':widget.products['cat_id'],
                'Size':selectedValue,
                'Quantity':1
              }).then((value) {
                Fluttertoast.showToast(msg: 'Card added Successfully done');
              },);
            },)
          ],
        ),
      ),
    );
  }
}
