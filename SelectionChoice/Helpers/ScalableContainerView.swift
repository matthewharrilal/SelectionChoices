//
//  ScalableContainerView.swift
//  SelectionChoice
//
//  Created by Space Wizard on 8/7/24.
//

import Foundation
import UIKit

class ScalableContainerView: UIView {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.transform = .identity
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.transform = .identity
        }
    }
}
