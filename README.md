# NewsApp
  Вас встречает главный экран, на котором показаны 15 последних новостей. При нажатии на любую ячейку, появляется карточка позиции, в которой представлена дополнительная информация

  - В проекте не были использованы посторонние библиотеки
  - Отображение контента из JSON файла
  - Данные взяты из предоставленных URL-ссылок
  - Приложение написано на языке Swift.
  - Для запроса данных используется URLSession.

# Технические детали 
- Язык программирования: Swift
- Интерфейс: UIKit
- Архитектура: MVP
- Загрузка данных: URLSession

# Для запуска
  1. Для запуска проекта можно скачать исходный zip-файл или применить в Xcode Swift Package Manager

  HTTPS: ```https://github.com/donailo456/Avito.git```
  
  SSH: ```git@github.com:donailo456/Avito.git```

  2. Откройте файл "avito.xcodeproj"
  3. Сбилдите и запустите проект в Xcode


# Важно 

  Для загрузки новостей я использовал сервис https://newsapi.org
  Чтобы загрузка данных произошла без ошибок, нужно зарегистрироваться на сайте и получить ключ доступа. В моем проекте представлен мою ключ, который может не отображать последние новости или может быть заблокирован
  
```
let topHeadlinesURL = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2023-07-31&sortBy=publishedAt&apiKey=(ВАШ КЛЮЧ)")
```

