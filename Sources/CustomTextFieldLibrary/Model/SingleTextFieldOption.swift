//
//  TextFieldModel.swift
//  HypyG
//
//  Created by 온석태 on 8/30/24.
//

import Foundation
import SwiftUI
import UIKit
import Kingfisher


public struct SingleTextFieldOption {
    public var maximunLenght: Int = 0 // 글자 최대길이
    public var textColor: UIColor = .black // 텍스트컬러
    public var font: UIFont = UIFont.systemFont(ofSize: 14)
    public var backgroundColor: UIColor = .white // 배경색
    public var regexPattern: String = ""
    public var regexPatternName: String = ""
    
    public var customHeight: CGFloat? = nil // 텍스트필드 높이
    public var customCornerRadius: CGFloat? = nil // 보더 radius (보더 스타일 roundedRect)
    public var borderWidth: CGFloat? = nil // 보더 두께
    
    public var borderColor: UIColor = .clear // 보더 색상
    public var borderStyle:UITextField.BorderStyle = .none // 보더 스타일
    
    public var placeholder:String = "" // 플레이스 홀더
    public var placeholderColor:UIColor = .gray // 플레이스 홀더
    
    public var leftViewImage: UIImage? = nil // 왼쪽 아이콘
    public var rightViewImage: UIImage? = nil // 오른쪽 아이콘
    
    public var leftImageSize: Double = 20.0 // 왼쪽 아이콘
    public var rightImageSize: Double = 20.0 // 오른쪽 아이콘
    
    public var leftPadding: Double = 5.0 // 왼쪽 텍스트필드와의 패딩
    public var rightPadding: Double = 5.0 // 오른쪽 텍스트필드와의 패딩
    
    public var claerViewMode:UITextField.ViewMode = .never // 왼쪽 아이콘 노출 조건
    
    public var leftViewMode:UITextField.ViewMode = .always // 왼쪽 아이콘 노출 조건
    public var rightViewMode:UITextField.ViewMode = .always // 오른쪽 아이콘 노출 조건

    
    public var returnKeyType: UIReturnKeyType = .default
    public var keyboardType:UIKeyboardType = .default
    public var enablesReturnKeyAutomatically:Bool = false
    public var showIndicator:Bool = false
    
    // callback
    public var onTextChanged: (String) -> Void = { _ in } // 텍스트 변경되었을때
    public var didEndEditing: (String, UITextField.DidEndEditingReason?) -> Void  = { _,_ in } // 조작이 끝났을때
    public var didBeginEditing: (String) -> Void = { _ in } // 조작을 시작했을때
    public var onFailedRegexPattern: (String, String) -> Void  = { _ , _ in } // 정규식 패턴과 일치하지 않을때
    public var onMaximumLength: (String) -> Void = { _ in } // 조작을 시작했을때
    public var onEnterReturnButton: (String) -> Void = { _ in } // 조작을 시작했을때
    
    
    public init() {
        
    }
    
    
}



