import SwiftUI

struct CopyableValueRow: View {
    let label: String
    let value: String
    @State private var didCopy = false

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(label)
                .foregroundStyle(.secondary)
            Spacer(minLength: 12)
            Text(value)
                .fontWeight(.medium)
                .multilineTextAlignment(.trailing)
        }
        .font(.body)
        .contentShape(Rectangle())
        .contextMenu {
            Button("Copy") { copyValue() }
        }
        #if os(iOS)
        .onLongPressGesture(minimumDuration: 0.35) {
            copyValue()
        }
        #endif
        .overlay(alignment: .trailing) {
            Button {
                copyValue()
            } label: {
                Image(systemName: didCopy ? "checkmark.circle.fill" : "doc.on.doc")
                    .foregroundStyle(didCopy ? .green : .secondary)
            }
            .buttonStyle(.plain)
            .offset(x: 28)
            .opacity(0.85)
        }
        .padding(.trailing, 28)
    }

    private func copyValue() {
        Clipboard.copy(value)
        withAnimation(.easeInOut(duration: 0.2)) {
            didCopy = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            withAnimation { didCopy = false }
        }
    }
}
