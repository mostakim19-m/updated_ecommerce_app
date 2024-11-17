import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_projects/custom_widgets/custom_appbar.dart';

class CategoriesDetails extends StatelessWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> categories;
  const CategoriesDetails({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    final fireStore=FirebaseFirestore.instance;
    return Scaffold(
appBar: customAppBar(
  leading: IconButton(onPressed: (){
    Get.back();
  }, icon: Icon(Icons.arrow_back)),
  title: categories['name'],
),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(image: NetworkImage(categories['icon']),height: 200,width: 200,),
             SizedBox(height: 30,),
            Text(categories['name'],style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30
            ),),
             SizedBox(height: 30,),
            StreamBuilder(
              stream: fireStore.collection('products')
                  .where('cat_id',isEqualTo: categories['id'])
                  .snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(),);
                  }else{
                  return GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          childAspectRatio: .6,
                          crossAxisSpacing: 10
                      ),
                      itemBuilder: (context, index) {
                        final data=snapshot.data!.docs[index];
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.15),
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(data['image']),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data['name'],style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold
                                    ),),
                                    Text(data['price'],style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                    ),),
                                  ],
                                ),
                                SizedBox()
                              ],
                            ),
                          ),
                        );
                      },);
                  }
                },)
          ],
        ),
      ),
    );
  }
}
