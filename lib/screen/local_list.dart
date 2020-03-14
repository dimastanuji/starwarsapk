import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:starwarsapk/model/local.dart';
import 'package:starwarsapk/screen/detail_people.dart';
import 'package:starwarsapk/screen/local_detail.dart';
import 'package:starwarsapk/utils/database_helper.dart';



class LocalList extends StatefulWidget {

	@override
  State<StatefulWidget> createState() {

    return LocalListState();
  }
}

class LocalListState extends State<LocalList> {

	DatabaseHelper databaseHelper = DatabaseHelper();
	List<Local> localList;
	int count = 0;

	@override
  Widget build(BuildContext context) {

		if (localList == null) {
			localList = List<Local>();
			updateListView();
		}

    return Scaffold(
	    appBar: AppBar(
		    title: Text('People Save'),
	    ),

	    body: getLocalListView(),

    );
  }

  ListView getLocalListView() {

		TextStyle titleStyle = Theme.of(context).textTheme.subhead;

		return ListView.builder(
			itemCount: count,
			itemBuilder: (BuildContext context, int position) {
				return Card(
					color: Colors.white,
					elevation: 2.0,
					child: ListTile(

						leading: CircleAvatar(
							backgroundColor: getPriorityColor(this.localList[position].priority),
							child: getPriorityIcon(this.localList[position].priority),
						),

						title: Text(this.localList[position].nama, style: titleStyle,),

						subtitle: Text(this.localList[position].date),

						trailing: GestureDetector(
							child: Icon(Icons.edit, color: Colors.grey,),
							onTap: () {
								debugPrint("ListTile Tapped");
							navigateToDetail(this.localList[position],'Edit People');
							},
						),
						onTap: () {
							 Navigator.push(context, MaterialPageRoute(builder: (context)=>Peoplee(this.localList[position].url)));
						},

					),
				);
			},
		);
  }

  // Returns the priority color
	Color getPriorityColor(int priority) {
		switch (priority) {
			case 1:
				return Colors.red;
				break;
			case 2:
				return Colors.yellow;
				break;

			default:
				return Colors.yellow;
		}
	}

	// Returns the priority icon
	Icon getPriorityIcon(int priority) {
		switch (priority) {
			case 1:
				return Icon(Icons.play_arrow);
				break;
			case 2:
				return Icon(Icons.keyboard_arrow_right);
				break;

			default:
				return Icon(Icons.keyboard_arrow_right);
		}
	}

	void _delete(BuildContext context, Local local) async {

		int result = await databaseHelper.deleteLocal(local.id);
		if (result != 0) {
			_showSnackBar(context, 'Note Deleted Successfully');
			updateListView();
		}
	}

	void _showSnackBar(BuildContext context, String message) {

		final snackBar = SnackBar(content: Text(message));
		Scaffold.of(context).showSnackBar(snackBar);
	}

  void navigateToDetail(Local local, String title) async {
	  bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
		  return LocalDetail(local, title);
	  }));

	  if (result == true) {
	  	updateListView();
	  }
  }

  void updateListView() {

		final Future<Database> dbFuture = databaseHelper.initializeDatabase();
		dbFuture.then((database) {

			Future<List<Local>> localListFuture = databaseHelper.getLocalList();
			localListFuture.then((localList) {
				setState(() {
				  this.localList = localList;
				  this.count = localList.length;
				});
			});
		});
  }
}







