import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mutliline_turing_machine/styles/app_button.dart';
import 'package:mutliline_turing_machine/styles/app_images.dart';
import 'package:mutliline_turing_machine/ui/hotkey_widget.dart';

class CustumScrollController extends ScrollController {
  CustumScrollController({int scrollSpeed = 40}) {
    super.addListener(() {
      ScrollDirection scrollDirection = super.position.userScrollDirection;
      if (scrollDirection != ScrollDirection.idle) {
        double scrollEnd = super.offset +
            (scrollDirection == ScrollDirection.reverse
                ? scrollSpeed
                : -scrollSpeed);
        scrollEnd = min(super.position.maxScrollExtent,
            max(super.position.minScrollExtent, scrollEnd));
        jumpTo(scrollEnd);
      }
    });
  }
}

class Reference extends StatelessWidget {
  const Reference({Key? key}) : super(key: key);

  Widget title(String name, BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 640),
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(bottom: 16, left: 32, right: 32, top: 32),
      child: Text(
        name,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Theme.of(context).cardColor,
          fontWeight: FontWeight.w700,
          fontSize: 24,
        ),
      ),
    );
  }

  Widget subTitle(String name, BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 640),
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(bottom: 16, left: 32, right: 32, top: 16),
      child: Text(
        name,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Theme.of(context).cardColor,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget text(String name, BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 640),
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(left: 32, right: 32),
      child: Text(
        name,
        textAlign: TextAlign.justify,
        style: TextStyle(
          color: Theme.of(context).cardColor.withOpacity(0.6),
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget hotKey(String name, List<String> hotKey, BuildContext context) {
    return HotKeyWidget(name: name, hotKey: hotKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 6),
              height: 40,
              child: Row(
                children: [
                  Tooltip(
                    message: " Выход",
                    child: ElevatedButton(
                        style: appButtonStyle(context),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Image(
                          image: AppImages.back,
                          color: Theme.of(context).cardColor,
                        )),
                  ),
                  Container(
                    width: 8,
                  ),
                  Text(
                    "Справочка",
                    style: TextStyle(
                      color: Theme.of(context).cardColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).highlightColor,
              thickness: 2,
              height: 2,
            ),
            Expanded(
              child: ListView(
                cacheExtent: 10,
                controller: CustumScrollController(),
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 32),
                    constraints:
                        const BoxConstraints(minWidth: double.infinity),
                    child: Column(
                      children: [
                        title("Общие сведения", context),
                        text(
                            """Машина Тьюринга - абстрактная вычислительная машина, предложенная Аланом Тьюрингом в 1936 году, которая манипулирует символами на полосе ленты в соответствии с таблицей правил.

Многоленточная машина Тьюринга является расширением данной идеи, внося возможность использовать неограниченное количество лент.

В данной реализации лента состоит из двух тысяч ячеек, а количество лент ограничено шестнадцатью. """,
                            context),
                        title("Интерфейс", context),
                        text(
                            """Интерфейс приложения можно условно разделить на 5 частей:
      • Верхняя панель инструментов
      • Панель лент
      • Нижняя панель инструментов
      • Панель команд
      • Панель комментариев""", context),
                        subTitle("Верхняя панель инструментов", context),
                        text("""Слева панели находятся кнопки:
      • Работа с файлами
          • Новый файл
          • Загрузить
          • Сохранить как
      • Настройки
      • Раздел “О приложении”
      • Справка
    
В правой части находятся кнопки, отвечающие за работу с лентами:
      • Сохранение лент - сохраняет содержимое лент
      • Восстановление лент - заполняет ленты символами из последнего сохранения
      • Очистка лент - удаляет содержимое всех лент и устанавливает головки на нулевые ячейки.
      • Добавление ленты в конец
      • Удаление последней ленты
    
При удерживании курсора на кнопке, под ней отображается её описание.""",
                            context),
                        subTitle("Панель лент", context),
                        text(
                            """Панель лент - это часть интерфейса, которая отображает текущее состояние лент многоленточной машины тьюринга. Кроме того, эта панель обрабатывает ввод символов в ленту и перемещение головки. По центру каждой ленты находится активная ячейка, которая отображает текущее положение головки на данной ленте.

ЛКМ по ячейке делает её ячейкой для ввода.
ПКМ по ячейке делает её активной.""", context),
                        subTitle("Нижняя панель инструментов", context),
                        text("""Слева панели находятся кнопки: 
      • Добавление состояния в конец
      • Удаление выбранного состояния
      • Добавление команды
      • Удаление команды
    
Справа же:
      • Сброс работы машины (появляется при её работе)
      • Включение/выключение автоматического режима работы
      • Изменение скорости работы
      • Выполнение шага
      • Скрытие/открытие раздела комментариев
    
Также при запуске машины появляется поле с количеством пройденных конфигураций.""",
                            context),
                        subTitle("Панель команд", context),
                        text(
                            """Панель команд представляет собой таблицу с ячейками, в каждую из которых можно вписывать команду работы многоленточной машины тьюринга. Столбцами данной таблицы являются ленты, а строки - команды.""",
                            context),
                        subTitle("Панель комментариев", context),
                        text(
                            """Панель комментариев это текстовое поле, в котором вы можете оставлять свои заметки о работе машины и/или вписывать условие задачи. Хотя, никто не запретит вам рассказать, например, о своих переживаниях.""", //)
                            context),
                        title("Работа в программе", context),
                        subTitle("Алгоритм работы Машины Тьюринга", context),
                        text(
                            """Машина Тьюринга, находясь в активном состоянии, производит поиск по всем ее командам в порядке их следования и при нахождении команды - выполняет шаг. Если же нужной команды не нашлось, то программа выведет уведомление об этом в нижнем правом углу. 

Таким образом, если в состоянии записаны команды “1 2 >” и “1 3 >”, то при нахождении на ленте символа “1” выполнится команда “1 2 >”, так как она находится выше в списке команд, чем “1 3 >”.""",
                            context),
                        subTitle("Управление Машиной Тьюринга", context),
                        text(
                            """Машина Тьюринга может работать как  ручном, так и в автоматическом режиме. При ручном режиме для выполнения шага необходимо нажать кнопку “Сделать шаг” на нижней панели инструментов. Автоматический режим подразумевает выполнение шагов машиной без действий со стороны пользователя. Для перехода в автоматический режим нужно нажать на кнопку “Автоматическая работа” в нижней панели. Чтобы выйти из автоматического режима необходимо повторно нажать на эту кнопку.

У автоматического режима можно настраивать скорость. Нажав на кнопку изменения скорости рядом с кнопкой “Автоматическая работа” появится всплывающий список, в котором можно выбрать желаемую скорость. Скорость измеряется в количестве шагов в секунду.

Чтобы остановить выполнение машины и сбросить текущее состояние нужно нажать на кнопку “Стоп” на нижней панели инструментов.""",
                            context),
                        title("Ввод", context),
                        subTitle("Ввод команд", context),
                        text(
                            """Каждая команда, вводимая в таблицу, представляет собой 3 символа в формате “0 1 >”, где “0” - заменяемый символ, “1” - заменяющий символ, а “>” - направление движения головки.

Заменяемый и заменяющий символы могут быть представлены в виде букв, цифр или спецсимволов. Для обозначения пробела используется спецсимвол “_”.

Направление движения головки представляется одной из трех вариаций:
“_” - Головка не сдвигается после замены символа
“<” - Головка сдвигается влево после замены символа
“>” - Головка сдвигается вправо после замены символа

При этом для указания команд существует возможность игнорировать заменяемый и заменяющий символ, обозначая их через “*”.

Тогда, к примеру, запись “* 1 _” будет означать, что неважно какой символ будет встречен, он в любом случае будет заменен на “1”, а головка не сдвинется.

Спецсимвол “*” также можно использовать вместо заменяющего символа. Тогда запись “1 * >” будет означать, что при встрече символа "1" мы заменяем его на тот же символ и двигаем головку вправо. Записи “1 * >” и “1 1 >” являются эквивалентными.

Кроме того, его можно использовать одновременно и как заменяемый, и как заменяющий символ. Так, запись “* * <” будет означать, что мы в любом случае просто двигаем головку влево.

Последний столбец в панели команд - столбец переходов. Значение в ячейки - номер состояния, в которое перейдёт машина после выполнения данного правила. По умолчанию переход идёт в это же состояние. 

Доступна возможность быстрого копирования и вставки содержимого ячеек таблицы сочетаниями клавиш Ctrl + C, Ctrl + V.

Для копирования всей команды или группы команд нужно выделить нужные команды и использовать сочетания клавиш Ctrl + C, Ctrl + V. Выделять команду по отдельности можно с помощью клавиши Ctrl.  Сразу группу - с помощью клавиши Shift. 

Порядок команд можно изменять. Для этого нужно нажать на иконку в виде 6-ти точек возле номера команды и перетянуть ее на желаемое место. Также, выделив несколько команд, можно перемещать их все одновременно.""",
                            context),
                        subTitle("Ввод в ленту", context),
                        text(
                            """В каждую отдельную ячейку можно вводить символы с клавиатуры. Выбрать ячейку для ввода можно, нажав неё. У ячейки, в которую в данный момент осуществляется ввод, символ подчёркнут. При печати лента автоматически смещается.

Вводить в ячейку можно любые символы, кроме “*” и “_”. Для удаления символов нужно нажать “Backspace” на Windows или “Delete” на MacOS. Передвигать головку ленты, не вводя символы, можно с помощью стрелочек вправо и влево.""",
                            context),
                        title("Управление и горячие клавиши", context),
                        text(
                            """Помимо навигации с помощью мыши, можно перемещаться по интерфейсу с использованием клавиатуры, нажимая “Tab” и “Shift + Tab” для перемещения фокуса вперед и назад, соответственно. Также можно использовать стрелочки на клавиатуре для смещения фокуса.

Текущий файл автосохраняется каждые 3 минуты, папка с автосохранениями открываться по умолчанию при загрузке файла.""",
                            context),
                        subTitle("Горячие клавиши:", context),
                        hotKey("Настройки", ["F1"], context),
                        hotKey("О приложении", ["F2"], context),
                        hotKey("Справка", ["F3"], context),
                        hotKey("Быстрое сохранение", ["F5"], context),
                        hotKey("Новый файл", ["Сtrl", "N"], context),
                        hotKey("Сохранить как", ["Сtrl", "S"], context),
                        hotKey("Загрузить", ["Сtrl", "O"], context),
                        hotKey("Сохранить все ленты", ["Сtrl", "Shift", "S"],
                            context),
                        hotKey("Загрузить все ленты", ["Сtrl", "Shift", "L"],
                            context),
                        hotKey("Очистить все ленты", ["Сtrl", "Shift", "C"],
                            context),
                        hotKey(
                            "Добавить ленту в конец", ["Сtrl", "]"], context),
                        hotKey(
                            "Удалить последнюю ленту", ["Сtrl", "["], context),
                        hotKey("Скрыть/показать комментарии", ["Сtrl", "H"],
                            context),
                        //hotKey("Удаление ленты", ["Сtrl", "["], context),
                        hotKey("Сбросить машину", ["Сtrl", "E"], context),
                        hotKey("Автоматическая работа", ["Сtrl", "R"], context),
                        hotKey("Изменить скорость", ["Сtrl", "T"], context),
                        hotKey("Сделать шаг", ["Сtrl", "Space"], context),
                        hotKey("Добавить состояние в ", ["Сtrl", "Shift", "+"],
                            context),
                        hotKey("Удалить выбранное состояние",
                            ["Сtrl", "Shift", "-"], context),
                        hotKey("Добавить команду", ["Сtrl", "+"], context),
                        hotKey("Удалить команду", ["Сtrl", "-"], context),
                        title("Рецепт пельменей", context),
                        text(
                            """Пельмени. Хорошие пельмени это очень вкусно. На самом деле рецепт простой — много мяса, мало теста. Сперва готовим тонкое яичное тесто с добавлением сливочного масла, лук сладких сортов для образования бульончика и перец, совсем немного. Щедро выкладываем великолепный рубленный фарш. Много мяса, мало теста. Вот он, настоящий пельмень. А внутри много сочной начинки: грудинка индюшки с курицей или телятена со свинниной. Думаю, многие и забыли как это может быть вкусно. Много мяса, мало теста.""",
                            context),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
