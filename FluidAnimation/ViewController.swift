//
//  ViewController.swift
//  FluidAnimation
//
//  Created by Alexis Candelaria on 3/13/19.
//  Copyright © 2019 Alexis Candelaria. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var circle: UIView = {
        let circle = UIView()
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.backgroundColor = .red
        NSLayoutConstraint.activate([
            circle.widthAnchor.constraint(equalToConstant: 80),
            circle.heightAnchor.constraint(equalToConstant: 80)
            ])
        circle.layer.cornerRadius = 40
        return circle
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        view.addSubview(circle)
        NSLayoutConstraint.activate([
            circle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circle.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        UIView.fluidly.animate(duration: 0.3, animation: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.circle.transform = strongSelf.circle.transform.concatenating(CGAffineTransform(translationX: 0, y: 200))
        }).animate(duration: 0.3, animation: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.circle.transform = strongSelf.circle.transform.concatenating(CGAffineTransform(translationX: 100, y: 0))
        }).animate(duration: 0.3, animation: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.circle.transform = strongSelf.circle.transform.concatenating(CGAffineTransform(translationX: 0, y: -100))
        }).start()
    }
}
