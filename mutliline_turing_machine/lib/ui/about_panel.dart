import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/styles/app_button.dart';
import 'package:mutliline_turing_machine/styles/app_images.dart';
import 'package:url_launcher/url_launcher_string.dart';
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
    return DefaultTextStyle(
      style: const TextStyle(),
      child: Container(
        color: AppColors.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 6,
              ),
              height: 40,
              color: AppColors.background,
              child: Row(
                children: [
                  Tooltip(
                    waitDuration: const Duration(milliseconds: 500),
                    message: "Выход",
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const SizedBox(
                        width: iconSize,
                        height: iconSize,
                        child: Image(
                          image: AppImages.back,
                        ),
                      ),
                      style: appButtonStyle,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "О приложении",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xFF183157),
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
            const Divider(height: 0, thickness: 2, color: Color(0xFFE7E8F3)),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  color: AppColors.background,
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 640),
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
                                    clipBehavior: Clip.antiAlias,
                                    width: 112,
                                    height: 112,
                                    child: const Image(
                                      width: 112,
                                      height: 112,
                                      image: AppImages.appIcon,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      //border:
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(18),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.shadowColor,
                                          spreadRadius: 4,
                                          blurRadius: 12,
                                          offset: Offset.zero, // changes position of shadow
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
                                      children: [
                                        const Text(
                                          "Эмулятор Многоленточной \nМашины Тьюринга",
                                          maxLines: 2,
                                          //overflow: TextOverflow.clip,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Color(0xFF183157),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        const Tooltip(
                                          waitDuration: Duration(milliseconds: 200),
                                          message: "28.04.2022",
                                          verticalOffset: 14,
                                          child: Text(
                                            "Версия 1.0",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Color(0xFFA6B2C3),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        SizedBox(
                                          height: 20,
                                          child: Tooltip(
                                            waitDuration: const Duration(milliseconds: 200),
                                            verticalOffset: 14,
                                            message: "Сайт разработчиков",
                                            child: ElevatedButton(
                                              onPressed: () {
                                                launchUrlString('https://nullexp.ru');
                                              },
                                              child: const Text(
                                                "nullexp.ru",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Color(0xFF72A5B5),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              style: linkButtonStyle,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 42,
                            ),
                            
                            // Container(
                            //   padding: const EdgeInsets.only(left: 32, bottom: 16),
                            //   width: MediaQuery.of(context).size.width,
                            //   color: AppColors.background,
                            //   child: const Text(
                            //     "Приложение",
                            //     textAlign: TextAlign.left,
                            //     style: TextStyle(
                            //       color: Color(0xFF183157),
                            //       fontFamily: 'Inter',
                            //       fontWeight: FontWeight.w700,
                            //       fontSize: 24,
                            //     ),
                            //   ),
                            // ),
                            // Container(
                            //   padding: const EdgeInsets.only(left: 32, right: 32),
                            //   width: MediaQuery.of(context).size.width,
                            //   color: AppColors.background,
                            //   child: Row(
                            //     children: [const Text(
                            //       "У приложения открытый исходный код: ",
                            //       maxLines: 3,
                            //       textAlign: TextAlign.justify,
                            //       style: TextStyle(
                            //         color: Color(0xFF183157),
                            //         fontFamily: 'Inter',
                            //         fontWeight: FontWeight.w500,
                            //         fontSize: 16,
                            //       ),
                            //     ),
                            //     Tooltip(
                            //       waitDuration: const Duration(milliseconds: 300),
                            //       message: "https://github.com/Zed-Null/Multiline-Turing-Machine",
                            //       verticalOffset: 14,
                            //       child: ElevatedButton(
                            //         onPressed: () {
                            //           launchUrlString('https://github.com/Zed-Null/Multiline-Turing-Machine');
                            //         },
                            //         child: const Text(
                            //           "репозиторий.",
                                      
                            //           style: TextStyle(
                            //             color: Color(0xFF72A5B5),
                            //             fontFamily: 'Inter',
                            //             fontWeight: FontWeight.w700,
                            //             fontSize: 16,
                            //           ),
                            //         ),
                            //         style: linkButtonStyle,
                            //       ),
                            //     ),
                            //     ],
                            //   ),
                            // ),
                            
                            // const SizedBox(
                            //   height: 16,
                            // ),
                            
                            /*
                            Container(
                              padding: const EdgeInsets.only(left: 32, bottom: 16),
                              width: MediaQuery.of(context).size.width,
                              color: AppColors.background,
                              child: const Text(
                                "Анекдот",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color(0xFF183157),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 32, right: 32, bottom: 16),
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
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            */
                            Container(
                              padding: const EdgeInsets.only(left: 32, bottom: 24),
                              width: MediaQuery.of(context).size.width,
                              color: AppColors.background,
                              child: const Text(
                                "Разработчики",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color(0xFF183157),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 32, bottom: 16),
                              color: AppColors.background,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    clipBehavior: Clip.antiAlias,
                                    width: 78,
                                    height: 78,
                                    child: const Image(
                                      image: AppImages.ZedNull,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(38),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.shadowColor,
                                          spreadRadius: 8,
                                          blurRadius: 8,
                                          offset: Offset.zero, // changes position of shadow
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(right: 32),
                                      constraints: const BoxConstraints(minWidth: double.infinity),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Tooltip(
                                            waitDuration: const Duration(milliseconds: 300),
                                            message: "https://github.com/Zed-Null",
                                            verticalOffset: 14,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                launchUrlString('https://github.com/Zed-Null');
                                              },
                                              child: const Text(
                                                "Хахук Рустам",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Color(0xFF183157),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              style: linkButtonStyle,
                                            ),
                                          ),
                                          SelectableText(
                                            "zed.null@icloud.com",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: AppColors.accent,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            constraints: const BoxConstraints(maxWidth: double.infinity),
                                            child: const Text(
                                              "Дизайн всего приложения, проектирование, справка, панель правил, состояний и комментариев, иконки, нижняя панель инстументов, настройки.",
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                color: Color(0xFFA6B2C3),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 32, bottom: 16),
                              color: AppColors.background,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    clipBehavior: Clip.antiAlias,
                                    width: 78,
                                    height: 78,
                                    child: const Image(
                                      image: AppImages.StarProxima,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(38),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.shadowColor,
                                          spreadRadius: 8,
                                          blurRadius: 8,
                                          offset: Offset.zero, // changes position of shadow
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(right: 32),
                                      constraints: const BoxConstraints(minWidth: double.infinity),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Tooltip(
                                            waitDuration: const Duration(milliseconds: 300),
                                            message: "https://github.com/StarProxima",
                                            verticalOffset: 14,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                launchUrlString('https://github.com/StarProxima');
                                              },
                                              child: const Text(
                                                "Прозоров Максим",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Color(0xFF183157),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              style: linkButtonStyle,
                                            ),
                                          ),
                                          SelectableText(
                                            "StarProxima@yandex.ru",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: AppColors.accent,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            constraints: const BoxConstraints(maxWidth: double.infinity),
                                            child: const Text(
                                              "Импорт/экспорт сохранений, ячейка ленты, ввод в ленту, добавление/удаление лент, вверхняя панель инстументов, тестирование.",
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                color: Color(0xFFA6B2C3),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 32, bottom: 16),
                              color: AppColors.background,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    clipBehavior: Clip.antiAlias,
                                    width: 78,
                                    height: 78,
                                    child: const Image(
                                      image: AppImages.IAmGirya,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(38),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.shadowColor,
                                          spreadRadius: 8,
                                          blurRadius: 8,
                                          offset: Offset.zero, // changes position of shadow
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(right: 32),
                                      constraints: const BoxConstraints(minWidth: double.infinity),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Tooltip(
                                            waitDuration: const Duration(milliseconds: 300),
                                            message: "https://github.com/iamgirya",
                                            verticalOffset: 14,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                launchUrlString('https://github.com/iamgirya');
                                              },
                                              child: const Text(
                                                "Гиренко Даниил",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Color(0xFF183157),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              style: linkButtonStyle,
                                            ),
                                          ),
                                          SelectableText(
                                            "iamgirya@yandex.ru",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: AppColors.accent,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            constraints: const BoxConstraints(maxWidth: double.infinity),
                                            child: const Text(
                                              "Модель машины Тьюринга, лента, очистка ленты, раздел \"О приложении\", подсчёт конфигураций, автоматическая работа машины Тьюринга.",
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                color: Color(0xFFA6B2C3),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 32, left: 32, bottom: 16),
                              width: MediaQuery.of(context).size.width,
                              color: AppColors.background,
                              child: const Text(
                                "Использованные ресурсы",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color(0xFF183157),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 32, right: 32, bottom: 8),
                                  width: MediaQuery.of(context).size.width,
                                  color: AppColors.background,
                                  child: const Text(
                                    "• Multi split view: Copyright (c) 2021 Carlos Eduardo Leite de Andrade",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Color(0xFF183157),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 32, right: 32, bottom: 8),
                                  width: MediaQuery.of(context).size.width,
                                  color: AppColors.background,
                                  child: const Text(
                                    "• Window Size: Copyright [2018] [stuartmorgan]",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Color(0xFF183157),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 32, right: 32, bottom: 8),
                                  width: MediaQuery.of(context).size.width,
                                  color: AppColors.background,
                                  child: const Text(
                                    "• Material snackbar: Copyright (c) 2020 Rounded Infinity",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Color(0xFF183157),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 32, right: 32, bottom: 8),
                                  width: MediaQuery.of(context).size.width,
                                  color: AppColors.background,
                                  child: const Text(
                                    "• File Picker: Copyright (c) 2018 Miguel Ruivo",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Color(0xFF183157),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 32, right: 32, bottom: 8),
                                  width: MediaQuery.of(context).size.width,
                                  color: AppColors.background,
                                  child: const Text(
                                    "• Pluto Grid: Copyright (c) [2020] [PlutoGrid]",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Color(0xFF183157),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
                                  width: MediaQuery.of(context).size.width,
                                  color: AppColors.background,
                                  child: const Text(
                                    "• Scollable Positioned List: Copyright 2018 the Dart project authors, Inc.",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Color(0xFF183157),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4, bottom: 4),
              alignment: FractionalOffset.bottomCenter,
              width: MediaQuery.of(context).size.width,
              color: AppColors.background,
              child: const Text(
                "Developed by the NullExp team specifically for Kuban State University",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFA6B2C3),
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}