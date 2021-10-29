// ListView(
// padding: EdgeInsets.only(
// top: 108,
// bottom: 4,
// ),
// children: snapshot.data!.docs.map((document) {
// return GestureDetector(
// onTap: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => ProductPage(
// productID: document.id,
// )));
// },
// child: Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(12),
// ),
// height: 350,
// margin: EdgeInsets.symmetric(
// vertical: 12,
// horizontal: 24,
// ),
// child: Stack(
// children: [
// Container(
// child: Image.network(
// "${document.data()['images'][1]}",
// fit: BoxFit.cover,
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
// '${document.data()['name']}',
// style: Constants.regularHeading,
// ),
// Text(
// 'Rs.${document.data()['price']}',
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
// ),
// );
// }).toList());