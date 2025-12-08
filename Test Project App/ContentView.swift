import SwiftUI
internal import Combine

struct ContentView: View {
    // Состояние таймера
    @State private var hours: Int = 0
    @State private var minutes: Int = 10
    @State private var seconds: Int = 0
    @State private var isTimerRunning: Bool = false
    @State private var remainingSeconds: Int = 0
    @State private var totalSeconds: Int = 0
    @State private var showTimerAlert: Bool = false

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

                    // Выбор времени (часы, минуты, секунды)
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
                        .frame(width: 90)

                        Picker("", selection: $seconds) {
                            ForEach(0...59, id: \.self) { second in
                                Text("\(second) сек")
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 80)
                    }
                    .padding(.horizontal, 20)

                    // Круговой индикатор (появляется только при isTimerRunning == true)
                    if isTimerRunning {
                        ZStack {
                            Circle()
                                .stroke(Color.gray.opacity(0.3), lineWidth: 20)
                                .frame(width: 200, height: 200)


                            Circle()
                                .trim(from: 0, to: progress())
                                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                                .foregroundColor(progressColor())
                                .rotationEffect(.degrees(-90))
                                .animation(.easeOut(duration: 0.2), value: remainingSeconds)


                            Text(formatTime(remainingSeconds))
                                .font(.system(size: 48, weight: .light))
                                .foregroundColor(.primary)
                        }
                    }

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

    // Вычисляем прогресс (от 0 до 1)
    private func progress() -> CGFloat {
        guard totalSeconds > 0 else { return 0 }
        return CGFloat(remainingSeconds) / CGFloat(totalSeconds)
    }

    // Определяем цвет индикатора в зависимости от прогресса
    private func progressColor() -> Color {
        let progressValue = progress()
        if progressValue > 0.6 {
            return Color.green
        } else if progressValue > 0.3 {
            return Color.yellow
        } else {
            return Color.red
        }
    }

    // Форматируем секунды в "HH:MM:SS"
    private func formatTime(_ totalSeconds: Int) -> String {
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    // Запускаем таймер
    private func startTimer() {
        totalSeconds = hours * 3600 + minutes * 60 + seconds
        if totalSeconds == 0 {
            showTimerAlert = true  // Предупреждение о нулевом времени
            return
        }
        
        isTimerRunning = true
        remainingSeconds = totalSeconds
    }

    // Останавливаем таймер
    private func stopTimer() {
        isTimerRunning = false
        remainingSeconds = 0
        totalSeconds = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
