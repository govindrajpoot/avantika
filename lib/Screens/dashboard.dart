import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Model/dashboardmodel.dart';
import '../loginscreen.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {

@override
  void initState() {
    // TODO: implement initState
  fetchData();
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    fetchData();
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Padding(
          padding: const EdgeInsets.only(left: 1,top: 10,bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("assets/header_logo.png",height: 50,width:MediaQuery.of(context).size.width*0.6,),
               //AssetImage("assets/splashlogo.png"),

              //SizedBox(width: 17,),
              Icon(Icons.notifications),
              Icon(Icons.person),



            ],),
        ),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*  FutureBuilder<GetUserPost?>(
                      future:  createAlbum(),
                      builder: (context, snapshot) {

                        if (snapshot.hasData) {
                          late bool photoUrl;
                          try {
                            int a = snapshot.data!.posts!.isEmpty ? 0: 10 ?? 0;
                            photoUrl = a==0? false:true;
                          }catch (e){
                          }
                          print(photoUrl);
                          return
                            Column(
                            children: [
                              //Commonappbar(),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30.0,
                                    backgroundColor: Colors.grey,
                                    child:photoUrl?
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.network(snapshot.data!.posts![0].userDetails![0].profileImage.toString(), width: 60,
                                        height: 60,fit: BoxFit.fill,),
                                    )
                                        :
                                    InkWell(
                                      //onTap: imagePickerOption,
                                      child: Image.asset(
                                        ImageConst().UPLOAD_IMAGES,
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),

                                  Center(child: photoUrl?
                                  Text( snapshot.data!.posts![0].userDetails![0].name ?? "",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),)
                                      :Text("Name"),
                                  ),
                                ],
                              ),

                            ],
                          );
                        }
                        else{
                          return Center(child: CircularProgressIndicator());
                        }

                      }
                  ),*/




                  Divider(thickness: 1.5,),
                  SizedBox(height: 25,),
                  InkWell(
                    onTap: (){
                      // Navigator.push(context, MaterialPageRoute(
                      //     builder: (context) => Notificationscreen()));
                    },
                    child: Row(children: [
                      Icon(Icons.supervised_user_circle,size: 28,),
                      SizedBox(width: 10,),
                      Text("Complete Profile",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                    ],),
                  ),

                ],),
            ),
            ListTile(
              title:
              InkWell(
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(
                  //     builder: (context) => Notificationscreen()));
                },
                child: Row(children: [
                  Icon(Icons.supervised_user_circle,size: 28,),
                  SizedBox(width: 10,),
                  Text("My connection",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                ],),
              ),
            ),

            ListTile(
              title:
              InkWell(
                // onTap: (){
                //   Navigator.push(context, MaterialPageRoute(
                //       builder: (context) => DeviceCompatibility()));
                // },
                child: Row(children: [
                  Icon(Icons.phone_android,size: 28,),
                  SizedBox(width: 10,),
                  Text("Device compatibility",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                ],),
              ),
            ),
            ListTile(
              title:
              InkWell(
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(
                  //     builder: (context) => Notificationscreen()));
                },
                child: Row(children: [
                  Icon(Icons.help_outline_outlined,size: 28,),
                  SizedBox(width: 10,),
                  Text("Help",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                ],),
              ),
            ),
            ListTile(
              title:
              InkWell(
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(
                  //     builder: (context) => Notificationscreen()));
                },
                child: Row(children: [
                  Icon(Icons.settings,size: 28,),
                  SizedBox(width: 10,),
                  Text("Setting",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                ],),
              ),
            ),

            ListTile(
              title:
              InkWell(
               onTap: () async {
                 // SharedPreferences pref = await SharedPreferences.getInstance();
                 // pref.remove("email");
                  //Navigator.pop(context);
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => signinscreen()));
                },
                child: Row(children: [
                  Icon(Icons.logout,size: 28,),
                  SizedBox(width: 10,),
                  Text("Logout",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                ],),
              ),
            ),
          ],
        ),
      ),
      body: 
      SingleChildScrollView(
        child:

        FutureBuilder<Dashboard?>(
            future:  fetchData(),
            builder: (context, snapshot) {

              if (snapshot.hasData) {
                return

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      Container(
                        height: 185,
                        //height:MediaQuery.of(context).size.height*0.23,
                        //width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/learn.jpg"),
                              //fit: BoxFit.fill,
                            )),
                      ),

                      Container(
                        height: 100,
                        // width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/screenlogo.png"),
                              // fit: BoxFit.fill,
                            )),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xffffbf00),
                                borderRadius: BorderRadius.circular(12)
                            ),
                            height: 70,
                            width: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Text("Project"),
                                Text(snapshot.data!.data.projects.toString(),style: TextStyle(color: Colors.white),),
                              ],),
                          ),
                          Container(
                            height: 70,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Color(0xffffbf00),
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Text("Man-hourse"),
                                Text(snapshot.data!.data.manpower.toString(),style: TextStyle(color: Colors.white),),
                              ],),
                          ),
                          Container(
                            height: 70,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Color(0xffffbf00),
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Text("Rotarians"),
                                Text(snapshot.data!.data.rotarian.toString(),style: TextStyle(color: Colors.white),),
                              ],),
                          ),
                        ],),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xffffbf00),
                                borderRadius: BorderRadius.circular(12)
                            ),
                            height: 70,
                            width: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Text("Non-rotarians"),
                                Text("0"),
                              ],),

                          ),
                          Container(
                            height: 70,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Color(0xffffbf00),

                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Text("Total Cost"),
                                Text(snapshot.data!.data.totalCost.toString(),style: TextStyle(color: Colors.white),),
                              ],),
                          ),
                          Container(
                            height: 70,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Color(0xffffbf00),
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Beneficiaries"),
                                Text(snapshot.data!.data.totalBeneficiaries.toString(),style: TextStyle(color: Colors.white),),
                              ],),
                          ),
                        ],),


                      SizedBox(height: 10,),

                      Container(
                        height: 33,
                        padding: EdgeInsets.only(left: 16,right: 16),
                        color: Colors.blueAccent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Events in focus"),
                            Text("View all"),
                          ],),
                      ),


                      Container(
                        height: 130,
                        // width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/confero.jpg"),
                              // fit: BoxFit.fill,
                            )),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("CONFERO District Conference"),
                            SizedBox(height: 5,),
                            Text("Dhichange Resort,Sunapur"),
                            SizedBox(height: 5,),
                            Text("06-01-2024"),
                          ],),
                      ),


                      Container(
                        height: 33,
                        padding: EdgeInsets.only(left: 16,right: 16),
                        color: Colors.blueAccent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Clubs in Action"),
                            Text("View all"),
                          ],),
                      ),


                      Container(
                        height: 200,
                        // width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/group.jpg"),
                              // fit: BoxFit.fill,
                            )),
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Text("Celebrating Doctor's And Chartered Accountant's Day",style: TextStyle(fontWeight: FontWeight.w500),)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [


                            Text("Our club felicitated 5 doctors and 5 Chartered accounts on the day."),
                            SizedBox(height: 8,),
                            Text("Total Cost:- ${snapshot.data!.data.totalCost.toString()}",style: TextStyle(fontWeight: FontWeight.w500),),
                            SizedBox(height: 5,),

                            Text("Total Manpower:- ${snapshot.data!.data.totalMembers.toString()}",style: TextStyle(fontWeight: FontWeight.w500),),
                            SizedBox(height: 5,),

                            Text("Total Beneficiaries:- ${snapshot.data!.data.totalBeneficiaries.toString()}",style: TextStyle(fontWeight: FontWeight.w500),),

                            SizedBox(height: 22,),




                          ],),
                      )


                    ],);

                  /*Column(
                    children: [
                      //Commonappbar(),
                      Row(
                        children: [
                          // Text( snapshot.data!.posts![0].userDetails![0].name ?? "",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),)
                          //     :Text("Name"),

                          Text(snapshot.data!.data.projects.toString()),
                        ],
                      ),

                    ],
                  );*/
              }
              else{
                return Container(
                    height: 500,
                    child: Center(child: CircularProgressIndicator()));
              }

            }
        ),


      ),


    );
  }



Future<Dashboard?> fetchData() async {
  final String url = 'https://rid3240.avantikain.com/api/v1/app/get-webdashboard-data';

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print(response.body.toString());
      print("response ");
      return Dashboard.fromJson(jsonDecode(response.body));
    } else {
      print('Request failed with status: ${response.statusCode}');
      return null;
    }
  } catch (error) {
    print('Error: $error');
    return null;
  }
}





/*  Future<Dashboard?> fetchData() async {
    final String url = 'https://rid3240.avantikain.com/api/v1/app/get-webdashboard-data';

    try {
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        print(response.data.toString());
        print("response ");
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }*/

}
