import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Pet_Meal_Tracker/DateTime/dateTimeHandler.dart';

class DataHandler {

  final databaseReference = Firestore.instance;
  DateTimeHandler dt = new DateTimeHandler();

  // Get Meals
  void getMeals() {
    databaseReference.collection("Meals").getDocuments().then((querySnapshot) {
    querySnapshot.documents.forEach((result) {
      print(result.data);
    });
    });
  }
  
  // Add Meal
  void addMeal(groupName) {

    var mealTime = dt.getTime();

    var data = {
      dt.getDate(): FieldValue.arrayUnion([mealTime]),
    };

    databaseReference.collection("Meals")
      .document(groupName)
        .updateData(data).then((value) {
          print("Successful write.");
        }).catchError((error) {
          print(error);
        });
  }

  // Delete Meal
  void deleteMeal(meal) {

    var data = {
      dt.getDate(): FieldValue.arrayRemove([meal]),
    };

    databaseReference.collection("Meals")
      .document("rx9zwtilIoMO04XLOw8g")
        .updateData(data).then((value) {
          print("Successfuly removed $meal.");
        }).catchError((error) {
          print(error);
        });
  }

  // Create Group
  void createGroup(userName) {
    databaseReference.collection("Meals").add({
      "admin" : userName,
      "createdDate" : dt.getDate()
    }).then((value) {
      print(value.documentID);
    });
  }

  // Delete Document
  void deleteDocument(docName) {
    databaseReference.collection("meals")
    .document(docName)
    .delete()
    .then((value) 
      { 
        print("Doc deleted");
      }
    ).catchError((onError) {
      print(onError);
    });
  }
}