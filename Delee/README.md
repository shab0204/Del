# Delee

Приложение для доставки еды на Swift и SwiftUI. Учебный проект: собирается вручную, чтобы отработать архитектуру SwiftUI-приложения, работу с состоянием и загрузку данных из сети.

## Возможности

- Каталог блюд с разбивкой по категориям
- Экран блюда с подробным описанием
- Корзина: добавление, изменение количества, оформление заказа
- Избранное
- Промокоды и акции
- Адреса доставки: список, добавление, редактирование
- История заказов
- Профиль пользователя и авторизация

## Стек

- Swift
- SwiftUI
- `URLSession` для сетевых запросов
- `ObservableObject` / `EnvironmentObject` для состояния
- Xcode 26, iOS 26

## Структура проекта

```
Delee/
├── Components/     переиспользуемые вью: DishCard, ProfileRow, RadioButton
├── Models/         модели данных и сторы состояния
│   ├── Dish, MealCategory, CartItem, Order, Promo, Address, UserInfo
│   └── DishStore, CartStore, OrderStore, FavoritesStore, PromoStore, UserStore
├── Resources/      MealAPI (сетевой слой), AppGradient (оформление)
├── Views/
│   ├── Auth/       экраны входа и регистрации
│   ├── Home/       главный экран и категории
│   ├── Detail/     карточка блюда
│   ├── Cart/       корзина и оформление
│   └── MainTabView, ProfileView, OrdersView, FavoritesView, AddressesView
└── DeleeApp.swift  точка входа, подключение сторов через EnvironmentObject
```

Модели описывают данные, сторы хранят состояние и логику, вью занимаются только отображением.

## Запуск

```bash
git clone https://github.com/shab0204/Delee.git
cd Delee
open Delee.xcodeproj
```

Дальше выбрать симулятор и нажать Run (⌘R).

## Статус

В разработке. Проект учебный, код постепенно переписывается по мере освоения новых подходов.

## Автор

Шабнам Шарипова — [@shab0204](https://github.com/shab0204)
