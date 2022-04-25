import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/styles/app_button.dart';
import 'package:mutliline_turing_machine/styles/app_colors.dart';
import 'package:mutliline_turing_machine/styles/app_images.dart';

class Reference extends StatelessWidget {
  const Reference({Key? key}) : super(key: key);

  Widget title(String name) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 640),
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(bottom: 16, left: 32, right: 32, top: 32),
      child: Text(
        name,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: AppColors.text,
          fontWeight: FontWeight.w700,
          fontSize: 24,
        ),
      ),
    );
  }

  Widget subTitle(String name) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 640),
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(bottom: 16, left: 32, right: 32, top: 16),
      child: Text(
        name,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: AppColors.text,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget text(String name) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 640),
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(left: 32, right: 32),
      child: Text(
        name,
        textAlign: TextAlign.justify,
        style: TextStyle(
          color: AppColors.text,
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 6),
            height: 42,
            child: Row(
              children: [
                ElevatedButton(
                    style: appButtonStyle,
                    onPressed: () {},
                    child: const Image(
                      image: AppImages.file,
                    )),
                Container(
                  width: 8,
                ),
                Text(
                  "Справочка",
                  style: TextStyle(
                    color: AppColors.text,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: AppColors.highlight,
            thickness: 2,
            height: 2,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(bottom: 32),
                //color: Colors.redAccent,
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: Column(
                  children: [
                    title("Общие сведения"),
                    text(
                        "Машина Тьюринга - абстрактная вычислительная машина, предложенная Аланом Тьюрингом в 1936 году, которая манипулирует символами на полосе ленты в соответствии с таблицей правил. Многоленточная машина Тьюринга является расширением данной идеи, внося возможность использовать неограниченное количество лент."),
                    title("Интерфейс"),
                    text(
                        """Интерфейс приложения можно условно разделить на 5 частей:
    * Верхняя панель инструментов
    * Панель лент
    * Нижняя панель инструментов
    * Панель правил
    * Панель комментариев"""),
                    subTitle("Верхняя панель инструментов"),
                    text("""Слева панели находятся кнопки:
    * Работа с файлами
    * Настройки
    * Раздел “О приложении”
    * Справка

В правой части находятся кнопки, отвечающие за работу с лентами:
    * Сохранение лент - сохраняет содержимое лент
    * Восстановление лент - заполняет ленты символами из последнего сохранения
    * Очистка лент - удаляет содержимое всех лент и устанавливает головки на нулевые ячейки.
    * Добавление ленты в конец
    * Удаление последней ленты

При удерживании курсора на кнопке, под ней отображается её описание."""),
                    subTitle("Панель лент"),
                    text(
                        """Панель лент - это часть интерфейса, которая отображает текущее состояние лент многоленточной машины тьюринга. Кроме того эта панель обрабатывает ввод символов в ленту и перемещение головки. По центру каждой ленты находится выделенная ячейка, которая отображает текущее положение головки на данной ленте."""),
                    subTitle("Нижняя панель инструментов"),
                    text("""Слева панели находятся кнопки: 
    * Добавление состояния
    * Удаление состояния
    * Добавление правила
    * Удаление правила

Справа же:
    * Остановка машина (появляется при её работе)
    * Включение/выключение автоматического режима работы
    * Изменение скорости работы
    * Выполнение шага
    ( Скрытие/открытие раздела комментариев

Также при запуске машины появляется поле с количеством пройденных конфигураций."""),
                    subTitle("Панель правил"),
                    text(
                        """Панель правил представляет собой таблицу с ячейками, в каждую из которых можно вписывать правило работы многоленточной машины тьюринга. Столбцами данной таблицы являются ленты, а строки - правила."""),
                    subTitle("Панель комментариев"),
                    text(
                        """Панель комментариев это текстовое поле, в котором вы можете оставлять свои заметки о работе машины и/или вписывать условие задачи."""),
                    title("Ввод"),
                    subTitle("Ввод правил"),
                    text(
                        """Каждое правило вводимое в панель правил представляет собой 3 символа в формате “0 1 >”, где “0”- заменяемый символ, “1” -  заменяющий символ, а “>” - направление движения головки.

Заменяемый и заменяющий символы могут быть представлены в виде букв, цифр или спецсимволов. Для обозначения пробела используется символ “_”.

Направление движения головки представляется одной из трех вариаций:
    1. “_” - Головка не сдвигается после замены символа
    2. “<” - Головка сдвигается влево после замены символа
    3. “>” - Головка сдвигается вправо после замены символа

При этом для указания правил существует возможность игнорировать заменяемый и заменяющий символ, обозначая их через “*”.

Тогда к примеру запись “* 1 _” будет означать, что неважно какой символ будет встречен, он в любом случае будет заменен на “1”, а головка не сдвинется.

Спецсимвол “*” также можно использовать заместо заменяемого символа, тогда запись “1 * >” будет означать, что при встрече символа 1, мы заменяем его на тот же символ и двигаем головку вправо. Записи “1 * >” и “1 1 >” являются эквивалентными.

Кроме того, его можно использовать одновременно и как заменяемый и как заменяющий символ. Так, запись “* * <” будет означать, что мы в любом случае просто двигаем головку влево.

Последний столбец в панели правил - столбец переходов. Значние в ячейки - номер состояния, в которое перейдёт машина после выполнения данного правила. По умолчанию переход идёт в это же состояние. """),
                    subTitle("Ввод в ленту"),
                    text(
                        """В каждую отдельную ленту можно вводить символы с клавиатуры. Выбрать ленту для ввода можно, нажав на любую её ячейку или с помощью клавиш вниз и вверх.  У ленты, в которую в данный момент осуществляется ввод, под символом активной ячейки отображается белый прямоугольник с закруглёнными краями.

Вводить в ленту можно любые символы, кроме “*” и “_”. Для удаления символов нужно нажать “Backspace” на Windows или “Delete” на MacOS. Передвигать головку ленты, не вводя символы, можно с помощью стрелочек вправо и влево."""),
                    title("Управление"),
                    text(
                        """Помимо навигации с помощью мыши можно перемещаться по интерфейсу с использованием клавиатуры, нажимая  “Tab”, “Shift + Tab” для перемещения фокуса вперед и назад, соответственно. Также можно использовать стрелочки для смещения фокуса."""),
                    title("Рецепт пельменей"),
                    text(
                        """Пельмени. Хорошие пельмени это очень вкусно. На самом деле рецепт простой — много мяса, мало теста. Сперва готовим тонкое яичное тесто с добавлением сливочного масла, лук сладких сортов для образования бульончика и перец, совсем немного. Щедро выкладываем великолепный рубленный фарш. Много мяса, мало теста. Вот он, настоящий пельмень. А внутри много сочной начинки: грудинка индюшки с курицей или телятена со свинниной. Думаю, многие и забыли как это может быть вкусно. Много мяса, мало теста."""),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
