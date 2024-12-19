//
//  RegexPatternEnum.swift
//  HypyG
//
//  Created by 온석태 on 8/30/24.
//

import Foundation

public enum RegexPattern: String {
    case onlyEnAndJa = "^[a-zA-Z0-9ぁ-んァ-ン一-龯々〆〤!@#$%^&*()_+{}\\[\\]:;\"'<>,.?/~`\\\\|/\\-]*$"
    case profileName = "^[a-zA-Zぁ-ゔァ-ヴー々〆〤一-龥]*$"
    case onlyNumberAndSpecial = "^[0-9!@#₩$%^&*()-_+=,.<>?/:;{}~`]*$" // 숫자와 특수문자만
    case onlyNumber = "^[0-9]*$" // 숫자만
    case none = "none"
}
