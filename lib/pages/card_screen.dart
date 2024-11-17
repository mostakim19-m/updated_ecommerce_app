import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice_projects/custom_widgets/custom_appbar.dart';
import '../custom_widgets/custom_button.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final fireStore=FirebaseFirestore.instance;
  final user=FirebaseAuth.instance.currentUser;


  List<QueryDocumentSnapshot> cardItem=[];

double totalAmount=0.0;

 double calculatorAmount(){
   double finalAmount=0.0;
  for(var data in cardItem){
    double price=double.parse(data['Price']);
    int quantity=data['Quantity'];
     finalAmount = price*quantity;
   totalAmount=finalAmount;
  }
  return finalAmount ;
}
  @override
  Widget build(BuildContext context) {
   print(totalAmount);
    final size=MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: customAppBar(
        title: 'My Card',
        leading: IconButton(onPressed: (){
        }, icon: Icon(Icons.arrow_back))
      ),

      //CardList

      body:StreamBuilder(
        stream: fireStore.collection('Users').doc(user!.email).collection('Card').snapshots(),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }else{
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) {
                  final data=snapshot.data!.docs[index];
                  cardItem=snapshot.data!.docs;
                  calculatorAmount();
                  return  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
                    height: size.height*.12,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.1),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: size.height*.1,
                            width: size.width*.25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                            ),
                            child: Center(child: Image.network(data['Image']),),
                          ),
                           Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data['Name'],style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),),
                                Text(' ${data['Price']}',style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.indigo
                                ),)
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             data['Size']!='null'?  Text('Size:${data['Size']}',style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),):SizedBox(),
                              const SizedBox(height: 10,),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.indigo,
                                        width: 2
                                    )
                                ),
                                child:  Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4.0,vertical:5),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if(data['Quantity'] >1){
                                            fireStore.collection('Users').doc(user!.email)
                                                .collection('Card')
                                                .doc(data.id).update({
                                              'Quantity':data['Quantity'] -1,
                                            });
                                          }else{
                                            fireStore.collection('Users').doc(user!.email)
                                                .collection('Card').doc(data.id).delete();
                                          }

                                        },
                                          child:data['Quantity']==1? Icon(Icons.delete): Icon(Icons.remove)),

                                      Text(data['Quantity'].toString(),style: const TextStyle(
                                        fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black
                                      ),),

                                      InkWell(
                                        onTap: () {
                                          fireStore.collection('Users').doc(user!.email)
                                              .collection('Card').doc(data.id)
                                              .update({
                                            'Quantity':data['Quantity'] +1,
                                          });
                                        },
                                          child: Icon(Icons.add))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },);
            }
          },),



      bottomNavigationBar: Container(
        height: size.height*.15,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text('Total',style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 23
              ),),
              Text('\$8000',style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 23
              ),),

              ],
            ),
            CustomButton(title: 'Add To Card',onTap: () {

            },)
          ],
        ),
      ),
    );
  }
}
