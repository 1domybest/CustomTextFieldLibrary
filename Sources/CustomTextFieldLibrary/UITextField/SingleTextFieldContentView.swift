//
//  SingleTextFieldContentView.swift
//  HypyG
//
//  Created by 온석태 on 8/30/24.
//

import Foundation
import UIKit

public class SingleTextFieldContentView: UIView {
    
    private var textField: SingleTextField
    
    public init(singleTextFieldOption: SingleTextFieldOption) {
        textField = SingleTextField(options: singleTextFieldOption)
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        textField = SingleTextField(options: SingleTextFieldOption())
        super.init(coder: aDecoder)
        setup()
    }
    
    deinit {
        print("SingleTextFieldContentView deinit")
    }
    
    public func setup() {
        // Add the text field to the view
        self.addSubview(textField)
        
        // Configure Auto Layout for text field using SnapKit
        textField.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
//            make.center.equalToSuperview()
        }
        self.backgroundColor = .clear
    }
    
    public func setText(text:String) {
        self.textField.setText(text: text)
    }
    
    public func activate () {
        self.textField.activate()
    }
    
    public func deactivate () {
        self.textField.deactivate()
    }
    
    // 텍스트 필드 접근 가능 / 불가능
    public func setEnabled(isEnabled: Bool, backgroundColor: UIColor = .clear) {
        self.textField.isEnabled = isEnabled
        self.textField.backgroundColor = backgroundColor
    }
}
