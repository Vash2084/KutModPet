//
//  GameViewController.swift
//  KMP
//
//  Created by Nagy Balint on 2019. 05. 25..
//  Copyright © 2019. Nagy Balint. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController, Messenger {
    
    func codePasser(cardCode: String) {
        
        switch cardCode {
        case "dumpling":
            increaseFoodBy += 20.0
            increaseDrinkBy += 10.0
            WarningBtn.isHidden = true
            foodImg.animationImages = [ #imageLiteral(resourceName: "Riceball1.png"), #imageLiteral(resourceName: "Riceball2.png") ]
            break
        case "fries":
            increaseFoodBy += 30.0
            increaseDrinkBy -= 15.0
            WarningBtn.isHidden = true
            foodImg.animationImages = [ #imageLiteral(resourceName: "Fries0.png"), #imageLiteral(resourceName: "Fries2.png") ]
            break
        case "ginger":
            increaseFoodBy += 0.0
            increaseDrinkBy += 25.0
            WarningBtn.isHidden = true
            foodImg.animationImages = [ #imageLiteral(resourceName: "Ginger1.png"), #imageLiteral(resourceName: "Ginger2.png") ]
            break
            
        default:
            WarningBtn.isHidden = false
        }
        
    }
    
    var foodPercentage = 80.0
    var drinkPercentage = 80.0
    var chewImages = [ #imageLiteral(resourceName: "Chew slime01.png"), #imageLiteral(resourceName: "Chew slime ce 0201.png"), #imageLiteral(resourceName: "Chew slime ce 0101.png"), #imageLiteral(resourceName: "Chew slime ce 0201.png") ]
    var increaseFoodBy = 0.0
    var increaseDrinkBy = 0.0
    
    var screenRefreshTimer:Timer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WarningBtn.isHidden = true
        steve.animationImages = chewImages
        steve.animationDuration = 1.2
        steve.animationRepeatCount = 2
        foodImg.animationDuration = 2.4
        foodImg.animationRepeatCount = 1
        
        scheduledTimerWithTimeInterval()
    }

    @IBOutlet weak var imgFoodBar: UIImageView!
    
    @IBOutlet weak var imgDrinkBar: UIImageView!
    
    @IBOutlet weak var steve: UIImageView!
    
    @IBOutlet weak var WarningBtn: UIButton!
    
    @IBOutlet weak var foodImg: UIImageView!
    
    @IBAction func feed(_ sender: Any) {
        
        let scanner = ScannerViewController()
        scanner.delegate = self
        self.present(scanner, animated: true)
        
    }
    
    
    @IBAction func dismiss(_ sender: Any) {
        WarningBtn.isHidden = true
    }
    
    func scheduledTimerWithTimeInterval(){
        screenRefreshTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.foodAndDrinkCheck), userInfo: nil, repeats: true)
    }
    
    override var shouldAutorotate: Bool {
        return false
    }

    func munch() {
        steve.startAnimating()
        foodImg.startAnimating()
    }
    
    @objc func foodAndDrinkCheck() {
        if increaseFoodBy != 0 || increaseDrinkBy != 0 {
            munch()
        }
        foodPercentage += (increaseFoodBy - 0.5)
        drinkPercentage += (increaseDrinkBy - 0.5)
        increaseDrinkBy = 0
        increaseFoodBy = 0
        
        if foodPercentage < 0 {
            foodPercentage = 0
            imgFoodBar.image = #imageLiteral(resourceName: "foodbar 01")
        }
        if foodPercentage > 0 && foodPercentage <= 20 {
            imgFoodBar.image = #imageLiteral(resourceName: "foodbar 01")
        }
        if foodPercentage <= 40 && foodPercentage > 20 {
            imgFoodBar.image = #imageLiteral(resourceName: "foodbar 02")
        }
        if foodPercentage <= 60 && foodPercentage > 40 {
            imgFoodBar.image = #imageLiteral(resourceName: "foodbar 03")
        }
        if foodPercentage <= 80 && foodPercentage > 60 {
            imgFoodBar.image = #imageLiteral(resourceName: "foodbar 04")
        }
        if foodPercentage > 80 && foodPercentage <= 100 {
            imgFoodBar.image = #imageLiteral(resourceName: "foodbar 05")
        }
        if foodPercentage > 100 {
            foodPercentage = 100
            imgFoodBar.image = #imageLiteral(resourceName: "foodbar 05")
        }
        
        if drinkPercentage < 0 {
            drinkPercentage = 0
            imgDrinkBar.image = #imageLiteral(resourceName: "drinkbar 01")
        }
        if drinkPercentage > 0 && drinkPercentage <= 20 {
            imgDrinkBar.image = #imageLiteral(resourceName: "drinkbar 01")
        }
        if drinkPercentage <= 40 && drinkPercentage > 20 {
            imgDrinkBar.image = #imageLiteral(resourceName: "drinkbar 02")
        }
        if drinkPercentage <= 60 && drinkPercentage > 40 {
            imgDrinkBar.image = #imageLiteral(resourceName: "drinkbar 03")
        }
        if drinkPercentage <= 80 && drinkPercentage > 60 {
            imgDrinkBar.image = #imageLiteral(resourceName: "drinkbar 04")
        }
        if drinkPercentage > 80 && drinkPercentage <= 100 {
            imgDrinkBar.image = #imageLiteral(resourceName: "drinkbar 05")
        }
        if drinkPercentage > 100 {
            drinkPercentage = 100
            imgDrinkBar.image = #imageLiteral(resourceName: "drinkbar 05")
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
}
