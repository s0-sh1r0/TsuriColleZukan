import SwiftUI
import ComposableArchitecture

struct RootView: View {
    let store: StoreOf<RootFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                Group {
                    switch viewStore.selectedTab {
                    case .home:
                        Color(.red).ignoresSafeArea()
                            .overlay(Text("Home").font(.title))
                    case .plan:
                        Color(.blue).ignoresSafeArea()
                            .overlay(Text("Plan").font(.title))
                    }
                }

                VStack {
                    Spacer()
                    
                    TopTabBarView (
                        selectedTab: viewStore.binding(
                            get: \.selectedTab,
                            send: { .tabSelected($0) }
                        ),
                        onPlusTapped: { viewStore.send(.plusTapped) }
                    )
                }
            }
            .sheet(
                isPresented: viewStore.binding(
                    get: \.showModal,
                    send: { .setModal(isPresented: $0) }
                )
            ) {
                Text("Create View")
                    .font(.title)
                    .presentationDetents([.medium, .large])
            }
        }
    }
}

#Preview {
    RootView(
        store: Store(
            initialState: RootFeature.State(),
            reducer: { RootFeature() }
        )
    )
}
