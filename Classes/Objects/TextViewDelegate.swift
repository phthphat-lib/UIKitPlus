import UIKit

class TextViewDelegate: NSObject, UITextViewDelegate {
    let textView: TextView
    
    init (_ textView: TextView) {
        self.textView = textView
    }
    
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.textView.shouldBeginEditingHandler?() ?? self.textView.shouldBeginEditingHandlerText?(self.textView) ?? true
    }

    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        self.textView.shouldEndEditingHandler?()
            ?? self.textView.shouldEndEditingHandlerText?(self.textView)
            ?? true
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if self.textView.attributedText == self.textView.generatedPlaceholderString {
            self.textView.text = ""
        }
        self.textView.didBeginEditingHandler?()
        self.textView.didBeginEditingHandlerText?(self.textView)
    }

    public func textViewDidEndEditing(_ textView: UITextView) {
        if self.textView.text.count == 0, let text = self.textView.placeholderText {
            self.textView.attributedText = self.textView._generatePlaceholderAttributedString(with: text)
        }
        self.textView.didEndEditingHandler?()
        self.textView.didEndEditingHandlerText?(self.textView)
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        self.textView.shouldChangeTextHandler?()
            ?? self.textView.shouldChangeTextHandlerText?(self.textView)
            ?? self.textView.shouldChangeTextHandlerTextRangeString?(self.textView, range, text)
            ?? self.textView.shouldChangeTextHandlerRangeString?(range, text)
            ?? true
    }

    public func textViewDidChange(_ textView: UITextView) {
        self.textView.didChangeTextHandler?()
        self.textView.didChangeTextHandlerText?(self.textView)
        if self.textView.text.count > 0 {
            self.textView.binding?.wrappedValue = self.textView.text
        } else if self.textView.attributedText.string.count > 0 {
            self.textView.binding?.wrappedValue = self.textView.attributedText.string
        } else {
            self.textView.binding?.wrappedValue = ""
        }
    }
    
    public func textViewDidChangeSelection(_ textView: UITextView) {
        self.textView.didChangeSelectionHandler?()
        self.textView.didChangeSelectionHandlerText?(self.textView)
    }

    @available(iOS 10.0, *)
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        let bool1 = self.textView.shouldInteractWithURLHandler?()
        let bool2 = self.textView.shouldInteractWithURLHandlerText?(self.textView)
        let bool3 = self.textView.shouldInteractWithURLHandlerURLRange?(self.textView, URL, characterRange)
        let bool4 = self.textView.shouldInteractWithURLHandlerURLRangeInteraction?(self.textView, URL, characterRange, .from(interaction))
        return bool1 ?? bool2 ?? bool3 ?? bool4 ?? true
    }

    @available(iOS 10.0, *)
    public func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        let bool1 = self.textView.shouldInteractWithTextAttachmentHandler?()
        let bool2 = self.textView.shouldInteractWithTextAttachmentHandlerText?(self.textView)
        let bool3 = self.textView.shouldInteractWithTextAttachmentHandlerRange?(self.textView, textAttachment, characterRange)
        let bool4 = self.textView.shouldInteractWithTextAttachmentHandlerRangeInteraction?(self.textView, textAttachment, characterRange, .from(interaction))
        return bool1 ?? bool2 ?? bool3 ?? bool4 ?? true
    }

    
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        let bool1 = self.textView.shouldInteractWithURLHandler?()
        let bool2 = self.textView.shouldInteractWithURLHandlerText?(self.textView)
        let bool3 = self.textView.shouldInteractWithURLHandlerURLRange?(self.textView, URL, characterRange)
        let bool4 = self.textView.shouldInteractWithURLHandlerURLRangeInteraction?(self.textView, URL, characterRange, .invokeDefaultAction)
        return bool1 ?? bool2 ?? bool3 ?? bool4 ?? true
    }

    public func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange) -> Bool {
        let bool1 = self.textView.shouldInteractWithTextAttachmentHandler?()
        let bool2 = self.textView.shouldInteractWithTextAttachmentHandlerText?(self.textView)
        let bool3 = self.textView.shouldInteractWithTextAttachmentHandlerRange?(self.textView, textAttachment, characterRange)
        let bool4 = self.textView.shouldInteractWithTextAttachmentHandlerRangeInteraction?(self.textView, textAttachment, characterRange, .invokeDefaultAction)
        return bool1 ?? bool2 ?? bool3 ?? bool4 ?? true
    }
}