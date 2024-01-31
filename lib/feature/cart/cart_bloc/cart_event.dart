import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CartEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCategories extends CartEvents {}

class UpdateItemQuantity extends CartEvents {
  final int categoryIndex;
  final int itemIndex;
  final int newQuantity;

  UpdateItemQuantity({required this.categoryIndex, required this.itemIndex, required this.newQuantity});
}
