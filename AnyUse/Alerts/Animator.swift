//
//  Animator.swift
//  AlertManager
//
//  Created by Alexey Rossoshansky on 09.10.2020.
//

import UIKit

class Animator {
    private struct Constants {
        static let swapDuration: TimeInterval = 0.65
        static let timeoutDismissDuration: TimeInterval = 0.3
        static let tapDismissDuration: TimeInterval = 0.15
        static let horizontalMargin: CGFloat = 16
        static let topMargin: CGFloat = 12
    }
    
    weak var layoutContainer: UIView?
    private var dismissInProgress = false
    var isAnimatingPan: Bool = false
    private let panInProgressTransform = CGAffineTransform(scaleX: 0.98, y: 0.98)
    private var isDismissPending = false
    
    private var safeAreaTopInset: CGFloat { UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0 }
    
    func animateDismiss(_ viewToDismiss: UIView?) {
        guard let oldView = viewToDismiss else { return }
        dismissInProgress = true
        UIView.animate(withDuration: Constants.timeoutDismissDuration,
                       delay: 0,
                       options: [.curveEaseIn, .beginFromCurrentState],
                       animations: {
                        oldView.transform = self.transform(for: oldView)
                       },
                       completion: { _ in
                        self.dismissInProgress = false
                        oldView.removeFromSuperview()
                       })
    }
    
    func animateTap(_ tappedView: UIView?) {
        guard !dismissInProgress, let view = tappedView else { return }
        dismissInProgress = true
        UIView.animate(withDuration: Constants.tapDismissDuration,
                       delay: 0,
                       options: [.curveEaseIn, .beginFromCurrentState],
                       animations: {
                        view.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
                        view.alpha = 0
                       },
                       completion: { _ in
                        self.dismissInProgress = false
                        view.removeFromSuperview()
                       })
    }
    
    func animatePan(with gesture: UIPanGestureRecognizer) {
        guard let view = gesture.view else { return }
        
        switch gesture.state {
        case .began:
            isAnimatingPan = true
            UIView.animate(withDuration: 0.25) {
                view.transform = self.panInProgressTransform
            }
        case .changed:
            let translation = gesture.translation(in: layoutContainer)
            let y: CGFloat = translation.y < 0 ? translation.y : sqrt(translation.y)
            view.transform = panInProgressTransform.translatedBy(x: 0, y: y)
        case .ended, .cancelled, .failed:
            
            if gesture.velocity(in: layoutContainer).y < 0 {
                let velocity = min(1, abs(gesture.velocity(in: layoutContainer).y / self.translation(for: view)))
                animateSwipeAway(with: view, initialVelocity: velocity)
            } else {
                animateSnapToInitialPosition(view)
            }

        default: ()
        }
    }
    
    private func animateSwipeAway(with view: UIView?, initialVelocity: CGFloat) {
        print(initialVelocity)
        guard let view = view else { return }
        dismissInProgress = true
        UIView.animate(withDuration: 0.45,
                       delay: 0,
                       usingSpringWithDamping: 0.75,
                       initialSpringVelocity: initialVelocity,
                       options: [.beginFromCurrentState, .curveEaseIn],
                       animations: {
                        self.dismissInProgress = false
                        view.transform = self.transform(for: view)
                       },
                       completion: { _ in
                        view.removeFromSuperview()
                        self.isAnimatingPan = false
                        self.checkForPendingDismiss(for: view)
                       })
        }
    
    private func animateSnapToInitialPosition(_ view: UIView?) {
        UIView.animate(withDuration: 0.35,
                       delay: 0,
                       usingSpringWithDamping: 0.75,
                       initialSpringVelocity: 0,
                       options: [.beginFromCurrentState, .curveEaseInOut, .allowUserInteraction],
                       animations: {
                        view?.transform = .identity
                       },
                       completion: { _ in
                        self.isAnimatingPan = false
                        self.checkForPendingDismiss(for: view)
                       })
    }
    
    private func checkForPendingDismiss(for view: UIView?) {
        if isDismissPending {
            isDismissPending = false
            animateDismiss(view)
        }
    }
    
    func dismissWhenAvailable() {
        isDismissPending = true
    }
    
    func animateTransition(from oldView: UIView?, to newView: UIView) {
        guard let container = layoutContainer else { return }
        
        layoutContainer?.addSubview(newView)
        newView.translatesAutoresizingMaskIntoConstraints = false
        newView.leftAnchor.constraint(equalTo: container.leftAnchor, constant: Constants.horizontalMargin).isActive = true
        newView.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -Constants.horizontalMargin).isActive = true
        newView.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: Constants.topMargin).isActive = true
        
        newView.transform = transform(for: newView)
        
        UIView.animate(withDuration: Constants.swapDuration,
                       delay: 0,
                       usingSpringWithDamping: 0.85,
                       initialSpringVelocity: 0,
                       options: [.curveEaseInOut, .beginFromCurrentState, .allowUserInteraction],
                       animations: {
                        newView.transform = .identity
                        if !self.dismissInProgress {
                            oldView?.transform = CGAffineTransform(scaleX: 0.65, y: 0.65).concatenating(.init(translationX: 0, y: -10))
                            oldView?.alpha = 0
                        }
                       },
                       completion: { _ in
                        oldView?.removeFromSuperview()
                       })
    }
    
    private func transform(for view: UIView) -> CGAffineTransform {
        CGAffineTransform(translationX: 0, y: translation(for: view))
    }
    
    private func translation(for view: UIView) -> CGFloat {
        -(height(for: view) + Constants.topMargin + safeAreaTopInset)
    }
    
    private func height(for view: UIView) -> CGFloat {
        view.layoutIfNeeded()
        let targetSize = CGSize(width: UIScreen.main.bounds.width - Constants.horizontalMargin * 2, height: 0)
        return view.systemLayoutSizeFitting(targetSize,
                                            withHorizontalFittingPriority: .required,
                                            verticalFittingPriority: .defaultLow).height
    }
}
