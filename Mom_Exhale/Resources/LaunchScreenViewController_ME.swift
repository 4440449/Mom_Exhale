//
//  LaunchScreenViewController_ME.swift
//  Mom_Exhale
//
//  Created by Maxim on 19.07.2022.
//

import UIKit


final class LaunchScreenViewController_ME: UIViewController {
    
    @IBOutlet weak var logoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        logoLabel.text = "#мамавыдохни"
        logoLabel.font = UIFont(name: "Montserrat-Black", size: 37)!
        logoLabel.textColor = .label
        logoLabel.numberOfLines = 1
        logoLabel.textAlignment = .center
    }
}


