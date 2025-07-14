
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryService {
  static Future<void> createDefaultCategoriesForUser(String userId) async {
    final categories = [
      {
        "category": "Sữa",
        "img_url": "https://firebasestorage.googleapis.com/v0/b/grocerystore-8119d.appspot.com/o/milk.png?alt=media&token=1895b70c-04b7-4e83-930f-a546b2d1cec7",
        "idType": 1,
        "userId": userId
      },
      {
        "category": "Hạt",
        "img_url": "https://firebasestorage.googleapis.com/v0/b/grocerystore-8119d.appspot.com/o/hat.png?alt=media&token=49505a53-4700-43cf-b7c6-41fde02aa1a9",
        "idType": 2,
        "userId": userId
      },
      {
        "category": "Bánh Kẹo",
        "img_url": "https://firebasestorage.googleapis.com/v0/b/grocerystore-8119d.appspot.com/o/banhkeo.png?alt=media&token=5f726537-045f-4756-8e60-592a8e9ac37d",
        "idType": 3,
        "userId": userId
      },
      {
        "category": "Nước Giặt Xả",
        "img_url": "https://firebasestorage.googleapis.com/v0/b/grocerystore-8119d.appspot.com/o/nuocgiatxa.png?alt=media&token=ae6ee11b-25a5-46e0-8645-4d3d60467731",
        "idType": 4,
        "userId": userId
      },
      {
        "category": "Kem",
        "img_url": "https://firebasestorage.googleapis.com/v0/b/grocerystore-8119d.appspot.com/o/kem.png?alt=media&token=b53f0559-902c-468e-9924-a4f5d6a12711",
        "idType": 5,
        "userId": userId
      },
      {
        "category": "Nước Ngọt",
        "img_url": "https://firebasestorage.googleapis.com/v0/b/grocerystore-8119d.appspot.com/o/nuocngot.png?alt=media&token=ee72b9b7-ef59-46c6-95fc-41ffedaed5c5",
        "idType": 6,
        "userId": userId
      },
      {
        "category": "Đồ Gia Vị",
        "img_url": "https://firebasestorage.googleapis.com/v0/b/grocerystore-8119d.appspot.com/o/dogiavi.png?alt=media&token=c03e2681-230e-408e-ad20-942fcab431e0",
        "idType": 7,
        "userId": userId
      },
      {
        "category": "Sữa Tắm",
        "img_url": "https://firebasestorage.googleapis.com/v0/b/grocerystore-8119d.appspot.com/o/suatam.png?alt=media&token=af8d5df3-ad1d-4983-949b-a3b210e90642",
        "idType": 8,
        "userId": userId
      },
      {
        "category": "Đồ Khô",
        "img_url": "https://firebasestorage.googleapis.com/v0/b/grocerystore-8119d.appspot.com/o/dokho.png?alt=media&token=2b5b9f7e-cbdb-4591-8305-4484b13afd91",
        "idType": 9,
        "userId": userId
      },

    ];

    final batch = FirebaseFirestore.instance.batch();
    final collection = FirebaseFirestore.instance.collection('Category');
    for (var category in categories) {
      final docRef = collection.doc();
      batch.set(docRef, category);
    }

    await batch.commit();
  }
}