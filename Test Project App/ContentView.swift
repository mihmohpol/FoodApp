import SwiftUI
internal import Combine

struct ContentView: View {
    // Состояние таймера
    @State private var timerMinutes: Int = 10          // Выбранное время (в минутах)
    @State private var isTimerRunning: Bool = false      // Флаг: идёт ли отсчёт
    @State private var remainingSeconds: Int = 0         // Оставшиеся секунды
    @State private var showTimerAlert: Bool = false     // Флаг для алерта о завершении

    // Таймер для обновления интерфейса каждую секунду
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        NavigationStack {
            ZStack {
                // Фон
                Color(.systemBackground)
                    .ignoresSafeArea()

                VStack(spacing: 24) {
                    // Заголовок
                    Text("Кулинарная книга")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 40)

                    // Подзаголовок
                    Text("Выберите время и запустите таймер")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    // Поле выбора времени
                    HStack {
                        Text("Время:")
                            .font(.headline)

                        Picker("", selection: $timerMinutes) {
                            ForEach(1...120, id: \.self) { minutes in
                                Text("\(minutes) мин")
                            }
                        }
                        .pickerStyle(.menu)
                        .frame(width: 120)

                        Text("до готовности")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 20)

                    // Дисплей таймера
                    Text(formatTime(remainingSeconds))
                        .font(.system(size: 64, weight: .light))
                        .foregroundColor(isTimerRunning ? .primary : .secondary)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.gray.opacity(0.1))
                        )
                        .frame(width: 200)

                    // Кнопка запуска/остановки таймера
                    Button {
                        if isTimerRunning {
                            stopTimer()
                        } else {
                            startTimer()
                        }
                    } label: {
                        Text(isTimerRunning ? "Остановить" : "Запустить таймер")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(isTimerRunning ? Color.red : Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 20)

                    // Кнопка открытия меню рецептов
                    Button {
                        // Здесь можно добавить переход к MenuView
                    } label: {
                        Label("Выбрать блюдо", systemImage: "list.bullet")
                            .font(.callout)
                            .padding(8)
                            .background(Color.clear)
                            .foregroundColor(Color.accentColor)
                    }

                    Spacer()
                }
                // Обработчик таймера (каждую секунду)
                .onReceive(timer) { _ in
                    if isTimerRunning && remainingSeconds > 0 {
                        remainingSeconds -= 1
                    } else if remainingSeconds == 0 && isTimerRunning {
                        stopTimer()
                        showTimerAlert = true
                    }
                }
                // Алерт о завершении таймера
                .alert("Таймер завершён!", isPresented: $showTimerAlert) {
                    Button("ОК", role: .cancel) { }
                }
            }
        }
    }

    // Форматирует секунды в строку "MM:SS"
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", minutes, secs)
    }

    // Запускает таймер
    private func startTimer() {
        isTimerRunning = true
        remainingSeconds = timerMinutes * 60  // Переводим минуты в секунды
    }

    // Останавливает таймер
    private func stopTimer() {
        isTimerRunning = false
        remainingSeconds = 0
    }
}

// Превью для Xcode
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
