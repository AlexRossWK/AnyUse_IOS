//
//  AlertManager.swift
//  AlertManager
//
//  Created by Alexey Rossoshansky on 09.10.2020.
//

import UIKit

public protocol AlertManager {
    func showBanner(with notification: AlertModel)
    func dismissAll()
}

public class AlertManagerImplementation: AlertManager {
    private struct Constants {
        /// Минимальная задержка между двумя баннерами.
        static let throttleDelay: TimeInterval = 0.8
    }
    
    public init() {}
    
    weak var container: UIView? {
        didSet {
            animator.layoutContainer = container
        }
    }
    private let animator = Animator()
    /// Ссылка на текущий баннер, который видит пользователь.
    private weak var currentBanner: UIView?
    
    /// Throttling
    /// В этой очереди скапливаются все входящие алерты, а затем показываются поочереди.
    private var inputStack = [AlertModel]()
    /// Не дает баннерам показываться чаще чем один раз в Constants.throttleDelay секунд.
    private var throttleTimer: Timer!
    /// Баннер автоматически исчезает после Constants.dismissDelay секунд.
    private var dismissTimer: Timer?
    
    // MARK: - Public Interface
    public func dismissAll() {
        dismissCurrentBanner()
    }
    
    public func showBanner(with notification: AlertModel) {
        if inputStack.isEmpty {
            animateIn(notification)
        }
        
        inputStack.append(notification)
        
        guard let timer = throttleTimer, timer.isValid else {
            self.throttleTimer = createThrottleTimer()
            return
        }
    }
    
    // MARK: - Private Methods
    private func createThrottleTimer() -> Timer {
        let timer = Timer(timeInterval: Constants.throttleDelay, target: self, selector: #selector(throttleTimerTick), userInfo: nil, repeats: true)
        timer.tolerance = 0.1
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
        return timer
    }
    
    private func updateDismissTimer(timeout: TimeInterval) {
        dismissTimer?.invalidate()
        let timer = Timer(timeInterval: timeout, target: self, selector: #selector(dismissTimerTick), userInfo: nil, repeats: false)
        timer.tolerance = 0.1
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
        dismissTimer = timer
    }
    
    @objc func dismissTimerTick() {
        dismissCurrentBanner()
    }
    
    private func dismissCurrentBanner() {
        if animator.isAnimatingPan {
            animator.dismissWhenAvailable()
        } else {
            animator.animateDismiss(currentBanner)
        }
    }
    
    @objc func throttleTimerTick() {
        guard !inputStack.isEmpty else {
            stop()
            return
        }
        
        inputStack.removeFirst()
        
        if let first = inputStack.first {
            animateIn(first)
        } else {
            stop()
        }
    }
    
    private func stop() {
        throttleTimer.invalidate()
    }
    
    private func animateIn(_ model: AlertModel) {
        let newBanner = BannerView(.init(body: model.body, color:color(for: model.style)))
        newBanner.action = { [weak self, weak newBanner] in
            self?.animator.animateTap(newBanner)
            model.action?()
        }
        animator.animateTransition(from: currentBanner, to: newBanner)
        currentBanner = newBanner
        updateDismissTimer(timeout: model.timeout ?? timeout(for: model.style))
        
        newBanner.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(swipeAction)))
    }
    
    @objc func swipeAction(sender: UIPanGestureRecognizer) {
        animator.animatePan(with: sender)
    }
    
    private func timeout(for style: AlertModel.Style) -> TimeInterval {
        switch style {
        case .info:
            return 10
        case .error:
            return 5
        case .success:
            return 5
        }
    }
    
    private func color(for style: AlertModel.Style) -> UIColor {
        switch style {
        case .info:
            return UIColor.darkGray
        case .error:
            return UIColor.red
        case .success:
            return UIColor.green
        }
    }
}
