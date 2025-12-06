import SwiftUI

struct Recipe: Identifiable, Hashable {
    let id = UUID()
    let name: String
    var defaultTime: Int?
    let imageName: String
    var description: String? = nil
    var ingredients: [String]? = nil
    var calories: Int? = nil
    var difficulty: Int? = nil
}

extension Recipe {
    static func mockRecipes() -> [Recipe] {
        return [
            Recipe(
                name: "Омлет",
                defaultTime: 5,
                imageName: "omelette",
                description: "Взбить 2 яйца с 50 мл молока, посолить, обжарить на сковороде 3–4 минуты.",
                ingredients: ["Яйца — 2 шт.", "Молоко — 50 мл", "Соль — по вкусу"],
                calories: 180,
                difficulty: 1
            ),
            Recipe(
                name: "Макароны",
                defaultTime: 8,
                imageName: "pasta",
                description: "Варить в кипящей подсоленной воде 7 минут, слить воду, добавить масло.",
                ingredients: ["Макароны — 200 г", "Вода — 2 л", "Соль — 1 ч. л.", "Масло — 10 г"],
                calories: 250,
                difficulty: 1
            ),
            Recipe(
                name: "Куриная грудка",
                defaultTime: 20,
                imageName: "chicken",
                description: "Обжарить кусочки грудки 15 минут, добавить специи, тушить 5 минут.",
                ingredients: ["Куриная грудка — 300 г", "Масло — 1 ст. л.", "Специи — по вкусу"],
                calories: 220,
                difficulty: 2
            ),
            Recipe(
                name: "Рассыпчатый рис",
                defaultTime: 25,
                imageName: "rice",
                description: """
                    1. Промойте рис 5–6 раз до прозрачной воды.
                    2. Откиньте на дуршлаг, дайте стечь.
                    3. В кастрюле смешайте рис, воду, соль и масло.
                    4. Доведите до кипения, перемешайте один раз.
                    5. Варите под крышкой 12 мин на минимальном огне.
                    6. Снимите с огня, накройте полотенцем, оставьте на 10 мин.
                    7. Разрыхлите вилкой перед подачей.
                    """,
                ingredients: [
                    "Рис — 1 стакан",
                    "Вода — 1,5 стакана",
                    "Соль — ½ ч. л.",
                    "Растительное масло — 1 ст. л. (по желанию)"
                ],
                calories: 220,
                difficulty: 1
            ),
            Recipe(
                name: "Овощи на пару",
                defaultTime: 10,
                imageName: "vegetables",
                description: "Положить овощи в пароварку, готовить 8–10 минут.",
                ingredients: ["Морковь — 1 шт.", "Брокколи — 100 г", "Цветная капуста — 100 г"],
                calories: 80,
                difficulty: 1
            )
        ]
    }
}
