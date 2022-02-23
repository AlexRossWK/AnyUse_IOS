//
//  Notification.swift
//  AlertManager
//
//  Created by Alexey Rossoshansky on 09.10.2020.
//

import UIKit

public struct AlertModel {
    public typealias Action = () -> Void
    
    public enum Style {
        case info
        case error
        case success
    }
    
    let timeout: TimeInterval?
    let body: NSAttributedString
    let style: Style
    let action: Action?
    private static let defaultAttributes = [NSAttributedString.Key: Any]()
    
    public init(attributedText: NSAttributedString, style: Style = .error, action: Action? = nil, timeout: TimeInterval? = nil) {
        self.body = attributedText
        self.style = style
        self.action = action
        self.timeout = timeout
    }
    
    public init(text: String, style: Style = .error, action: Action? = nil, timeout: TimeInterval? = nil) {
        self.init(attributedText: NSAttributedString(string: text, attributes: Self.defaultAttributes), style: style, action: action, timeout: timeout)
    }
    
    public init(error: Swift.Error) {
        var attributedString: NSMutableAttributedString
        if let error = error as? LocalizedError {
            attributedString = NSMutableAttributedString(string: error.errorDescription ?? error.localizedDescription, attributes: Self.defaultAttributes)
        } else {
            attributedString = NSMutableAttributedString(string: error.localizedDescription, attributes: Self.defaultAttributes)
        }
        self.init(attributedText: attributedString, style: .error)
    }
}
