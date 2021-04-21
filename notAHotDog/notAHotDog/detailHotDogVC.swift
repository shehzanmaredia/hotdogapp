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
    var ishotdog: Bool!
    @IBOutlet weak var hotdogimage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currImage.image = image
        if ishotdog{
            hotdogimage.image = UIImage(named: "notHOTDOG_is")
        }
        else{
            hotdogimage.image = UIImage(named: "notHOTDOG_not")
        }

    }
}
