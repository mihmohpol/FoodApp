import SwiftUI

struct MenuView: View {
    @Binding var selectedTime: Int
    @Environment(\.presentationMode) var presentationMode
    
    let recipes = Recipe.mockRecipes()
    private let fallbackImage = Image(systemName: "photo")
    private let placeholder = Color.gray.opacity(0.2)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 20),
                    GridItem(.flexible(), spacing: 20)
                ], spacing: 20) {
                    ForEach(recipes) { recipe in
                        Button {
                            selectedTime = recipe.defaultTime ?? 0
                        } label: {
                            VStack(spacing: 8) {
                                Group {
                                    if Image.exists(named: recipe.imageName) {
                                        Image(recipe.imageName)
                                            .resizable()
                                            .scaledToFit()
                                    } else {
                                        fallbackImage
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.gray)
                                    }
                                }
                                .frame(width: 120, height: 120)
                                .background(placeholder)
                                .cornerRadius(12)
                                
                                Text(recipe.name)
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.75)
                                    .foregroundColor(.primary)
                                    .frame(maxWidth: .infinity)
                            }
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color(.systemBackground))
                                    .shadow(radius: 2)
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .navigationDestination(for: Recipe.self) { selectedRecipe in
                        RecipeDetailView(recipe: selectedRecipe)
                    }
                }
                .padding([.horizontal, .top], 16)
                .padding(.bottom, 34)
                .navigationTitle("Меню блюд")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Закрыть") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
        }
    }
}
