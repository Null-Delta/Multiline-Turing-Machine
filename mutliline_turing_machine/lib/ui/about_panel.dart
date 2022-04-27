import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/styles/app_button.dart';
import 'package:mutliline_turing_machine/styles/app_images.dart';
import 'package:url_launcher/url_launcher.dart';
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
                                  color: AppColors.background,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Эмулятор Машины\nТьюринга",
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
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
                                      const Text(
                                        "Версия 1.0",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Color(0xFFA6B2C3),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      SizedBox(
                                          width: 95,
                                          height: 20,
                                          child: 
                                          ElevatedButton(
                                            //'https://https://nullexp.ru/mtm'
                                            onPressed: () { launchUrlString('https://https://nullexp.ru'); },
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
                                            style: appButtonStyle,
                                          ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
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
                            padding:
                                const EdgeInsets.only(left: 32, bottom: 32),
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
                                        offset: Offset
                                            .zero, // changes position of shadow
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Хахук Рустам",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color(0xFF183157),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
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
                                      height: 4,
                                    ),
                                    SizedBox(
                                      height: 20,
                                      width: 200,
                                      child: ElevatedButton(
                                        onPressed: () { launchUrlString('https://github.com/Zed-Null'); },
                                        child: Text(
                                          "Github - Zed-Null",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: AppColors.accent,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        style: appButtonStyle,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    const Text(
                                      "Дизайн всего приложения, проектирование, справка, \n"
                                              "панель правил, состояний и комментариев, иконки,\n" "нижняя панель инстументов, настройки.",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color(0xFFA6B2C3),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
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
                                        offset: Offset
                                            .zero, // changes position of shadow
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Прозоров Сергей",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color(0xFF183157),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "max.prozoroff@yandex.ru",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: AppColors.accent,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    SizedBox(
                                      height: 20,
                                      width: 200,
                                      child: ElevatedButton(
                                        onPressed: () { launchUrlString('https://github.com/StarProxima'); },
                                        child: Text(
                                          "Github - StarProxima",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: AppColors.accent,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        style: appButtonStyle,
                                      ),
                                    ),
                                    const Text(
                                      "Импорт/экспорт сохранений, ячейка ленты, \n" "ввод в ленту, добавление/удаление лент, \n" "вверхняя панель инстументов, тестирование.",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color(0xFFA6B2C3),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
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
                                        offset: Offset
                                            .zero, // changes position of shadow
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Гиренко Даниил",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color(0xFF183157),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "iamgirya@yandex.ru",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: AppColors.accent,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                      width: 200,
                                      child: ElevatedButton(
                                        onPressed: () { launchUrlString('https://github.com/iamgirya'); },
                                        child: Text(
                                          "Github - iamgirya",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: AppColors.accent,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        style: appButtonStyle,
                                      ),
                                    ),
                                    const Text(
                                      "Модель машины Тьюринга, лента, очистка ленты,\n" "раздел \"О приложении\", подсчёт конфигураций,\n" "автоматическая работа машины Тьюринга.",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color(0xFFA6B2C3),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 32, left: 32, bottom: 16),
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
                                margin: const EdgeInsets.only(left: 32),
                                width: MediaQuery.of(context).size.width,
                                color: AppColors.background,
                                child: const Text(
                                  "пельмени Мироторг",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xFF183157),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 32),
                                width: MediaQuery.of(context).size.width,
                                color: AppColors.background,
                                child: const Text(
                                  "мамина еда",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xFF183157),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
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
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
