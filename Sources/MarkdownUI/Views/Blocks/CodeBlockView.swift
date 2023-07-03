import SwiftUI

struct CodeBlockView: View {
    @Environment(\.theme.codeBlock) private var codeBlock
    @Environment(\.codeSyntaxHighlighter) private var codeSyntaxHighlighter
    
    @State private var showFullscreen: Bool = false
    
    private let fenceInfo: String?
    private let content: String
    
    init(fenceInfo: String?, content: String) {
        self.fenceInfo = fenceInfo
        self.content = content.hasSuffix("\n") ? String(content.dropLast()) : content
    }
    
    var body: some View {
        VStack {
            codeSyntaxHighlighter
                .codeView(self.content, language: self.fenceInfo)
        }
        .sheet(isPresented: $showFullscreen) {
            codeSyntaxHighlighter.fullscreenView(self.content, language: self.fenceInfo)
        }
        .onTapGesture {
            showFullscreen = true
        }
    }
    
    private var label: some View {
        self.codeSyntaxHighlighter.codeView(self.content, language: self.fenceInfo)
            .textStyleFont()
            .textStyleForegroundColor()
    }
}
