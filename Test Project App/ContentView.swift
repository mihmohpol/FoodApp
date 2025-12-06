import SwiftUI


struct ContentView: View {
    @State private var selectedTime = 0
    @State private var showingRecipeSheet = false
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Фон приложения
                Color(.systemBackground)
                    .ignoresSafeArea()
                
                
                VStack {
                    // Заголовок приложения
                    Text("Кулинарная книга")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 40)
                    
                    // Подзаголовок с описанием
                    Text("Выберите блюдо и узнайте рецепт!")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 30)
                    
                    // Кнопка для открытия меню рецептов
                    Button {
                        showingRecipeSheet = true
                    } label: {
                        Label("Выбрать блюдо", systemImage: "list.bullet")
                            .font(.headline)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 20)
                    
                    // Заполнитель для вертикального пространства
                    Spacer()
                }
            }
            // Лист с меню рецептов (открывается по нажатию кнопки)
            .sheet(isPresented: $showingRecipeSheet) {
                NavigationStack {
                    MenuView(selectedTime: $selectedTime)
                        // Размер листа: занимает большую часть экрана
                        .presentationDetents([.large])
                        // Индикатор перетаскивания листа
                        .presentationDragIndicator(.visible)
                }
            }
        }
    }
}

// Превью для Xcode (отображается в Canvas)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait) // Портретная ориентация
    }
}
