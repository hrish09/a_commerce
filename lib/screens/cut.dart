//
//
//
// Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(12),
// ),
// height: 250,
// margin: EdgeInsets.symmetric(
// vertical: 12,
// horizontal: 24,
// ),
// child: Stack(
// children: [
// Center(
// child: Container(
// child: Image.network(
// "${productMap['images'][0]}",
// fit: BoxFit.cover,
// ),
// ),
// ),
// Positioned(
// bottom: 0,
// left: 0,
// right: 0,
// child: Padding(
// padding: const EdgeInsets.symmetric(
// vertical: 8,
// horizontal: 10,
// ),
// child: Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// children: [
// Text(
// '${productMap['name']}',
// style: TextStyle(
// fontSize: 17,
// fontWeight: FontWeight.w600
// ),
// ),
// Text(
// 'Rs.${productMap['price']}',
// style: TextStyle(
// fontSize: 17,
// fontWeight: FontWeight.w600,
// color: Theme.of(context).accentColor,
// ),
// ),
// ],
// ),
// ),
// )
// ],
// ),
// );