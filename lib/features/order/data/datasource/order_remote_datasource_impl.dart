import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/order/data/datasource/order_remote_datasource.dart';
import 'package:ecommerce_app/features/order/data/models/order_model.dart';
import 'package:ecommerce_app/features/order/domain/entities/order_entity.dart';
import 'package:firebase_core/firebase_core.dart';

 class OrderRemoteDatasourceImpl implements OrderRemoteDatasource{
   final FirebaseFirestore firestore;
   OrderRemoteDatasourceImpl({
     required  this.firestore,
 });
  @override
  Future<void> createOrder(OrderModel order) async {
    await firestore.collection('orders')
        .doc(order.orderId)
        .set(order.toMap());
  }

   @override
  Stream<List<OrderModel>> getOrders(String userId)  {
    try{
    return  firestore.collection('orders')
         .where('userId' , isEqualTo: userId)
         .snapshots().map((snapshot) {
           return snapshot.docs.map((doc)=>OrderModel.fromMap(doc.data())).toList();
         },);
    }catch(e){
      throw Exception(e);
    }
  }

  @override
  Future<void> cancelOrder({required String orderId}) async {
    try{
    await  firestore.collection('orders')
        .doc(orderId)
        .delete();
      
    }catch(e){
      throw Exception(e);
    }
  }

}