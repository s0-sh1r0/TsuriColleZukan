import SwiftUI
import ComposableArchitecture

@main
struct TsuriColleZukanApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(
                store: Store(
                    initialState: RootFeature.State(),
                    reducer: { RootFeature() }
                )
            )
        }
    }
}
