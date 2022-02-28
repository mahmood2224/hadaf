import 'package:flutter/cupertino.dart';

double getWidth(BuildContext context){
  return MediaQuery.of(context).size.width ;
}

double getHeight(BuildContext context){
  return MediaQuery.of(context).size.height ;
}

const EdgeInsets PAGE_EDGES_PADDING_ALL = EdgeInsets.all(24);
const EdgeInsets PAGE_EDGES_PADDING_HORIZONTAL = EdgeInsets.symmetric(horizontal: 24);
const EdgeInsets PAGE_EDGES_PADDING_VERTICAL = EdgeInsets.symmetric(vertical: 24);

const EdgeInsets ITEM_PADDING_VERTICAL = EdgeInsets.symmetric(vertical: 7);

const EdgeInsets CONTAINER_CONTENT_PADDING_VERTICAL = EdgeInsets.symmetric(vertical: 4);
const EdgeInsets CONTAINER_CONTENT_PADDING_HORIZONTAL = EdgeInsets.symmetric(horizontal: 8);
const EdgeInsets CONTAINER_CONTENT_PADDING_ALL = EdgeInsets.all(8);