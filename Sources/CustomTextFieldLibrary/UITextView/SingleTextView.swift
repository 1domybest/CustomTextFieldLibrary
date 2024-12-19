import Foundation
import UIKit
import SnapKit

public class SingleTextView: UITextView {

    public var singleTextViewOption: SingleTextViewOption
    public var placeholderLabel: UILabel?

    override public var intrinsicContentSize: CGSize {
        let maxHeight: CGFloat = singleTextViewOption.maxHeight
        let minHeight: CGFloat = singleTextViewOption.minHeight
        let calculatedHeight = max(min(contentSize.height, maxHeight), minHeight)
        return CGSize(width: UIView.noIntrinsicMetric, height: calculatedHeight)
    }
    
    public init(options: SingleTextViewOption) {
        self.singleTextViewOption = options
        super.init(frame: .zero, textContainer: nil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        self.singleTextViewOption = SingleTextViewOption()
        super.init(coder: aDecoder)
        setup()
    }

    deinit {
        print("SingleTextView deinit")
    }
    
    public func unreference () {
        
    }
    
    public func setup() {
        // Customize appearance
        self.textContainer.lineBreakMode = .byCharWrapping

        self.backgroundColor = self.singleTextViewOption.backgroundColor
        self.textColor = self.singleTextViewOption.textColor
        self.font = self.singleTextViewOption.font
        self.enablesReturnKeyAutomatically = self.singleTextViewOption.enablesReturnKeyAutomatically
        self.keyboardType = self.singleTextViewOption.keyboardType
        self.returnKeyType = self.singleTextViewOption.returnKeyType
        
        if self.singleTextViewOption.borderWidth > 0 {
            self.layer.borderWidth = self.singleTextViewOption.borderWidth
            self.layer.borderColor = self.singleTextViewOption.borderColor.cgColor
            self.layer.cornerRadius = self.singleTextViewOption.borderCornerRadius
        }
        
        
        self.showsVerticalScrollIndicator = self.singleTextViewOption.showIndicator
        self.showsHorizontalScrollIndicator = self.singleTextViewOption.showIndicator
        
        self.textContainerInset = UIEdgeInsets(top: self.singleTextViewOption.verticalPadding,
                                               left: self.singleTextViewOption.horizontalPadding, bottom: self.singleTextViewOption.verticalPadding, right: self.singleTextViewOption.horizontalPadding)
        // Setup placeholder
        setupPlaceholder()

        // Setup UITextView delegate
        self.delegate = self
        
        
     }


    public func setupPlaceholder() {
        // Initialize the placeholder label
        placeholderLabel = UILabel()
        placeholderLabel?.text = self.singleTextViewOption.placeholder
        placeholderLabel?.textColor = self.singleTextViewOption.placeholderColor
        placeholderLabel?.font = self.singleTextViewOption.font
        placeholderLabel?.numberOfLines = 0
        placeholderLabel?.translatesAutoresizingMaskIntoConstraints = false

        if let placeholderLabel = placeholderLabel {
            self.addSubview(placeholderLabel)
            
            // Use SnapKit to add constraints
            placeholderLabel.snp.makeConstraints { make in
                make.leading.equalTo(self.snp.leading)
                    .offset(self.textContainerInset.left + 6)
                make.top.equalTo(self.snp.top)
                    .offset(self.textContainerInset.top)
                make.trailing.equalTo(self.snp.trailing)
                    .offset(-self.textContainerInset.right)
                make.bottom.equalTo(self.snp.bottom).offset(-self.textContainerInset.bottom)
            }
            
            self.sendSubviewToBack(placeholderLabel)
        }

        // Update placeholder visibility
        updatePlaceholderVisibility()
    }

    public func updatePlaceholderVisibility() {
        placeholderLabel?.isHidden = !self.text.isEmpty
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        // Ensure placeholder label frame is updated
        updatePlaceholderVisibility()
    }

    public func activate() {
        // Make the text view the first responder
        self.becomeFirstResponder()
    }

    public func deactivate() {
        // Resign the text view from being the first responder
        self.resignFirstResponder()
    }

    public func checkRegexPattern(text: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", self.singleTextViewOption.regexPattern)
        return predicate.evaluate(with: text)
    }

    public func checkMaximumLength(text: String) -> Bool {
        if self.singleTextViewOption.maximunLenght == .zero {
            return true
        }
        if self.singleTextViewOption.maximunLenght >= text.count {
            return true
        } else {
            self.singleTextViewOption.onMaximumLength(text)
            return false
        }
    }

    public func isValidInput(text: String) -> Bool {
        if self.checkMaximumLength(text: text) {
            if self.singleTextViewOption.regexPattern != "" {
                if self.checkRegexPattern(text: text) {
                    // 정규식 O
                    return true
                } else {
                    // 정규식 X
                    self.singleTextViewOption.onFailedRegexPattern(text, self.singleTextViewOption.regexPatternName)
                    return false
                }
            } else {
                return true
            }
        } else {
            return false
        }
    }
}

extension SingleTextView: UITextViewDelegate {

    public func textViewDidChange(_ textView: UITextView) {
        self.singleTextViewOption.onTextChanged(textView.text)
        updatePlaceholderVisibility()
    }

    public func textViewDidBeginEditing(_ textView: UITextView) {
        self.singleTextViewOption.didBeginEditing(textView.text ?? "")
    }

    public func textViewDidEndEditing(_ textView: UITextView) {
        self.singleTextViewOption.didEndEditing(textView.text ?? "")
    }

    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        if text == UIPasteboard.general.string {
            if self.singleTextViewOption.maximunLenght != .zero {
                let truncatedText = String(newText.prefix(self.singleTextViewOption.maximunLenght)) // 글자 수를 초과하면 자름
                self.text = truncatedText
                self.singleTextViewOption.onTextChanged(truncatedText)
            } else {
                self.singleTextViewOption.onTextChanged(newText)
            }
            
            return false
        }
        
        let result = isValidInput(text: newText)
        if result {
            self.singleTextViewOption.onTextChanged(newText)
        }

        return result
    }
}
