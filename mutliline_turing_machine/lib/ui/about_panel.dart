import 'dart:developer';
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

class DeveloperCard extends StatelessWidget {
  const DeveloperCard(
      {required this.name,
      required this.email,
      required this.gitUrl,
      required this.description,
      required this.avatar,
      Key? key})
      : super(key: key);

  final String name;
  final String email;
  final String gitUrl;
  final String description;
  final Image avatar;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 32, bottom: 16),
      color: Theme.of(context).backgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            width: 78,
            height: 78,
            child: avatar,
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
                    message: gitUrl,
                    verticalOffset: 14,
                    child: ElevatedButton(
                      onPressed: () {
                        launchUrlString(gitUrl);
                      },
                      child: Text(
                        name,
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
                    email,
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
                    constraints:
                        const BoxConstraints(maxWidth: double.infinity),
                    child: Text(
                      description,
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
    );
  }
}

class ResourceCard extends StatelessWidget {
  const ResourceCard({required this.text, Key? key}) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 32, right: 32, bottom: 8),
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).backgroundColor,
      child: Text(
        text,
        textAlign: TextAlign.justify,
        style: TextStyle(
          color: Theme.of(context).cardColor.withOpacity(0.5),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
    );
  }
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
            Divider(
                height: 0,
                thickness: 2,
                color: Theme.of(context).highlightColor),
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
                                          offset: Offset
                                              .zero, // changes position of shadow
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Tooltip(
                                          waitDuration:
                                              const Duration(milliseconds: 200),
                                          verticalOffset: 32,
                                          message:
                                              'https://github.com/Null-Delta/Multiline-Turing-Machine',
                                          child: ElevatedButton(
                                            onPressed: () {
                                              launchUrlString(
                                                  'https://github.com/Null-Delta/Multiline-Turing-Machine');
                                            },
                                            child: Text(
                                              "Эмулятор Многоленточной \nМашины Тьюринга",
                                              maxLines: 2,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color:
                                                    Theme.of(context).cardColor,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 24,
                                              ),
                                            ),
                                            style: linkButtonStyle,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          "Версия 1.1",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .cardColor
                                                .withOpacity(0.5),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        SizedBox(
                                          height: 20,
                                          child: Tooltip(
                                            waitDuration: const Duration(
                                                milliseconds: 200),
                                            verticalOffset: 14,
                                            message: "Сайт разработчиков",
                                            child: ElevatedButton(
                                              onPressed: () {
                                                launchUrlString(
                                                    'https://nullexp.ru');
                                              },
                                              child: Text(
                                                "nullexp.ru",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
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
                              padding:
                                  const EdgeInsets.only(left: 32, bottom: 24),
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
                            const DeveloperCard(
                                name: 'Хахук Рустам',
                                email: 'delta.null@vk.com',
                                gitUrl: 'https://github.com/Null-Delta',
                                description:
                                    'Дизайн всего приложения, проектирование, справка, панель правил, состояний и комментариев, иконки, нижняя панель инстументов, настройки.',
                                avatar: Image(image: AppImages.ZedNull)),
                            const DeveloperCard(
                                name: 'Прозоров Максим',
                                email: 'StarProxima@yandex.ru',
                                gitUrl: 'https://github.com/StarProxima',
                                description:
                                    'Импорт/экспорт сохранений, ячейка ленты, ввод в ленту, добавление/удаление лент, вверхняя панель инстументов, тестирование.',
                                avatar: Image(image: AppImages.StarProxima)),
                            const DeveloperCard(
                                name: 'Гиренко Даниил',
                                email: 'iamgirya@yandex.ru',
                                gitUrl: 'https://github.com/iamgirya',
                                description:
                                    'Модель машины Тьюринга, лента, очистка ленты, раздел "О приложении", подсчёт конфигураций, автоматическая работа машины Тьюринга.',
                                avatar: Image(image: AppImages.IAmGirya)),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 32, left: 32, bottom: 16),
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
                              children: const [
                                ResourceCard(
                                    text:
                                        '• Multi split view: Copyright (c) 2021 Carlos Eduardo Leite de Andrade'),
                                ResourceCard(
                                    text:
                                        '• Window Size: Copyright [2018] [stuartmorgan]'),
                                ResourceCard(
                                    text:
                                        '• Material snackbar: Copyright (c) 2020 Rounded Infinity'),
                                ResourceCard(
                                    text:
                                        '• File Picker: Copyright (c) 2018 Miguel Ruivo'),
                                ResourceCard(
                                    text:
                                        '• Pluto Grid: Copyright (c) [2020] [PlutoGrid]'),
                                ResourceCard(
                                    text:
                                        '• Scollable Positioned List: Copyright 2018 the Dart project authors, Inc.'),
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
              color: Theme.of(context).backgroundColor,
              child: Text(
                "Developed by the NullExp team specifically for Kuban State University",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).cardColor,
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
