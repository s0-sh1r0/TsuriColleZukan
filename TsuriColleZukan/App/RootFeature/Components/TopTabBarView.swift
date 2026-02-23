import SwiftUI

struct TopTabBarView: View {
    @Binding var selectedTab: AppTab
    let onPlusTapped: () -> Void

    private let fabSize: CGFloat = 60

    var body: some View {
        ZStack {
            TabBarShape()
                .fill(.ultraThinMaterial)
                .shadow(radius: 8)

            HStack {
                tabButton(
                    title: "ホーム",
                    selectedImage: "house.fill",
                    normalImage: "house",
                    isSelected: selectedTab == .home
                ) {
                    selectedTab = .home
                }

                Spacer()
                Spacer().frame(width: fabSize + 16)

                tabButton(
                    title: "図鑑",
                    selectedImage: "fish.circle.fill",
                    normalImage: "fish.circle",
                    isSelected: selectedTab == .plan
                ) {
                    selectedTab = .plan
                }
            }
            .padding(.horizontal, 28)
            .frame(height: 60)

            TabBarPlusButtonView {
                onPlusTapped()
            }
            .offset(y: -30)
        }
        .frame(height: 60)
        .padding(.horizontal, 16)
        .padding(.bottom, 10)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }

    private func tabButton(
        title: String,
        selectedImage: String,
        normalImage: String,
        isSelected: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: isSelected ? selectedImage : normalImage)
                    .font(.system(size: 20, weight: .semibold))

                Text(title)
                    .font(.caption)
            }
            .foregroundStyle(isSelected ? Color.blue : Color.gray)
            .frame(maxWidth: .infinity)
        }
    }
}

struct TabBarShape: Shape {
    var notchRadius: CGFloat = 30
    var notchDepth: CGFloat = 20
    var cornerRadius: CGFloat = 24

    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height
        let centerX = w / 2

        let padding: CGFloat = 12

        let notchStartX = centerX - notchRadius - padding
        
        var p = Path()

        // 左上から
        p.move(to: CGPoint(x: cornerRadius, y: 0))

        // 上辺（左→凹み開始）
        p.addLine(to: CGPoint(x: notchStartX, y: 0))

        // ---- ここが円状の凹み（U字） ----
        p.addArc(
            center: CGPoint(x: centerX, y: 0),
            radius: notchRadius,
            startAngle: .degrees(180),
            endAngle: .degrees(0),
            clockwise: true
        )
        // ---------------------------------

        // 上辺（凹み終わり→右上角手前）
        p.addLine(to: CGPoint(x: w - cornerRadius, y: 0))

        // 右上角
        p.addQuadCurve(to: CGPoint(x: w, y: cornerRadius),
                       control: CGPoint(x: w, y: 0))

        // 右辺
        p.addLine(to: CGPoint(x: w, y: h - cornerRadius))

        // 右下角
        p.addQuadCurve(to: CGPoint(x: w - cornerRadius, y: h),
                       control: CGPoint(x: w, y: h))

        // 下辺
        p.addLine(to: CGPoint(x: cornerRadius, y: h))

        // 左下角
        p.addQuadCurve(to: CGPoint(x: 0, y: h - cornerRadius),
                       control: CGPoint(x: 0, y: h))

        // 左辺
        p.addLine(to: CGPoint(x: 0, y: cornerRadius))

        // 左上角
        p.addQuadCurve(to: CGPoint(x: cornerRadius, y: 0),
                       control: CGPoint(x: 0, y: 0))

        p.closeSubpath()
        return p
    }
}
