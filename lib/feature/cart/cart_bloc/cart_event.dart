import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CartEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCategories extends CartEvents {}
