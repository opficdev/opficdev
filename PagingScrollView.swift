import SwiftUI

struct PagingScrollView<Content: View>: UIViewRepresentable {
    let pageCount: Int
    let content: () -> Content

    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        return scrollView
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {
        if uiView.subviews.isEmpty {
            let hostingController = UIHostingController(rootView: content())
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            uiView.addSubview(hostingController.view)

            NSLayoutConstraint.activate([
                hostingController.view.topAnchor.constraint(equalTo: uiView.topAnchor),
                hostingController.view.bottomAnchor.constraint(equalTo: uiView.bottomAnchor),
                hostingController.view.leadingAnchor.constraint(equalTo: uiView.leadingAnchor),
                hostingController.view.trailingAnchor.constraint(equalTo: uiView.trailingAnchor),
                hostingController.view.heightAnchor.constraint(equalTo: uiView.heightAnchor),
                hostingController.view.widthAnchor.constraint(
                    equalTo: uiView.widthAnchor,
                    multiplier: CGFloat(pageCount) // 페이지 수만큼 확장
                )
            ])
        }
    }
}
