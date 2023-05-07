import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app_library/logins/loginScreen.dart';
import 'package:url_launcher/url_launcher.dart';
class navigation_Drawer extends StatefulWidget {
  const navigation_Drawer({Key? key}) : super(key: key);

  @override
  State<navigation_Drawer> createState() => _navigation_DrawerState();
}

class _navigation_DrawerState extends State<navigation_Drawer> {
  @override
  Widget build(BuildContext context) {
      return Drawer
        (
        child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 5,bottom: 10),
            child: Text('SETTINGS', style: TextStyle(fontSize: 18,
            color: Colors.orange[800],
            fontWeight: FontWeight.bold),),
          ),
          Divider
            (
            height: 10,
            color: Colors.orange[800],
          ),
          ListTile(
            leading: Icon(Icons.home,color: Colors.orange[800],),
            title:  const Text('Home'),
            onTap: ()=>Fluttertoast.showToast(msg: 'You are already at the home page.'),
          ),
          ListTile(
            leading:  Icon(Icons.book_online,color: Colors.orange[800],),
            title:  const Text('Books'),
            onTap: ()=>Navigator.pushReplacementNamed(context, 'favouriteBooks'),
          ),
          ListTile(
            leading:  Icon(Icons.search,color: Colors.orange[800]),
            title:  const Text('Search'),
            onTap: ()=>Navigator.pushReplacementNamed(context,'search'),
          ),
          ListTile(
            leading:  Icon(Icons.notifications,color: Colors.orange[800]),
            title:  const Text('Notification'),
            onTap: ()=>Navigator.pushReplacementNamed(context,'notification'),
          ),
          ListTile(
            leading:  Icon(Icons.help_center,color: Colors.orange[800]),
            title:  const Text('Reach to Us'),
            onTap: ()=> alertDialog()
          ),
          ListTile(
            leading:  Icon(Icons.settings,color: Colors.red[800]),
            title:  const Text('Delete Account'),
            onTap: ()=> Navigator.pushReplacementNamed(
                context,'deleteAcc'),
          ),
          ListTile(
              leading:  Icon(Icons.exit_to_app,color: Colors.orange[400]),
              title:  const Text('Log out'),
              onTap: (){
                FirebaseAuth.instance.signOut().then((value)
                {
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
                });
              }
          ),
        ],
      ),
      );
    }
  alertDialog()
  {
    showDialog(
        context: context,
        builder: (context)
        {
          return  AlertDialog(
            content: Container(
              child: Column(
                children: [
                  IconButton(
                      onPressed: (){whatsApp();},
                      icon:const Icon(Icons.messenger_outline)),
                  const SizedBox(height: 10,),
                  IconButton(
                      onPressed: (){openMail();},
                      icon:const Icon(Icons.mail)),
                  const SizedBox(height: 10,),
                  IconButton(
                      onPressed: ()
                      {
                        launchUrl(
                            Uri.parse('tel:+254704858069')
                        );
                      },
                      icon:const Icon(Icons.phone)),
                  const SizedBox(height: 10,),
                  const Text('Reach out to us In case of any difficulty encountered.\n'
                      ' We are here for you!!\n'
                      '  Kibabii University \n'
                      'MISSION: To achieve excellence in generation, transmission\n'
                      'enhancement of new knowledge in Science, Technology and Innovation\n'
                      ' through quality Teaching, Research, Training, Scholarship,\n'
                      ' Consultancy and Outreach programmes.\n'
                      '\n'
                      'VISION: To be a global and dynamic University of excellence in Science,\n'
                      ' Technology and Innovation.'),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextButton(
                        onPressed:(){Navigator.pushReplacementNamed(context, 'trial');}, child: const Text('Home')),
                  )
                ],
              ),
            )
          );
        });
  }
  whatsApp() {
    return launchUrl(
      Uri.parse(
        'whatsapp://send?phone=+254704858069+&text=Hello, Iam using the Kibabbii Library App'
            'application and I would like to enquire about...',
      ),
    );
  }
  openMail(){
    return launchUrl(
        Uri.parse(
            'mailto:mwichabecollins@gmail.com?subject=Hello&body=Iam using Kibabii Library App and I would like to enquire about...)'
        )
    );
  }
}

