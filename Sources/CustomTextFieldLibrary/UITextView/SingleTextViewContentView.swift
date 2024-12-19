//
//  SingleTextFieldContentView.swift
//  HypyG
//
//  Created by 온석태 on 8/30/24.
//

import Foundation
import UIKit
import SnapKit

class SingleTextViewContentView: UIView {
    
    public var textView: SingleTextView?
    
    public var textViewHeightConstraint: Constraint?
    
    public init(singleTextViewOption: SingleTextViewOption) {
        textView = SingleTextView(options: singleTextViewOption)
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        textView = SingleTextView(options: SingleTextViewOption())
        super.init(coder: aDecoder)
        setup()
    }
    
    deinit {
        print("SingleTextViewContentView deinit")
    }
    
    public func unreference () {
        self.textView?.unreference()
        self.textView = nil
        self.textViewHeightConstraint = nil
        
        guard let textView = textView else { return }
        
        if textView.singleTextViewOption.enableAutoHeight {
            textView.removeObserver(self, forKeyPath: "contentSize")
        }
    }
    
    public func setup() {
        guard let textView = textView else { return }
        self.addSubview(textView)

        // Configure Auto Layout for text view using SnapKit
        textView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            if textView.singleTextViewOption.enableAutoHeight {
                textViewHeightConstraint = make.height.equalTo(textView.intrinsicContentSize.height).constraint
            } else {
                make.height.equalTo(textView.singleTextViewOption.minHeight)
            }
        }
        
        if textView.singleTextViewOption.enableAutoHeight {
            textView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        }
        
        self.backgroundColor = .clear
      
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
           if keyPath == "contentSize" {
               DispatchQueue.main.async {
                   self.updateHeight()
               }
           }
       }
    
    public func updateHeight() {
        guard let textView = textView else { return }
        // 텍스트 뷰의 콘텐츠 높이를 계산합니다.
        let contentHeight = textView.intrinsicContentSize.height
        
        // 높이 제약 조건을 업데이트합니다.
        textViewHeightConstraint?.update(offset: contentHeight)
        
        // 레이아웃을 강제로 갱신하여 변경 사항을 반영합니다.
        self.layoutIfNeeded()
        
        // 텍스트 뷰의 높이가 변경된 후에 실행될 필요가 있는 추가 작업을 수행합니다.
        textView.singleTextViewOption.onChangeHeight(contentHeight)
    }
    
    public func setText(text: String) {
        guard let textView = textView else { return }
        textView.text = text
        textView.singleTextViewOption.onTextChanged(text)
    }
    
  
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    public func activate () {
        guard let textView = textView else { return }
        textView.activate()
    }
    
    public func deactivate () {
        guard let textView = textView else { return }
        textView.deactivate()
    }
    
    public func setEditable(isEditable: Bool) {
        guard let textView = textView else { return }
        textView.isEditable = isEditable
    }
}
