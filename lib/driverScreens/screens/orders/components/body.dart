import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import '../../../../constants.dart';

class OrderItemWidget extends StatefulWidget {
  final id;
  final productname;
  final productquantity;
  final sp;
  final productimage;
  final createdat;

  const OrderItemWidget(
      {Key key,
      this.id,
      this.productname,
      this.productquantity,
      this.sp,
      this.productimage,
      this.createdat})
      : super(key: key);
  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  @override
  Widget build(BuildContext context) {
    var dt = DateTime.parse(widget.createdat);
    // var newFormat = DateFormat("yy-MM-dd");
    var formattedDate = DateFormat.yMMMEd().format(dt);
    // var formattedDate = DateFormat.yMd(widget.createdat);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).focusColor.withOpacity(0.1),
              blurRadius: 5,
              offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: Image.network(
                apiLink + '/' + widget.productimage,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            // isThreeLine: true,
            title: Text(
              widget.productname,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context).textTheme.subhead,
            ),
            subtitle: Text(
              'Quantity: ${widget.productquantity}',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context).textTheme.caption,
            ),
            // trailing: Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}
