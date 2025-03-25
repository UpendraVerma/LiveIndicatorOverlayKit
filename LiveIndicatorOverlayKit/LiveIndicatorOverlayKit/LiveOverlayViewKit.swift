//
//  LiveOverlayViewKit.swift
//  LiveIndicatorOverlayKit


import UIKit

// Enum to define label position options
enum LiveLabelPosition {
    case top, bottom, left, right, custom(x: CGFloat, y: CGFloat)
}

extension UIImageView {
    
    // Apply dynamic live overlay to UIImageView
    func applyLiveOverlay(borderWidth: CGFloat = 0,
                          borderColor: UIColor = .clear,
                          borderCornerRadius: CGFloat? = nil,
                          liveCornerRadius: CGFloat? = nil,
                          liveText: String = "LIVE",
                          liveTextColor: UIColor = .white,
                          liveBackgroundColor: UIColor = .red,
                          font: UIFont = .systemFont(ofSize: 14),
                          labelHeight: CGFloat = 20,
                          labelWidth: CGFloat = 50,
                          padding: CGFloat = 5,
                          liveLabelPosition: LiveLabelPosition = .bottom) {
        
        // Remove any existing overlays
        removeLiveOverlay()
        
        // Create the overlay container view
        let overlayContainer = createOverlayContainer(borderWidth: borderWidth,
                                                      borderColor: borderColor,
                                                      cornerRadius: borderCornerRadius,
                                                      padding: padding)
        
        // Add overlay container to the superview
        self.superview?.addSubview(overlayContainer)
        
        // Set constraints for the overlay container
        NSLayoutConstraint.activate([
            overlayContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            overlayContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            overlayContainer.widthAnchor.constraint(equalTo: self.widthAnchor, constant: padding),
            overlayContainer.heightAnchor.constraint(equalTo: self.heightAnchor, constant: padding)
        ])
        
        // Create the "LIVE" label
        let liveLabel = createLiveLabel(text: liveText,
                                        textColor: liveTextColor,
                                        backgroundColor: liveBackgroundColor,
                                        font: font,
                                        labelHeight: labelHeight,
                                        labelWidth: labelWidth, cornerRadius: liveCornerRadius)
        
        // Add the "LIVE" label to the superview
        self.superview?.addSubview(liveLabel)
        
        // Set constraints for the live label based on the selected position
        switch liveLabelPosition {
        case .top:
            NSLayoutConstraint.activate([
                liveLabel.centerXAnchor.constraint(equalTo: overlayContainer.centerXAnchor),
                liveLabel.bottomAnchor.constraint(equalTo: overlayContainer.topAnchor, constant: labelHeight / 2)
            ])
        case .bottom:
            NSLayoutConstraint.activate([
                liveLabel.centerXAnchor.constraint(equalTo: overlayContainer.centerXAnchor),
                liveLabel.topAnchor.constraint(equalTo: overlayContainer.bottomAnchor, constant: -(labelHeight / 2))
            ])
        case .left:
            NSLayoutConstraint.activate([
                liveLabel.centerYAnchor.constraint(equalTo: overlayContainer.centerYAnchor),
                liveLabel.trailingAnchor.constraint(equalTo: overlayContainer.leadingAnchor, constant: labelWidth / 2)
            ])
        case .right:
            NSLayoutConstraint.activate([
                liveLabel.centerYAnchor.constraint(equalTo: overlayContainer.centerYAnchor),
                liveLabel.leadingAnchor.constraint(equalTo: overlayContainer.trailingAnchor, constant: -(labelWidth / 2))
            ])
        case .custom(let x, let y):
            NSLayoutConstraint.activate([
                liveLabel.centerXAnchor.constraint(equalTo: overlayContainer.centerXAnchor, constant: x),
                liveLabel.centerYAnchor.constraint(equalTo: overlayContainer.centerYAnchor, constant: y)
            ])
        }
        
        // Set label size constraints
        NSLayoutConstraint.activate([
            liveLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            liveLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
        
        
        // Bring the live label to the front
        self.superview?.bringSubviewToFront(liveLabel)
    }
    
    // Remove live overlay
    func removeLiveOverlay() {
        if let overlay = self.superview?.viewWithTag(999) {
            overlay.removeFromSuperview()
        }
        
        if let liveLabel = self.superview?.viewWithTag(998) {
            liveLabel.removeFromSuperview()
        }
    }
    
    // Helper method to create the overlay container
    private func createOverlayContainer(borderWidth: CGFloat, borderColor: UIColor, cornerRadius: CGFloat?, padding: CGFloat) -> UIView {
        let overlayContainer = UIView()
        overlayContainer.isUserInteractionEnabled = false
        overlayContainer.tag = 999
        
        overlayContainer.layer.borderWidth = borderWidth
        overlayContainer.layer.borderColor = borderColor.cgColor
        
        // Calculate corner radius: if cornerRadius is provided, use it; otherwise calculate it based on the padding
        let calculatedCornerRadius: CGFloat
        if let cornerRadius = cornerRadius {
            calculatedCornerRadius = cornerRadius + (padding / 2)
        } else {
            // Default corner radius based on the image view size and padding
            calculatedCornerRadius = (self.frame.size.width + padding) / 2
        }
        
        overlayContainer.layer.cornerRadius = calculatedCornerRadius
        
        overlayContainer.translatesAutoresizingMaskIntoConstraints = false
        
        return overlayContainer
    }
    
    // Helper method to create the "LIVE" label
    private func createLiveLabel(text: String, textColor: UIColor, backgroundColor: UIColor, font: UIFont, labelHeight: CGFloat, labelWidth: CGFloat, cornerRadius: CGFloat?) -> UILabel {
        let liveLabel = UILabel()
        liveLabel.isUserInteractionEnabled = false
        liveLabel.tag = 998
        liveLabel.text = text
        liveLabel.font = font
        liveLabel.textColor = textColor
        liveLabel.backgroundColor = backgroundColor
        liveLabel.textAlignment = .center
        liveLabel.layer.cornerRadius = cornerRadius ?? 5
        liveLabel.clipsToBounds = true
        liveLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return liveLabel
    }
}
