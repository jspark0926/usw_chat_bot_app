import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:usw_chat_bot_app/w_layout/w_default_Layout.dart';
import 'package:velocity_x/velocity_x.dart';

class InquireDetails extends StatelessWidget {
  final Map<String, dynamic> document;

  const InquireDetails({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      loginState: true,
      title: '',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeightBox(50),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                '작성 시간'.text.black.size(18).make().pOnly(left: 20),
              ],
            ),
            const HeightBox(5),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 3,
                ),
                color: Colors.white,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: '${document['timestamp'].toDate().toString()}'
                    .text
                    .black
                    .size(20)
                    .make()
                    .pSymmetric(h: 10, v: 10),
              ),
            ).pSymmetric(h: 20),
            const HeightBox(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                '문의 유형'.text.black.size(18).make().pOnly(left: 20),
              ],
            ),
            const HeightBox(5),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 3,
                ),
                color: Colors.white,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: '${document['type']}'
                    .text
                    .black
                    .size(20)
                    .make()
                    .pSymmetric(h: 10, v: 10),
              ),
            ).pSymmetric(h: 20),
            const HeightBox(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                '문의 제목'.text.black.size(18).make().pOnly(left: 20),
              ],
            ),
            const HeightBox(5),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 3,
                ),
                color: Colors.white,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: '${document['title']}'
                    .text
                    .black
                    .size(20)
                    .make()
                    .pSymmetric(h: 10, v: 10),
              ),
            ).pSymmetric(h: 20),
            const HeightBox(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                '문의 내용'.text.black.size(18).make().pOnly(left: 20),
              ],
            ),
            const HeightBox(5),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 3,
                ),
                color: Colors.white,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: '${document['contents']}'
                    .text
                    .black
                    .size(20)
                    .make()
                    .pSymmetric(h: 10, v: 10),
              ),
            ).pSymmetric(h: 20),
            HeightBox(50),
            Align(
              alignment: Alignment.center,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: '확인'.text.black.size(20).make(),
              ),
            ),
            HeightBox(50),
          ],
        ),
      ),
    );
  }
}
