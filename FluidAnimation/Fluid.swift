//
//  Fluid.swift
//  FluidAnimation
//
//  Created by Alexis Candelaria on 3/18/19.
//  Copyright © 2019 Alexis Candelaria. All rights reserved.
//

import UIKit

fileprivate enum FluidAnimation {
    case spring(duration: TimeInterval, delay: TimeInterval, damping: CGFloat, initialSpringVelocity: CGFloat, options: UIView.AnimationOptions, animations: () -> Void, completion: (()->Void)?)
    case normal(duration: TimeInterval, animations: () -> Void, completion: (() -> Void)?)
}

fileprivate class FluidFactory {
    
    fileprivate var animations: [FluidAnimation] = []
    
    static let shared = FluidFactory()
    
    private init() {}
    
    fileprivate func add(animation: FluidAnimation) {
        animations.append(animation)
    }
    
    func chainAnimations() {
        guard !animations.isEmpty else { return }
        let animation = animations.removeFirst()
        switch animation {
        case .spring(duration: let duration, delay: let delay, damping: let damping, initialSpringVelocity: let springVelocity, options: let options, animations: let animations, completion: let completion):
            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: springVelocity, options: options, animations: animations, completion: { [weak self] _ in
                completion?()
                self?.chainAnimations()
            })
        case .normal(duration: let duration, animations: let animations, completion: let completion):
            UIView.animate(withDuration: duration, animations: animations) { [weak self] _ in
                completion?()
                self?.chainAnimations()
            }
        }
    }
}

class Fluid {
    
    @discardableResult func animateWithSpring(duration: TimeInterval, delay: TimeInterval, damping: CGFloat, springVelocity: CGFloat, options: UIView.AnimationOptions, animations: @escaping () -> Void, completion: (() -> Void)?) -> Fluid {
        let animation = FluidAnimation.spring(duration: duration, delay: delay, damping: damping, initialSpringVelocity: springVelocity, options: options, animations: animations, completion: completion)
        FluidFactory.shared.add(animation: animation)
        return self
    }
    
    @discardableResult func animate(duration: TimeInterval, animations: @escaping () -> Void, completion: (() -> Void)?) -> Fluid {
        let animation = FluidAnimation.normal(duration: duration, animations: animations, completion: completion)
        FluidFactory.shared.add(animation: animation)
        return self
    }
    
    @discardableResult func start() -> Fluid {
        FluidFactory.shared.chainAnimations()
        return self
    }
}

extension UIView {
    
    static var fluidly: Fluid {
        return Fluid()
    }
    
}
