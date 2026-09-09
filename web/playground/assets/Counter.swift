// Counter — as a Playground project. Same source as the example apps'.
import SwiftUI
import SwiftUIExtensions

@main
struct CounterApp: App {
    var body: some Scene { WindowGroup { NavigationStack { CounterScreen() } } }
}

// Counter — the smallest example: a button that counts taps. Shared by the
// example apps (a catalog entry) and the Playground (a project template).


struct CounterScreen: View {
    @State private var count = 0

    var body: some View {
        VStack(spacing: 16) {
            Text("Hello from Universal UI!")
                .font(.title2)
            Text("Tapped \(count) times")
                .foregroundColor(.secondary)
            Button("Tap me") { count += 1 }
                .buttonStyle(.borderedProminent)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Counter")
    }
}

