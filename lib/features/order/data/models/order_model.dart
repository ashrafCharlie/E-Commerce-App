import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:ecommerce_app/features/order/domain/entities/order_entity.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';

class OrderModel extends  OrderEntity{
 const OrderModel({
   required super.orderId,
   required super.userId,
   required super.customerName,
   required super.phone,
   required super.address,
   required super.city,
   required super.paymentMethod,
   required super.totalPrice,
   required super.status,
   required super.createdAt,
   required super.items});

 Map<String,dynamic> toMap(){
   return {
     'orderId': orderId,
     'userId' : userId,
     'customerName' : customerName,
     'phone' : phone,
     'address' : address,
     'city' : city,
     'paymentMethod': paymentMethod,
     'totalPrice' : totalPrice,
     'status' : status,
     'createdAt' : createdAt,
     'items': items.map((item){
       return{
         "productId" : item.product.productId,
         'productTitle' : item.product.productTitle,
         'productPrice': item.product.productPrice,
         'productImage' : item.product.productImage,
         'quantity' : item.quantity,
         'productDescription': item.product.productDescription,
         'productCategory' : item.product.productCategory,
         'productRating' : item.product.productRating,
       };
     }).toList(),
   };
 }
 factory OrderModel.fromMap(Map<String, dynamic> map){
   return OrderModel(
       orderId: map['orderId'] as String,
       userId: map['userId'] as String ,
       customerName: map['customerName'] as String,
       phone: map['phone'] as String,
       address: map['address'] as String,
       city: map['city'] as String,
       paymentMethod: map['paymentMethod'] as String,
       totalPrice: (map['totalPrice'] as num).toDouble(),
       status: map['status'] as String,
       createdAt: (map['createdAt'] as Timestamp).toDate(),
       items: (map['items'] as List<dynamic>).map((item) {
         final itemMap = item as Map<String, dynamic> ;
         final product = ProductEntity(
             productId: itemMap['productId'] as int ,
             productTitle: itemMap['productTitle'] as String,
             productPrice: (itemMap['productPrice'] as num).toDouble() ,
             productDescription: itemMap['productDescription'] as String,
             productImage: itemMap['productImage'] as String,
             productCategory: itemMap['productCategory'] as String,
             productRating: (itemMap['productRating'] as num).toDouble());
         return CartItemEntity(
             product: product,
             quantity: itemMap['quantity'] as int);

       },).toList());
 }


 factory OrderModel.fromEntity(OrderEntity order){
   return OrderModel(
       orderId: order.orderId,
       userId: order.userId,
       customerName: order.customerName,
       phone: order.phone,
       address: order.address,
       city: order.city,
       paymentMethod: order.paymentMethod,
       totalPrice: order.totalPrice,
       status: order.status,
       createdAt: order.createdAt,
       items: order.items);
 }

}