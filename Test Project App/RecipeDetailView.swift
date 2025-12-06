import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Изображение блюда
                ZStack {
                    if Image.exists(named: recipe.imageName) {
                        Image(recipe.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 240)
                            .cornerRadius(12)
                    } else {
                        Color.gray.opacity(0.2)
                            .frame(height: 240)
                            .overlay {
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.gray)
                            }
                            .cornerRadius(12)
                    }
                }
                
                // Название
                Text(recipe.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 12)
                
                // Время приготовления и сложность
                HStack(spacing: 20) {
                    if let time = recipe.defaultTime {
                        Label {
                            Text("\(time) мин")
                                .font(.body)
                        } icon: {
                            Image(systemName: "clock")
                                .foregroundColor(.accentColor)
                        }
                    }
                    
                    if let difficulty = recipe.difficulty {
                        Label {
                            Text("Уровень \(difficulty)")
                                .font(.body)
                        } icon: {
                            Image(systemName: "star.fill")
                                .foregroundColor(difficulty <= 2 ? .yellow : .red)
                        }
                    }
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                // Описание
                if let desc = recipe.description {
                    Text(desc)
                        .font(.body)
                        .lineSpacing(6)
                        .padding(.vertical, 4)
                }
                
                Divider()
                
                // Ингредиенты
                if let ingredients = recipe.ingredients, !ingredients.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Ингредиенты")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        ForEach(ingredients, id: \.self) { ingredient in
                            Text("• \(ingredient)")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                        }
                    }
                    .padding(.bottom, 16)
                }
                
                // Калорийность
                if let calories = recipe.calories {
                    HStack {
                        Image(systemName: "bolt.circle")
                        Text("\(calories) ккал на порцию")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer(minLength: 30)
            }
            .padding()
            .navigationTitle(recipe.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
