import SwiftUI

struct TabBarPlusButtonView: View {
    let systemName: String
    let size: CGFloat
    let iconSize: CGFloat
    let action: () -> Void

    init(
        systemName: String = "plus",
        size: CGFloat = 45,
        iconSize: CGFloat = 22,
        action: @escaping () -> Void
    ) {
        self.systemName = systemName
        self.size = size
        self.iconSize = iconSize
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: iconSize, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: size, height: size)
                .background(Color.blue)
                .clipShape(Circle())
                .shadow(radius: 8)
        }
    }
}
