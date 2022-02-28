import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/data/models/driver_order_changing.dart';
import '/data/models/node_order_notes_respones.dart';
import '/data/node_api_provider.dart';
import '/ui/widgets/Loading.dart';
import '/ui/widgets/delivery_button.dart';
import '/ui/widgets/delivery_text_field.dart';
import '/utils/Dialog.dart';
import '/utils/Messages.dart';

class NotesDialog extends StatefulWidget {
  int orderId ;
  int type ;


  NotesDialog(this.orderId , this.type);

  @override
  _NotesDialogState createState() {
    return _NotesDialogState();
  }
}

class _NotesDialogState extends State<NotesDialog> {
  List<NodeOrderNote> notes = [];
  bool loading = false ;
  bool _loading = false ;
  TextEditingController _textController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    _getNotes();
  }
  _getNotes(){
    setState(() => loading = true );
    NodeApiProvider.getNotes(widget.orderId , onError: (error)=>print("get notes error : $error") , onSuccess: (notes){
      setState(() {
        this.notes = notes;
        this.loading = false ;
      });
    });
  }

  _inputDialog(int orderId, int type) {
    double width = MediaQuery.of(context).size.width;
    ShowDialog(
        context: context,
        height: type == ORDER_SEND_NOTE ? 260 : 180,
        radius: BorderRadius.circular(16),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              DeliveryTextField(
                label: type == ORDER_SEND_NOTE ? "note".tr() : "price".tr(),
                hint: type == ORDER_SEND_NOTE ? "note".tr() : "price".tr(),
                liens: type == ORDER_SEND_NOTE ? 4 : 1,
                width: width / 1.1,
                labelColor: Colors.black,
                backGroundColor: Color(0x33000000),
                textType: TextInputType.text,
                controller: _textController,
              ),
              SizedBox(
                height: 16,
              ),
              DeliveryButton(
                width: width / 1.5,
                height: 40,
                textColor: Colors.white,
                text: "add".tr(),
                onPressed: () {
                  Navigator.pop(context);
                  _changeOrderStatus(orderId, type,
                      note:
                      type == ORDER_SEND_NOTE ? _textController.text : null,
                      price: type == ORDER_SEND_NOTE
                          ? null
                          : _textController.text);
                  _textController.text = "";
                },
                loading: _loading,
              ),
            ],
          ),
        ),
        alignment: Alignment.center);
  }
  _changeOrderStatus(int orderId, int type, {String note, String price}) {
    _loadingDialog();
    NodeApiProvider.changeOrderStatus(
        DriverOrderChangingSend(
            type: type,
            orderId: orderId,
            price: price,
            clientType: widget.type,
            note: note), onSuccess: (message) {
      Navigator.pop(context);
      this._getNotes();
    }, onError: (error) {
      Navigator.pop(context);
    });
  }
  _loadingDialog() {
    double width = MediaQuery.of(context).size.width;
    ShowDialog(
        context: context,
        height: 100,
        // width: width - 80,
        dismiss: false,
        radius: BorderRadius.circular(16),
        child: Container(
            color: Colors.white,
            child: Center(
              child: Text(
                "من فضلك انتظر جاري التحميل ...",
                style: TextStyle(fontSize: 14),
              ),
            )));
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height:  height-80,
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("ملاحظات الطلب" ,style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                ),),
                SizedBox(width: 20,),
                InkWell(
                  onTap: ()=>_inputDialog(widget.orderId, ORDER_SEND_NOTE),
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Icon(FontAwesomeIcons.plus , size: 10, color: Colors.white,),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 16,),
            loading ? Container(
                height: height - 180,
                child: Loading()) :(notes?.length??0)==0 ? Container(
              height: height-80-16-30,
              child: Center(
                child:Text("no_data".tr()),
              ),
            ):ListView.separated(
              itemCount: this.notes?.length??0,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context , index){
                NodeOrderNote note = this.notes[index];
                return Container(
                  width: width-32-32,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${note?.notes??""}" ,style: TextStyle(fontSize: 14 , fontWeight: FontWeight.w500),),
                      SizedBox(height: 8,),
                      Text("${note?.dateenter.split("T")[0]}" ,style: TextStyle(fontSize: 12 , color: Colors.grey),),
                    ],
                  ),
                );
              },
              separatorBuilder: (context,index){
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  height: 1,
                  width: width,
                  color: Colors.grey,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}