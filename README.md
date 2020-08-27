# VKClient
# Geekbrains. Итоговая работа курса "Пользовательский интерфейс iOS-приложений".

[1lesson](#1lesson)<br />
[2lesson](#2lesson)<br />
[3lesson](#3lesson)<br />
[4lesson](#4lesson)<br />
[5lesson](#5lesson)<br />
[6lesson](#6lesson)<br />
[8lesson](#8lesson)

### 1lesson. 
1. Создать приложение.
2. Добавить форму для входа.
3. Адаптировать форму для телефонов в альбомной ориентации, планшетов.

### 2lesson.
1. Добавить в приложение UITabbarViewController, три UITableViewController и один
UICollectionViewController.
2. После того как пользователь ввел верные логин и пароль,
UITabbarViewController.
3. Добавить две вкладки в UITabbarViewController.
4. На первой вкладке настроить переходы в следующем порядке: UINavigationController — UITableViewController — UICollectionViewController. 
Это будущая вкладка для отображения друзей пользователя «ВКонтакте» и его фотографий. 
Переход с таблицы на коллекцию должен происходить по нажатию на ячейку.
5. На второй вкладке — в таком порядке: UINavigationController — UITableViewController — UITableViewController. 
Первый контроллер для отображения групп пользователя, второй — для отображения глобального поиска групп, которые могут быть интересны пользователю. 
Для перехода с первой таблицы на вторую на NavigationBar необходимо создать Bar Button Item.

### 3lesson. 
1. Добавить на все контроллеры прототипы ячеек.
2. На первой вкладке ​UITableViewController должен отображать список друзей пользователя. В прототипе ячеек должна быть текстовая надпись с именем друга и изображением с его аватаркой.
3. UICollectionViewController должен отображать фото выбранного друга. Соответственно, в прототипе ячейки должно быть изображение.
4. На второй вкладке ​UITableViewController должен отображать группы пользователя. Прототип должен содержать текстовую надпись для имени группы и изображение для ее аватарки.
5. Второй ​UITableViewController будет отображать группы, в которых пользователь не состоит. В будущем мы добавим возможность поиска сообщества по названию. Ячейки должны использоваться такие же, как и на прошлом контроллере.
6. Создать папку ​Model,​а в ней — файлы содержащие ​struct,​или ​class,​описывающий профиль пользователя, — ​User,​группу «ВКонтакте» — ​Group.​
7. Подготовить массивы демонстрационных данных, отобразить эти данные на соответствующих им экранах.
8. Реализовать добавление и удаление групп пользователя.

### 4lesson. 
1. Создать свой View для аватарки. Он должен состоять из двух subview:
2. Должен содержать UIImageView с фотографией пользователя и быть круглой формы.
3. Должен находиться ниже и давать тень по периметру фотографии. Учтите, что тень будет отображена, если backgroudColor != .clear.
4. Предусмотреть возможность изменения ширины, цвета, прозрачности тени в interface builder. (задание на самостоятельный поиск решения).
5. Создать контрол «Мне нравится», с помощью которого можно поставить лайк под постом в ленте. Данный контрол должен объединять кнопку с иконкой сердца и количеством отметок рядом с ней. При нажатии на контрол нужно увеличить количество отметок, а при повторном нажатии — уменьшить (как это реализовано в приложении ВКонтакте). В состоянии, когда отметка поставлена, иконка и текст должны менять цвет.
6. *Сделать контрол, позволяющий выбрать букву алфавита. Он понадобится на экране списка друзей. Дизайн можно позаимствовать у оригинального приложения ВКонтакте. Должна быть возможность выбрать букву нажатием или перемещением пальца по контролу. При выборе нужно пролистывать список к первому человеку, у которого фамилия начинается на эту букву. Желательно сделать так, чтобы в этом контроле не было букв, на которые не начинается ни одна фамилия друзей из списка. (необязательное, для тех, у кого есть время)

### 5lesson. 
1. Посвятите это время работе над вашим проектом. Ваше портфолио - это ваше лицо для будущих работодателей.
2. Доделайте те задания, которые не успели сделать к предыдущим урокам.
3*. Добавьте в ваш проект какие-нибудь новые фичи на ваше усмотрение.
- Поработал над дизайном.
- Сделал передачу имени выбранного пользователя в NavigationControl - title.
- Убрал текст из кнопки возврата на экран MyFriends.

### 6lesson. 


### 7lesson. 


### 8lesson. 
