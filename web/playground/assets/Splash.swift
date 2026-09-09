// The Universal UI site's front page — written in Universal UI's SwiftUI and
// compiled to wasm like the demos it shows. The page's host handles its
// commands: `demo:<name>` runs a demo bundle full screen, `playground`
// opens the in-browser Playground, `edit` opens this very file there.

import SwiftUI
import SwiftUIExtensions

@main
struct SplashApp: App {
    var body: some Scene { WindowGroup { SplashPage() } }
}

struct Demo: Identifiable {
    let id: String
    let title: String
    let blurb: String
    let symbol: String
}

let demos: [Demo] = [
    Demo(id: "example_full", title: "Example app", blurb: "Pokédex, Hacker News, Wikipedia, 2048, a meme maker and more — one SwiftUI codebase.", symbol: "square.grid.2x2"),
    Demo(id: "tap_counter", title: "Tap counter", blurb: "The smallest app: one button, one number — the benchmark cell every platform runs.", symbol: "plus.circle"),
    Demo(id: "hot_demo", title: "Hot reload demo", blurb: "A feature bundle the hosts swap in live — the same bytes the phone hot-reloads.", symbol: "arrow.triangle.2.circlepath"),
]

struct SplashPage: View {
    @State private var command = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                hero
                demoGrid
                playground
                footer
            }
            .frame(maxWidth: 980)
            .padding(.horizontal, 28)
            .padding(.vertical, 40)
            .frame(maxWidth: .infinity)
        }
        .platformCommand("splash", command, on: .wasm)
    }

    private func send(_ value: String) {
        // A distinct value each time, so repeated commands are delivered.
        command = value + "#" + String(Int(Date().timeIntervalSince1970 * 1000))
    }

    private var hero: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Universal UI")
                .font(.system(size: 44, weight: .bold))
            Text("SwiftUI, everywhere.")
                .font(.system(size: 28, weight: .semibold))
                .foregroundColor(.secondary)
            Text("A reimplementation of SwiftUI that compiles to WebAssembly, Android, Linux and Windows — and runs as the real thing on Apple platforms. Write `import SwiftUI` once; ship it as native views, as the web, or as a hot-reloadable bundle inside a native app.")
                .font(.system(size: 17))
                .lineSpacing(4)
            HStack(spacing: 12) {
                Button { send("playground") } label: {
                    Label("Open the Playground", systemImage: "play.fill")
                }
                .buttonStyle(.borderedProminent)
                Button { send("edit") } label: {
                    Label("Edit this page", systemImage: "pencil")
                }
                .buttonStyle(.bordered)
            }
            .padding(.top, 6)
            Text("This website is written in SwiftUI. You can edit it and re-compile the code without leaving the page.")
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.accentColor)
        }
    }

    private var demoGrid: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Demos").font(.title2).bold()
            Text("Each one is Swift compiled to wasm, rendered by the same tree the native hosts render. Tap to run it here.")
                .foregroundColor(.secondary)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 280), spacing: 16)], spacing: 16) {
                ForEach(demos) { demo in
                    Button { send("demo:" + demo.id) } label: {
                        VStack(alignment: .leading, spacing: 10) {
                            Image(systemName: demo.symbol).font(.system(size: 28)).foregroundColor(.accentColor)
                            Text(demo.title).font(.headline)
                            Text(demo.blurb).font(.subheadline).foregroundColor(.secondary)
                                .multilineTextAlignment(.leading)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(18)
                        .background(RoundedRectangle(cornerRadius: 16).fill(Color.gray.opacity(0.12)))
                    }
                    .buttonStyle(.plain)
                    .accessibilityIdentifier("demo-" + demo.id)
                }
            }
        }
    }

    private var playground: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("The Playground").font(.title2).bold()
            Text("Describe an app, and an agent writes the SwiftUI, compiles it to WebAssembly — in your browser — and runs it. Or open the editor and change this page: Run re-compiles it right here.")
                .foregroundColor(.secondary)
            HStack(spacing: 12) {
                Button { send("playground") } label: { Text("Open the Playground") }
                    .buttonStyle(.borderedProminent)
                Button { send("edit") } label: { Text("Edit this page") }
                    .buttonStyle(.bordered)
            }
        }
    }

    private var footer: some View {
        VStack(alignment: .leading, spacing: 6) {
            Divider()
            Text("Universal UI · SwiftUI reimplementation · wasm, Android, Linux, Windows, Apple")
                .font(.footnote).foregroundColor(.secondary)
        }
    }
}
