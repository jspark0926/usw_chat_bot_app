import 'package:flutter/material.dart';
import 'package:usw_chat_bot_app/w_default_Layout.dart';
import 'package:velocity_x/velocity_x.dart';

class receiveInquirePage extends StatefulWidget {
  const receiveInquirePage({super.key});

  @override
  State<receiveInquirePage> createState() => _receiveInquirePageState();
}

class _receiveInquirePageState extends State<receiveInquirePage> {
  late var inquireType = '';
  late var inquireTitle = '';
  late var inquireContent = '';

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      loginState: true,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const HeightBox(50),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  '문의 유형'.text.black.size(18).make().pOnly(left: 20),
                ],
              ),
              const HeightBox(5),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                ),
                onChanged: (text) {
                  setState(() {
                    inquireType = text;
                  });
                },
              ).pSymmetric(h: 20),
              const HeightBox(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  '제목'.text.black.size(18).make().pOnly(left: 20),
                ],
              ),
              const HeightBox(5),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  // hintText: '제목',  //글자를 입력하면 사라진다.
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                ),
                onChanged: (text) {
                  setState(() {
                    inquireTitle = text;
                  });
                },
              ).pSymmetric(h: 20),
              const HeightBox(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  '내용'.text.black.size(18).make().pOnly(left: 20),
                ],
              ),
              const HeightBox(5),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                ),
                onChanged: (text) {
                  setState(() {
                    inquireContent = text;
                  });
                },
              ).pSymmetric(h: 20),
              HeightBox(40),
              OutlinedButton(
                onPressed: () {
                  if (inquireType.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: '문의 유형이 선택되지 않았습니다'.text.bold.white.size(20).make(),
                      ),
                    );
                  } else {
                    if(inquireTitle.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: '제목을 입력해주세요'.text.bold.white.size(20).make(),
                        ),
                      );
                    } else {
                      if (inquireContent.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: '문의 내용을 입력해주세요'.text.bold.white.size(20).make(),
                          ),
                        );
                      } else {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: '문의가 접수되었습니다'.text.bold.white.size(20).make(),
                          ),
                        );
                      }
                    }
                  }
                },
                child: '접수하기'.text.black.size(20).make(),
              ),
              HeightBox(20),
            ],
          ),
        ),
      ),
    );
  }
}
