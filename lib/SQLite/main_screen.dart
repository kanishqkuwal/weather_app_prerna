import 'package:flutter/material.dart';
import 'package:sample_flutter_project/SQLite/db_handler.dart';
import 'package:sample_flutter_project/SQLite/notes.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  DBHelper? dbHelper ;

  late Future<List<NotesModel>>  notesList ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData() async{
    notesList = dbHelper!.getNotesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes SQL'),
        centerTitle: true,
      ),
      body: Column(

        children: [
            Expanded(
              child: FutureBuilder(
                future: notesList,
                  builder: (context, AsyncSnapshot<List<NotesModel>>  snapshot){

                     if(snapshot.hasData){
                       return  ListView.builder(
                           itemCount: snapshot.data?.length,
                           reverse: false,
                           shrinkWrap: true,
                           itemBuilder:(context,index ){
                             return InkWell(
                               onTap: (){
                                 dbHelper!.update(
                                     NotesModel(
                                    id: snapshot.data![index].id!,
                                     title: 'First flutter note',
                                     age: 21,
                                     description: 'kwmdjenncjn',
                                     email: 'prerna@gmail.com'));
                                 setState(() {
                                   notesList = dbHelper!.getNotesList();
                                 });
                               },
                               child: Dismissible(
                                 direction: DismissDirection.endToStart,
                                 background:Container(
                                   color: Colors.red,
                                   child: Icon(Icons.delete_forever),
                                 ) ,
                                 onDismissed: (DismissDirection direction){
                                   setState(() {
                                           dbHelper!.delete(snapshot.data![index].id!);
                                           notesList = dbHelper!.getNotesList();
                                           snapshot.data!.remove(snapshot.data![index]);
                                   });
                                 },
                                 key: ValueKey<int>(snapshot.data![index].id!),
                                 child: Card(
                                   child:ListTile(
                                     title: Text(snapshot.data![index].title.toString()),
                                     subtitle: Text(snapshot.data![index].description.toString()),
                                     trailing: Text(snapshot.data![index].age.toString()),


                                   ) ,
                                 ),
                               ),
                             );
                           }
                       );
                     } else{
                       return CircularProgressIndicator();
                     }


              }
              ),
            )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          dbHelper?.insert(
              NotesModel(
                  title: 'Blue rose',
                  age: 11,
                  description: ' A blue rose is a flower of the genus Rosa (family Rosaceae) that presents blue-to-violet pigmentation instead of the more common red, white, or yellow. ',
                  email: 'prernakuwal@gmail.com'
              )
          ).then((value) {
            print('data added');
            setState(() {
              notesList = dbHelper!.getNotesList();

            });
          }
          ).onError((error, stackTrace) {
            print(error.toString());
          } );

        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
