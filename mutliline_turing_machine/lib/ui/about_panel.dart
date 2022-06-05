import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/styles/app_button.dart';
import 'package:mutliline_turing_machine/styles/app_images.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
        color: Theme.of(context).backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 6,
              ),
              height: 40,
              color: Theme.of(context).backgroundColor,
              child: Row(
                children: [
                  Tooltip(
                    waitDuration: const Duration(milliseconds: 500),
                    message: "Выход",
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: SizedBox(
                        width: iconSize,
                        height: iconSize,
                        child: Image(
                          image: AppImages.back,
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                      style: appButtonStyle(context),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "О приложении",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Theme.of(context).cardColor,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
            Divider(height: 0, thickness: 2, color: Theme.of(context).highlightColor),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  color: Theme.of(context).backgroundColor,
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 640),
                      child: Container(
                        color: Theme.of(context).backgroundColor,
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
                              color: Theme.of(context).backgroundColor,
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
                                          color: Theme.of(context).shadowColor,
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
                                    color: Theme.of(context).backgroundColor,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Эмулятор Многоленточной \nМашины Тьюринга",
                                          maxLines: 2,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Theme.of(context).cardColor,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Tooltip(
                                          waitDuration: const Duration(milliseconds: 200),
                                          message: "28.04.2022",
                                          verticalOffset: 14,
                                          child: Text(
                                            "Версия 1.1",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Theme.of(context).cardColor.withOpacity(0.5),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
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
                                              child: Text(
                                                "nullexp.ru",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Theme.of(context).primaryColor,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w500,
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
                            Container(
                              padding: const EdgeInsets.only(left: 32, bottom: 24),
                              width: MediaQuery.of(context).size.width,
                              color: Theme.of(context).backgroundColor,
                              child: Text(
                                "Разработчики",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Theme.of(context).cardColor,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 32, bottom: 16),
                              color: Theme.of(context).backgroundColor,
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
                                          color: Theme.of(context).shadowColor,
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
                                            message: "https://github.com/Null-Delta",
                                            verticalOffset: 14,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                launchUrlString('https://github.com/Null-Delta');
                                              },
                                              child: Text(
                                                "Хахук Рустам",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Theme.of(context).cardColor,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              style: linkButtonStyle,
                                            ),
                                          ),
                                          SelectableText(
                                            "delta.null@vk.com",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Theme.of(context).primaryColor,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            constraints: const BoxConstraints(maxWidth: double.infinity),
                                            child: Text(
                                              "Дизайн всего приложения, проектирование, справка, панель правил, состояний и комментариев, иконки, нижняя панель инстументов, настройки.",
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                color: Theme.of(context).cardColor.withOpacity(0.5),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
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
                              color: Theme.of(context).backgroundColor,
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
                                          color: Theme.of(context).shadowColor,
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
                                              child: Text(
                                                "Прозоров Максим",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Theme.of(context).cardColor,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w500,
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
                                              color: Theme.of(context).primaryColor,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            constraints: const BoxConstraints(maxWidth: double.infinity),
                                            child: Text(
                                              "Импорт/экспорт сохранений, ячейка ленты, ввод в ленту, добавление/удаление лент, вверхняя панель инстументов, тестирование.",
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                color: Theme.of(context).cardColor.withOpacity(0.5),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
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
                              color: Theme.of(context).backgroundColor,
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
                                          color: Theme.of(context).shadowColor,
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
                                              child: Text(
                                                "Гиренко Даниил",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Theme.of(context).cardColor,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w500,
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
                                              color: Theme.of(context).primaryColor,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            constraints: const BoxConstraints(maxWidth: double.infinity),
                                            child: Text(
                                              "Модель машины Тьюринга, лента, очистка ленты, раздел \"О приложении\", подсчёт конфигураций, автоматическая работа машины Тьюринга.",
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                color: Theme.of(context).cardColor.withOpacity(0.5),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
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
                              color: Theme.of(context).backgroundColor,
                              child: Text(
                                "Использованные ресурсы",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Theme.of(context).cardColor,
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
                                  color: Theme.of(context).backgroundColor,
                                  child: Text(
                                    "• Multi split view: Copyright (c) 2021 Carlos Eduardo Leite de Andrade",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Theme.of(context).cardColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 32, right: 32, bottom: 8),
                                  width: MediaQuery.of(context).size.width,
                                  color: Theme.of(context).backgroundColor,
                                  child: Text(
                                    "• Window Size: Copyright [2018] [stuartmorgan]",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Theme.of(context).cardColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 32, right: 32, bottom: 8),
                                  width: MediaQuery.of(context).size.width,
                                  color: Theme.of(context).backgroundColor,
                                  child: Text(
                                    "• Material snackbar: Copyright (c) 2020 Rounded Infinity",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Theme.of(context).cardColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 32, right: 32, bottom: 8),
                                  width: MediaQuery.of(context).size.width,
                                  color: Theme.of(context).backgroundColor,
                                  child: Text(
                                    "• File Picker: Copyright (c) 2018 Miguel Ruivo",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Theme.of(context).cardColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 32, right: 32, bottom: 8),
                                  width: MediaQuery.of(context).size.width,
                                  color: Theme.of(context).backgroundColor,
                                  child: Text(
                                    "• Pluto Grid: Copyright (c) [2020] [PlutoGrid]",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Theme.of(context).cardColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
                                  width: MediaQuery.of(context).size.width,
                                  color: Theme.of(context).backgroundColor,
                                  child: Text(
                                    "• Scollable Positioned List: Copyright 2018 the Dart project authors, Inc.",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Theme.of(context).cardColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
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
          ],
        ),
      ),
    );
  }
}
