import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/styles/app_button.dart';
import 'package:mutliline_turing_machine/styles/app_images.dart';
import 'package:mutliline_turing_machine/ui/machine_inherit.dart';
import '../styles/app_colors.dart';

class AboutPanel extends StatefulWidget {
  const AboutPanel({Key? key}) : super(key: key);

  @override
  State<AboutPanel> createState() => _AboutPanel();
}

class _AboutPanel extends State<AboutPanel> {
  static const double iconSize = 28;
  late TuringMachine machine;

  @override
  Widget build(BuildContext context) {
    //machine = MachineInherit.of(context)!.machine;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 16,
          ),
          height: 38,
          color: AppColors.background,
          child: Row(
            children: [
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Выход",
                child: ElevatedButton(
                  onPressed: () {},
                  child: const SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                      image: AppImages.file,
                    ),
                  ),
                  style: appButtonStyle,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text("О приложении",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xFF183157),
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ))
            ],
          ),
        ),
        Divider(
          height: 2,
          thickness: 2,
          color: AppColors.highlight,
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              color: AppColors.background,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 32,
                      top: 32,
                      right: 0,
                    ),
                    height: 112,
                    color: AppColors.background,
                    child: Row(
                      children: [
                        Container(
                          width: 112,
                          height: 112,
                          child: const Image(
                              image: AppImages.file,
                            ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all( Radius.circular(18)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Container(
                            height: 112,
                            color: AppColors.background,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Многоленточная\nМашина Тьюринга",
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Color(0xFF183157),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24,
                                    )),
                                SizedBox(
                                  height: 6,
                                ),
                                Text("Версия 1.0",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Color(0xFFA6B2C3),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    )),
                                SizedBox(
                                  height: 6,
                                ),
                                Text("nullexp.ru/mtm",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Color(0xFF72A5B5),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ))
                              ],
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 32, bottom: 16),
                      height: 38,
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.background,
                      child: const Text("Анекдот",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color(0xFF183157),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ))),
                  Container(
                      padding: const EdgeInsets.only(left: 32,right: 32, bottom: 16),
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.background,
                      child: const Text(
                          "В дверь постучали под ритм гимна СССР. 'Клим Саныч' - сказал Дмитрий Юрьич.",
                          maxLines: 3,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Color(0xFF183157),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ))),
                  Container(
                      padding: const EdgeInsets.only(left: 32, bottom: 16),
                      height: 38,
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.background,
                      child: const Text("Разработчики",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color(0xFF183157),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ))),
                  Container(
                      margin: const EdgeInsets.only(left: 32, bottom: 16),
                      height: 78,
                      color: AppColors.background,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 78,
                            height: 78,
                            child: const Image( 
                              image: AppImages.file,
                              ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all( Radius.circular(38)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Хахук Рустам",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xFF183157),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  )),
                              SizedBox(
                                height: 4,
                              ),
                              Text("Главная соска",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xFFA6B2C3),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  )),
                            ],
                          )
                        ],
                      )),
                  Container(
                      margin: const EdgeInsets.only(left: 32, bottom: 16),
                      height: 78,
                      color: AppColors.background,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 78,
                            height: 78,
                            child: const Image( 
                              image: AppImages.file,
                              ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all( Radius.circular(38)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Гиренка",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xFF183157),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  )),
                              SizedBox(
                                height: 4,
                              ),
                              Text("Соска",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xFFA6B2C3),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  )),
                            ],
                          )
                        ],
                      )),
                  Container(
                      margin: const EdgeInsets.only(left: 32, bottom: 16),
                      height: 78,
                      color: AppColors.background,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 78,
                            height: 78,
                            child: const Image( 
                              image: AppImages.file,
                              ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all( Radius.circular(38)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("СерГЕЙ",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xFF183157),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  )),
                              SizedBox(
                                height: 4,
                              ),
                              Text("Не гей, сергей",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xFFA6B2C3),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  )),
                            ],
                          )
                        ],
                      )),
                  Container(
                      margin: const EdgeInsets.only(left: 32, bottom: 16),
                      color: AppColors.background,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 78,
                            height: 78,
                            child: const Image( 
                              image: AppImages.file,
                              ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all( Radius.circular(38)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Артём",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xFF183157),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  )),
                              SizedBox(
                                height: 4,
                              ),
                              Text("Ждём...",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xFFA6B2C3),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  )),
                              SizedBox(
                                height: 4,
                              ),
                              Text("Ждём...",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xFFA6B2C3),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  )),
                              SizedBox(
                                height: 4,
                              ),
                              Text("Ждём...",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xFFA6B2C3),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  )),
                              SizedBox(
                                height: 4,
                              ),
                              Text("Ждём...",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xFFA6B2C3),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  )),
                              SizedBox(
                                height: 4,
                              ),
                              Text("Ждём...",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xFFA6B2C3),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  )),
                              SizedBox(
                                height: 4,
                              ),
                              Text("Ждём...",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xFFA6B2C3),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  )),
                              SizedBox(
                                height: 4,
                              ),
                              Text("Ждём...",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xFFA6B2C3),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  )),
                            ],
                          )
                        ],
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 32 ,left: 32, bottom: 16),
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.background,
                      child: const Text("Использованные ресурсы",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color(0xFF183157),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ))),
                  Column(
                    children: [
                      Container(
                      margin: const EdgeInsets.only(left: 32),
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.background,
                      child: const Text("пельмени Мироторг",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color(0xFF183157),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ))),
                      Container(
                      margin: const EdgeInsets.only(left: 32),
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.background,
                      child: const Text("мамина еда",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color(0xFF183157),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ))),
                    ],
                  ),
                  Container(
                    color: AppColors.background,
                    height: MediaQuery.of(context).size.height - 578 > 0
                        ? MediaQuery.of(context).size.height - 578
                        : 0,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
