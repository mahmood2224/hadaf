import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '/data/models/node_zone_model.dart';
import '/utils/colors.dart';
import '/utils/sizes.dart';
class AutoCompleteTextField extends StatelessWidget {
  String value;
  String hint;
  double width;
  double height;
  IconData icon;
  Widget iconWidget;
  List<NodeZone> items ;
  Function onSelectItem ;


  AutoCompleteTextField({this.value, this.hint, this.width, this.height,
      this.icon, this.iconWidget ,@required this.items , @required this.onSelectItem});

  // static const List<String> _kOptions = <String>[
  //   'aardvark',
  //   'bobcat',
  //   'chameleon',
  // ];

  @override
  Widget build(BuildContext context) {
    return Autocomplete<NodeZone>(
      fieldViewBuilder: (
          BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted
      ){
        return TextField(
          controller: fieldTextEditingController..text = value??'',
          focusNode: fieldFocusNode,
          decoration: InputDecoration(
              hintText: this.hint ?? "",
              contentPadding: EdgeInsets.only(top: 3, right: 8 ,left: 8),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: BORDER_COLOR, width: 1),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(8),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: PRIMARY_COLOR, width: 1),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(8),
                ),
              ),
              suffixIcon: this.iconWidget == null ?(this.icon==null ? null:Icon(this.icon)) :Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  this.iconWidget,
                ],
              )
          ),
        );
      },
      optionsViewBuilder: (
          BuildContext context,
          AutocompleteOnSelected<NodeZone> onSelected,
          Iterable<NodeZone> options
          ) {
              return Align(
              alignment: Alignment.topLeft,
              child: Material(
                child: Container(
                  width: 300,
                  color: Colors.white,
                  child: ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final NodeZone option = options.elementAt(index);

                      return GestureDetector(
                        onTap: () {
                          onSelected(option);
                        },
                        child: ListTile(
                          title: Text(option?.zoon_name, style: const TextStyle(color: Colors.black)),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<NodeZone>.empty();
        }
        return this.items.where((NodeZone item) {
          return item?.zoon_name?.startsWith(textEditingValue.text);
        });
      },
      displayStringForOption: (NodeZone item)=> item.zoon_name,
      onSelected:this.onSelectItem,
    );
  }
}