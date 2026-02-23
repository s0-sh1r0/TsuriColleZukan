import SwiftUI
import ComposableArchitecture

enum AppTab: Equatable {
    case home
    case plan
}

@Reducer
nonisolated struct RootFeature {
    @ObservableState
    struct State: Equatable {
        var selectedTab: AppTab = .home
        var showModal: Bool = false
    }

    enum Action: Equatable {
        case tabSelected(AppTab)
        case plusTapped
        case setModal(isPresented: Bool)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .tabSelected(tab):
                state.selectedTab = tab
                return .none

            case .plusTapped:
                state.showModal = true
                return .none

            case let .setModal(isPresented):
                state.showModal = isPresented
                return .none
            }
        }
    }
}
