//
//  HTTPCode.swift
//  EasyBreezy
//
//  Created by Phanvit Chevamongkolnimit on 23/3/2568 BE.
//

typealias HTTPCode = Int
typealias HTTPCodeRange = Range<HTTPCode>

extension HTTPCodeRange {
    static let success: HTTPCodeRange = 200..<300
}
