//
//  ViewController.swift
//  Calendar
//
//  Created by 梁家章 on 11/01/2018.
//  Copyright © 2018 liangjiazhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var calendar: UICollectionView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    // 得到目前的年份
    var currentYear = Calendar.current.component(.year, from: Date())
    
    // 得到目前的月份
    var currentMonth = Calendar.current.component(.month, from: Date())
    
    //
    var months = ["January", "February", "March", "April", "May", "June", "July", "Auguest", "September", "October", "November", "December"]
    
    // 计算每个月里有多少天
    var numberOfDaysInThisMonth:Int {
        let dateComponents = DateComponents(year: currentYear , month: currentMonth)
        let datey = Calendar.current.date(from: dateComponents)!
        let range = Calendar.current.range(of: .day, in: .month, for: datey)
        return range?.count ?? 0
    }
    
    @IBAction func nextMonth(_ sender: UIButton) {
        
        currentMonth += 1
        if currentMonth == 13 {
            currentMonth = 1
            currentYear += 1
        }
        setUp()
        
    }
    @IBAction func lastMonth(_ sender: UIButton) {
        
        currentMonth -= 1
        if currentMonth == 0 {
            currentMonth = 12
            currentYear -= 1
        }
        setUp()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        setUp()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // 设定真实的时间
    func setUp() {
        
        // print(Data())
        
        timeLabel.text = months[currentMonth - 1] + " \(currentYear)"
        
        // 重新显示
        calendar.reloadData()
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return 31
        return numberOfDaysInThisMonth
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //  这个方法就是回传可能用过，也可能是全新的cell 给我们
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        // 设置显示文字
        if let textLabel = cell.contentView.subviews[0] as? UILabel {
            textLabel.text = "\(indexPath.row + 1)"
        }
        
        return cell
    }
    
    // cell 上下的item 都为0
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // cell 左右的item 都为0
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 在任何viewcontroller  的宽度都显示 7等份
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7
        
        return CGSize(width: width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
    // 当屏幕转向的时候，重新计算布局
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // cell 的 item 重新计算
        calendar.collectionViewLayout.invalidateLayout()
    }

}

