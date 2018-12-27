//
//  DiscoverViewController.swift
//  Filmder
//
//  Created by MacNicolas on 20/12/2018.
//  Copyright © 2018 civetdelapin. All rights reserved.
//

import UIKit
import Koloda

private var numberOfCards: Int = 5

class DiscoverViewController: UIViewController {

    @IBOutlet weak var kolodaView: KolodaView!
    
    
    fileprivate var dataSource: [UIImage] = {
        var array: [UIImage] = []
        for index in 0..<numberOfCards {
            array.append(UIImage(named: "Film")!)
        }
        
        return array
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
        
        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
    }
    
    // MARK: IBActions
    
    @IBAction func leftButtonClick(_ sender: UIButton) {
        kolodaView?.swipe(.left)
    }
    
    @IBAction func rightButtonClick(_ sender: UIButton) {
        kolodaView?.swipe(.right)
    }
    
}

// MARK: KolodaViewDelegate

extension DiscoverViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        let position = kolodaView.currentCardIndex
        for i in 1...4 {
            dataSource.append(UIImage(named: "Film")!)
        }
        kolodaView.insertCardAtIndexRange(position..<position + 4, animated: true)
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popViewController = storyBoard.instantiateViewController(withIdentifier: "popViewController")
        self.navigationController?.pushViewController(popViewController, animated: true)
        //self.present(popViewController, animated: true, completion: nil)
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        if(direction == .right){
            print("Swip right")
            //ACTION DE SWIP DROITE ICI
        }else{
            print("Swip left")
            //ACTION DE SWIP GAUCHE ICI
        }
    }
    
}

// MARK: KolodaViewDataSource

extension DiscoverViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return dataSource.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        return UIImageView(image: dataSource[Int(index)])
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        //return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)?[0] as? OverlayView
        return OverlayView()
    }
}

