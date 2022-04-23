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
    machine = MachineInherit.of(context)!.machine;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 32,
            right: 6,
          ),
          height: 76,
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
                width: 20,
              ),
              const Text("О приложении",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF183157),
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                )
              )
            ],
          ),
        ),
        Divider(
          height: 2,
          thickness: 2,
          color: AppColors.highlight,
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 64,
            right: 0,
          ),
          height: 320,
          color: AppColors.background,
          child: Row(
            children: [
              const SizedBox(
                width: 224,
                height: 224,
                child: Image(
                  image: AppImages.file,
                ),
              ),
              const SizedBox(
                width: 32,
              ),
              Container(
              padding: const EdgeInsets.only(
                left: 0,
                right: 0,
              ),
              height: 224,
              color: AppColors.background,
              child: Column(
                  children: const [
                    Text("Многоленточная машина Тьюринга",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF183157),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 48,
                      )
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text("Версия 1.0",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFA6B2C3),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 32,
                      )
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text("nullexp.ru/mtm",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF72A5B5),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 36,
                      )
                    )
                  ],
                )
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 64,
            right: 6,
            bottom: 32
          ),
          height: 76,
          color: AppColors.background,
          child: 
            const Text("Анекдот",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF72A5B5),
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 36,
            )
          )
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 64,
            right: 6,
            bottom: 32
          ),
          height: 76,
          color: AppColors.background,
          child: 
            const Text("В дверь постучали под ритм гимна СССР. 'Клим Саныч' - сказал Дмитрий Юрьич.",
            maxLines: 3,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF72A5B5),
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 24,
            )
          )
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 64,
            right: 6,
            bottom: 32
          ),
          height: 76,
          color: AppColors.background,
          child: 
            const Text("Разработчики",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF72A5B5),
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 36,
              )
            )
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 64,
            right: 6,
            bottom: 32
          ),
          height: 76,
          color: AppColors.background,
          child: 
            Row(
              children: [
                const SizedBox(
                  width: 156,
                  height: 156,
                  child: Image(
                    image: AppImages.file,
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                Column(
                  children: const [
                    Text("Хахук Рустам",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF72A5B5),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 36,
                      )
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text("Главная соска",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFA6B2C3),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      )
                    ),
                  ],
                )
              ],
            )
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 64,
            right: 6,
            bottom: 32
          ),
          height: 76,
          color: AppColors.background,
          child: 
            Row(
              children: [
                const SizedBox(
                  width: 156,
                  height: 156,
                  child: Image(
                    image: AppImages.file,
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                Column(
                  children: const [
                    Text("Гиренка",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF72A5B5),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 36,
                      )
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text("Соска",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFA6B2C3),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      )
                    ),
                  ],
                )
              ],
            )
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 64,
            right: 6,
            bottom: 32
          ),
          height: 76,
          color: AppColors.background,
          child: 
            Row(
              children: [
                const SizedBox(
                  width: 156,
                  height: 156,
                  child: Image(
                    image: AppImages.file,
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                Column(
                  children: const [
                    Text("СерГЕЙ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF72A5B5),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 36,
                      )
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text("Не гей, сергей",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFA6B2C3),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      )
                    ),
                  ],
                )
              ],
            )
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 64,
            right: 6,
            bottom: 32
          ),
          height: 76,
          color: AppColors.background,
          child: 
            Row(
              children: [
                const SizedBox(
                  width: 156,
                  height: 156,
                  child: Image(
                    image: AppImages.file,
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                Column(
                  children: const [
                    Text("Артём",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF72A5B5),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 36,
                      )
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text("Ждём...",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFA6B2C3),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      )
                    ),
                  ],
                )
              ],
            )
        ),

      ],
    );
  }
}
