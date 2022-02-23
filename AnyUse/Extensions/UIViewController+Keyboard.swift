//
//  UIViewController+Keyboard.swift
//  AnyUse
//
//  Created by Алексей on 22..022022.
//

import UIKit

struct KeyboardUpdate {
    let height: CGFloat
    let animationDuration: TimeInterval
    let options: UIView.AnimationOptions
    let isShow: Bool
}


protocol ViewControllerWithKeyboard {
    var isKeyboardOnScreen: Bool { get set }
    func handleKeyboard(update: KeyboardUpdate, animated: Bool)
}


extension UIViewController {
    
    func observeKeyboard() {
        guard self is ViewControllerWithKeyboard else {
            fatalError("You should use ViewControllerWithKeyboard protocol for ViewControllers that are trying to handle keyboard events")
        }
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(
            self,
            selector: #selector(handleKeyboardWillChangeFrame(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        notificationCenter.addObserver(
            self,
            selector: #selector(handleKeyboardWillChangeFrame(notification:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil)
        
        notificationCenter.addObserver(
            self,
            selector: #selector(handleKeyboardWillChangeFrame(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    @objc private func handleKeyboardWillChangeFrame(notification: Notification) {
        guard var handlerViewController = self as? ViewControllerWithKeyboard else { return }
        
        switch notification.name {
        case UIResponder.keyboardWillShowNotification:
            handlerViewController.isKeyboardOnScreen = true
        case UIResponder.keyboardWillHideNotification:
            handlerViewController.isKeyboardOnScreen = false
        case UIResponder.keyboardWillChangeFrameNotification:
            if !handlerViewController.isKeyboardOnScreen { return }
        default: break
        }
        
        print("\(handlerViewController.isKeyboardOnScreen) -- \(notification.name)")
        
        let userInfo = notification.userInfo!
        
        let keyboardHeight =
            notification.name == UIResponder.keyboardWillHideNotification ? 0 :
                (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        
        let animationDuration =
            userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        let rawAnimationCurve =
            userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        
        let keyboardUpdate = KeyboardUpdate(height: keyboardHeight,
                                            animationDuration: animationDuration,
                                            options: UIView.AnimationOptions(rawValue: rawAnimationCurve),
                                            isShow: notification.name == UIResponder.keyboardWillShowNotification)
        
        handlerViewController.handleKeyboard(update: keyboardUpdate, animated: isBeingPresented)
    }
    
}

