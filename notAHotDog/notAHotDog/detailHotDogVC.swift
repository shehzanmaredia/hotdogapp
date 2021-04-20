//
//  detailHotDogVC.swift
//  notAHotDog
//
//  Created by Jason Wang on 4/14/21.
//

import Foundation
import UIKit

class detailHotDogVC: UIViewController {
    
    @IBOutlet weak var currImage: UIImageView!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currImage.image = image
        // Do any additional setup after loading the view.
    }
}
