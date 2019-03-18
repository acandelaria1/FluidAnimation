//
//  Fluid.swift
//  FluidAnimation
//
//  Created by Alexis Candelaria on 3/18/19.
//  Copyright © 2019 Alexis Candelaria. All rights reserved.
//

import UIKit

fileprivate struct FluidAnimation {
    let duration: TimeInterval
    let animations: () -> Void
    let completion: ((Bool) -> ())?
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
        UIView.animate(withDuration: animation.duration, animations: animation.animations) { [weak self] _ in
            self?.chainAnimations()
        }
    }
}

class Fluid {
    
    @discardableResult func animate(duration: TimeInterval, animation: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) -> Fluid {
        let animation = FluidAnimation(duration: duration, animations: animation, completion: completion)
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
