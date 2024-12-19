//
//  SingleTextViewOption.swift
//  HypyG
//
//  Created by 온석태 on 8/30/24.
//

import Foundation
import SwiftUI
import UIKit


public struct SingleTextViewOption {
    public var maximunLenght: Int = 0 // 글자 최대길이
    public var textColor: UIColor = .black // 텍스트컬러
    public var font: UIFont = UIFont.systemFont(ofSize: 14)
    public var backgroundColor: UIColor = .clear // 배경색
    public var regexPattern: String = ""
    public var regexPatternName: String = ""
    
    public var borderColor: UIColor = .clear // 보더 색상
    public var borderWidth:CGFloat = 0 // 보더 스타일
    public var borderCornerRadius:CGFloat = 0 // 보더 스타일
    
    public var placeholder:String = "" // 플레이스 홀더
    public var placeholderColor:UIColor = .gray // 플레이스 홀더
    
    public var horizontalPadding: Double = 10.0 // 왼쪽 텍스트필드와의 패딩
    public var verticalPadding: Double = 10.0 // 오른쪽 텍스트필드와의 패딩
    
    public var isShowReturnButton: Bool = true // return 버튼 노출유무
    public var isShowClearButton: Bool = false // clear (X) 버튼 노출유무
    
    public var enableAutoHeight: Bool = false
    public var minHeight: CGFloat = 50
    public var maxHeight: CGFloat = 200
    
    
    public var returnKeyType: UIReturnKeyType = .default
    public var keyboardType:UIKeyboardType = .default
    public var enablesReturnKeyAutomatically:Bool = false
    public var showIndicator:Bool = false
    
    // callback
    public var onTextChanged: (String) -> Void = { _ in } // 텍스트 변경되었을때
    public var didEndEditing: (String) -> Void  = { _ in } // 조작이 끝났을때
    public var didBeginEditing: (String) -> Void = { _ in } // 조작을 시작했을때
    public var onFailedRegexPattern: (String, String) -> Void  = { _ , _ in } // 조작을 시작했을때
    public var onMaximumLength: (String) -> Void = { _ in } // 조작을 시작했을때
    public var onChangeHeight: (CGFloat) -> Void = { _ in } // 텍스트 변경되었을때
    
    public init() {
        
    }
}
