//
//  ViewController.swift
//  ProjectTwo
//
//  Created by Admin on 23.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let cache = ImageCache()
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var loader:   UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loader.isHidden = true
        calculateConstraint()
    }
    @IBOutlet weak var buttonConstraint: NSLayoutConstraint!
        
    @IBAction func changeDidPress(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SecondVC") as! SecondViewController
        vc.loadViewIfNeeded()
        vc.fullSizeImageView.image = image.image?.rotate(radians: .pi/2)
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func deleteDidPress(_ sender: Any) {
        guard let url = cache.currentImageURL else { return }
        cache.delete(url: url)
        image.image = nil
    }
    
    
    @IBAction func buttonDidPress(_ sender: Any) {
        loader.isHidden = false
        loader.startAnimating()
        cache.getRandomImage(onComplete: { randomImage in
            self.loader.stopAnimating()
            self.loader.isHidden = true
            self.image.image = randomImage
        })
        
    }
    
    func calculateConstraint() {
        switch Device.current
        {
        case .iphone4:
            buttonConstraint.constant = 8
        case .iphone5:
            buttonConstraint.constant = 12
        case .iphone6:
            buttonConstraint.constant = 18
        case .iphone6Plus:
            buttonConstraint.constant = 24
        case .iphoneX:
            buttonConstraint.constant = 36
        case .iphoneXmax:
            buttonConstraint.constant = 42
        }
        
    }
}

