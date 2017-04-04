//
//  ViewController.swift
//  collectionViewDemo
//
//  Created by Md Ibrahim Hassan on 04/04/17.
//  Copyright © 2017 Md Ibrahim Hassan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var items = ["1", "2", "3", "4", "5", "6", "7", "8"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // also enter this string as the cell identifier in the storyboard
    }
    var numberOfRowsCountsArray : [Int] = []
    @IBOutlet weak var myTextField: UITextField!

    @IBAction func buttonAction(_ sender: Any) {
        if (self.myTextField.text != nil)
        {
            let numberOfCollectionsRequired : Double = ceil(Double(self.myTextField.text!)! / 4.0)
            var numberOfItemsInLastCollectionView : Int = Int(self.myTextField.text!)! % 4
            if numberOfItemsInLastCollectionView == 0
            {
                numberOfItemsInLastCollectionView = 4
            }
            for i in 1...Int(numberOfCollectionsRequired)
            {
                if (i != Int(numberOfCollectionsRequired))
                {
                    numberOfRowsCountsArray.append(4)
                }
                if (i == Int(numberOfCollectionsRequired))
                {
                    numberOfRowsCountsArray.append(numberOfItemsInLastCollectionView)
                }
            }
            self.initializeCollectionViews(count: Int(numberOfCollectionsRequired))
            print (numberOfRowsCountsArray)
        }
    }
    func initializeCollectionViews(count : Int)
    {
        var yCord : CGFloat!
        for i in 0...count - 1
        {
            let localNumberOfItems = numberOfRowsCountsArray[i]
            var xCord : CGFloat!
            var width: CGFloat!
            if (localNumberOfItems == 4)
            {
                xCord = 0.0
                width = self.view.frame.size.width
            }
            if (localNumberOfItems == 2)
            {
                xCord = self.view.frame.size.width / 4.0
                width = self.view.frame.size.width / 2.0
            }
            if (localNumberOfItems == 3)
            {
                width = self.view.frame.size.width * 0.75
                xCord = self.view.frame.size.width * 0.125
            }
            if (localNumberOfItems == 1)
            {
                width = self.view.frame.size.width * 0.25
                xCord = self.view.frame.size.width * 0.375
            }
            yCord = self.view.frame.size.height * 0.5 - 20 + CGFloat(i) * CGFloat(40.0)
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: self.view.frame.size.width / 4 - 10, height: 40)
            let view = UICollectionView.init(frame: CGRect.init(x: xCord, y: yCord, width: width, height: 40), collectionViewLayout: layout)
            view.backgroundColor = .red
            view.tag = i
            view.delegate = self
            view.dataSource = self
            view.isUserInteractionEnabled = false
            view.register(UINib(nibName: "myCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "myCollectionViewCell")
            self.view.addSubview(view)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let tag = collectionView.tag
        return (numberOfRowsCountsArray[tag])
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCollectionViewCell", for: indexPath) as! myCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.myLabel.text = self.items[indexPath.item]
        cell.backgroundColor = UIColor.yellow // make cell more visible in our example project
        
        return cell
           }
}

