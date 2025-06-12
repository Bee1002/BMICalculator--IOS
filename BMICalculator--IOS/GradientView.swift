import UIKit

@IBDesignable
class GradientView: UIView {
    @IBInspectable var startColor: UIColor = .systemBlue {
        didSet {
            updateGradient()
        }
    }
    
    @IBInspectable var middleColor: UIColor = .systemPurple {
        didSet {
            updateGradient()
        }
    }
    
    @IBInspectable var endColor: UIColor = .systemIndigo {
        didSet {
            updateGradient()
        }
    }
    
    private var gradientLayer: CAGradientLayer?
    private var animationTimer: Timer?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradient()
        startAnimation()
    }
    
    private func updateGradient() {
        if gradientLayer == nil {
            gradientLayer = CAGradientLayer()
            layer.insertSublayer(gradientLayer!, at: 0)
        }
        
        gradientLayer?.frame = bounds
        gradientLayer?.colors = [startColor.cgColor, middleColor.cgColor, endColor.cgColor]
        gradientLayer?.locations = [0.0, 0.5, 1.0]
        gradientLayer?.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer?.endPoint = CGPoint(x: 1.0, y: 1.0)
    }
    
    private func startAnimation() {
        animationTimer?.invalidate()
        animationTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] _ in
            self?.animateGradient()
        }
    }
    
    private func animateGradient() {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.5, 1.0]
        animation.toValue = [0.0, 0.7, 1.0]
        animation.duration = 2.0
        animation.autoreverses = true
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        gradientLayer?.add(animation, forKey: "gradientAnimation")
    }
    
    deinit {
        animationTimer?.invalidate()
    }
} 