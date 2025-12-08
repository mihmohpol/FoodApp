import SwiftUI
internal import Combine

struct ContentView: View {
    // Состояние таймера
    @State private var hours: Int = 0          // Часы (0–23)
    @State private var minutes: Int = 10         // Минуты (0–59)
    @State private var seconds: Int = 0         // Секунды (0–59)
    @State private var isTimerRunning: Bool = false
    @State private var remainingSeconds: Int = 0
    @State private var showTimerAlert: Bool = false


    // Таймер обновления интерфейса
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground)
                    .ignoresSafeArea()

                VStack(spacing: 24) {
                    Text("Кулинарная книга")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 40)

                    Text("Выберите время и запустите таймер")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    // Трёхкомпонентный Picker: часы, минуты, секунды
                    HStack {
                        Picker("", selection: $hours) {
                            ForEach(0...23, id: \.self) { hour in
                                Text("\(hour) ч")
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 60)

                        Picker("", selection: $minutes) {
                            ForEach(0...59, id: \.self) { minute in
                                Text("\(minute) мин")
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 80)

                        Picker("", selection: $seconds) {
                            ForEach(0...59, id: \.self) { second in
                                Text("\(second) сек")
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 80)
                    }
                    .padding(.horizontal, 20)

                    // Дисплей таймера
                    Text(formatTime(remainingSeconds))
                        .font(.system(size: 49, weight: .light))
                        .foregroundColor(isTimerRunning ? .primary : .secondary)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.gray.opacity(0.1))
                        )
                        .frame(width: 200)


                    // Кнопка управления таймером
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


                    // Кнопка меню рецептов
                    Button {
                        // Переход к MenuView
                    } label: {
                        Label("Выбрать блюдо", systemImage: "list.bullet")
                            .font(.callout)
                            .padding(8)
                            .background(Color.clear)
                            .foregroundColor(Color.accentColor)
                    }

                    Spacer()
                }
                .onReceive(timer) { _ in
                    if isTimerRunning && remainingSeconds > 0 {
                        remainingSeconds -= 1
                    } else if remainingSeconds == 0 && isTimerRunning {
                        stopTimer()
                        showTimerAlert = true
                    }
                }
                .alert("Таймер завершён!", isPresented: $showTimerAlert) {
                    Button("ОК", role: .cancel) { }
                }
            }
        }
    }

    // Форматирует секунды в "HH:MM:SS"
    private func formatTime(_ totalSeconds: Int) -> String {
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    // Запускает таймер (конвертирует часы+минуты+секунды в секунды)
    private func startTimer() {
        isTimerRunning = true
        remainingSeconds = hours * 3600 + minutes * 60 + seconds
        // Если выбрано 0 секунд — не запускаем
        if remainingSeconds == 0 {
            isTimerRunning = false
            showTimerAlert = true  // Можно заменить на другой алерт
        }
    }

    // Останавливает таймер
    private func stopTimer() {
        isTimerRunning = false
        remainingSeconds = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
