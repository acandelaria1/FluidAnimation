FluidAnimation is an animation library that provides a **fluid interface** around chaining complex iOS animations.
 
<p align="center">
    <a href="#quickstart">Quick Start</a>
    <a href="#installation">Installation</a>
</p>


### Before

```swift

UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.circle.transform = strongSelf.circle.transform.concatenating(CGAffineTransform(translationX: 0, y: 200))
        }, completion: { [weak self] _ in
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.circle.transform = strongSelf.circle.transform.concatenating(CGAffineTransform(translationX: 100, y: 0))
            }, completion: { [weak self] _ in
                UIView.animate(withDuration: 0.3, animations: {
                    guard let strongSelf = self else { return }
                    strongSelf.circle.transform = strongSelf.circle.transform.concatenating(CGAffineTransform(translationX: 0, y: -100))
                }, completion: nil)

            })
        })
```

### After

```swift
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
```

## Quick Start

```swift

class ViewController: UIViewController {
    
    let circle: UIView = {
        var cirlce = UIView()
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
```

## Installation
* Drag and drop Fluid.swift into your project.
