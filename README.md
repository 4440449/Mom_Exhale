# #мамавыдохни
#### Основной модуль проекта #мамавыдохни
#### Включает в себя подпроекты:
- [#мамавыдохни: напоминания](https://github.com/4440449/CalmMom)
- [#мамавыдохни: самоприкорм](https://github.com/4440449/Samoprikorm_SP)
- [#мамавыдохни: трекер](https://github.com/4440449/BabyTrackerWW)

        
                
## Tech specs
- Модульная архитектура, проект разделен на подпроекты, которые инъектятся через SPM обертку
- MVVМ + R. Элементы Clean architecture
- Каждый экран выделен в отдельную сцену со своим окружением (Configurator, ViewModel, Router)
- Плоский Navigation Flow с Repository store container, подробнее [здесь](https://github.com/4440449/CalmMom/blame/master/README.md#L22-L38)
- DI для каждой сцены со сбокрой через static объект
- Observing через [собственную библиотеку](https://github.com/4440449/MommysEye)
- Network через [собственную библиотеку](https://github.com/4440449/BabyNet)
- Backend - <a href="https://app.supabase.com">Supabase</a>
- Project Targets
- UI - UIKit, кодом
- Dark mode


## Features
* Основной проект состоит из блока авторизации, настроек пользователя и основной сцены, которая предоставляет навигацию по разным модулям проекта. В зависимости от уровня доступа, пользователю предоставляется различный пул доступных модулей и функционала.
         
* Навигация по модулям происходит через отдельный [Конфиг объект](https://github.com/4440449/Mom_Exhale/blob/master/Mom_Exhale/Source/AppConfigurator/AppModuleConfigurator_ME.swift), в котором инкапсулированы все зависимости. Делая свич по входящему ключу, Конфиг предоставляет ту или иную реализацию презентуемого модуля в виде его начального View Controller с полным окружением и зависимостями. Далее, полученный View Controller презентится модально.  
    **Схема:**  
    ![Alt text](README_ASSETS/NavigationFlow.png "Navigation flow")
                         
* Проект разделен на таргеты, переключая которые можно переходить в режим отладки, либо как самостоятельного проекта, либо как основного модуля для других проектов.
         
* Все четыре подмодуля построены на разных UI интерфейсах (UIKit Storyboard, UIKit code, SwiftUI). А также реализуют разную архитектуру (MVVM, MVP, Redux) с некоторыми ситуативными доработками, подробнее про каждый проект см. выше в шапке файла.
        
* Преимущества модульной архитектуры:
    + Переиспользование модулей в других проектах
    + Легкое выпиливание / отключение неактуального модуля
    + Удобство разработки / отладки модуля, как самостоятельного небольшого проекта, скорость сборки
    + Каждый модуль содержит свой пул зависимостей, что подразумевает отсутствие конфликтов
    + Меньший размер модуля по сравнению с монолитным приложением
            

## TODO 
- Authorization
- In app handling dark mode
- Article detail scene


    
# MARKETING 
Приложение будет полезно молодым мамам, которые сталкиваются с распространенными проблемами по уходу за ребёнком и нуждаются в информационной поддержке. Приложение содержит несколько модулей, ориентированных на конкретную тему:

#### Модуль [Напоминания](https://github.com/4440449/CalmMom)
Полезен для оказания психологической поддержка для матери через аффирмации. Получайте уведомления, которые содержат цитату дня. Цитаты были подобраны и отмечены участниками проекта #мамавыдохни как успокаивающие, подбадривающие, помогающие мамам сохранять гармонию. Сохраняйте понравившиеся цитаты в виде обоев для телефона.

#### Модуль [Самоприкорм](https://github.com/4440449/Samoprikorm_SP)
Полезен для быстрого поиска информации о правильной подаче, содержании аллергенов и рекомендуемом возрасте продуктов для ввода прикорма ребенка по системе BLW (современный метод ввода прикорма).

#### Модуль [Трекер](https://github.com/4440449/BabyTrackerWW)
Полезен при проблемах со сном у ребенка. Записывайте и отслеживайте динамику состояния вашего малыша перед сном и после сна. 

#### Галереи «Блог» и «Базовые статьи»
Читайте статьи о физиологии детского сна, детско-родительских отношениях и привязанности. Посты из блога в Инстаграм и Телеграм-канала можно также читать прямо из приложения.



# HOW TO USE APP
Главный экран содержит несколько блоков: галерею из статей блога, галерею из базовых статей сайта #мамавыдохни и 3 модуля (мини-приложения) – 'Трекер сна’’, Напоминания', 'Прикорм'. 


 

