//
//  ACollectionViewController.swift
//  collection
//
//  Created by 薛永伟 on 2018/6/7.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

import UIKit


class ACollectionViewController: UICollectionViewController,ACollectionViewDelegateFlowLayout {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        self.collectionView?.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        self.collectionView?.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        
        self.collectionView?.contentInset = UIEdgeInsetsMake(20, 20, 20, 20)
        
        
        let fps = V2FPSLabel.init(frame: CGRect.init(x: 100, y: 100, width: 60, height: 20))
        fps.layer.zPosition = 100
        self.view.addSubview(fps)
        
    }
    @objc func longPressHandle(_ recognizer:UILongPressGestureRecognizer){
        let location = recognizer.location(in: self.collectionView)
        if let index = self.collectionView?.indexPathForItem(at: location){
            switch recognizer.state{
            case .began:
                print("Began")
                collectionView?.beginInteractiveMovementForItem(at: index)
            case .changed:
                collectionView?.updateInteractiveMovementTargetPosition(location)
            case .ended:
                print("End")
                collectionView?.endInteractiveMovement()
            default:
                collectionView?.cancelInteractiveMovement()
            }
            
//            if let cell = self.collectionView?.cellForItem(at: index){
//                becomeFirstResponder()
//                UIMenuController.shared.setTargetRect(cell.frame, in: self.collectionView!)
//                UIMenuController.shared.setMenuVisible(true, animated: true)
//            }
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    
    @objc func zan(){
        print("👍")
    }
    
    func customMenu() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 10
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ACollectionViewCell", for: indexPath) as! ACollectionViewCell
//        cell.btn.setTitle("\(indexPath.section)-\(indexPath.item)", for: .normal)
    
        return cell
    }
    

    
//
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
            view.backgroundColor = .clear
            let label = UILabel.init()
            label.textColor = UIColor.black
            label.text = "第\(indexPath.section)组"
            label.font = UIFont.systemFont(ofSize: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
            label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
            label.heightAnchor.constraint(equalToConstant: 20).isActive = true
            return view
        }else{
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath)
            view.backgroundColor = .clear
            return view
        }
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.item)")
    }
    override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

    }
    //MARK: - Move
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        print(action.description)
        
        return true
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    

}

extension ACollectionViewController{
//    func collectionBgColor(for collectionView: UICollectionView, layout: UICollectionViewFlowLayout, atSectionAt: Int) -> UIColor {
//        return UIColor.clear
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, topOffSetAt section: Int) -> CGFloat {
        return 30.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, bottomOffSetAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: 300, height: 30);
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 300, height: 20);
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 100, height: 160)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section % 2 == 0 {
            return UIEdgeInsetsMake(0, 20, 0, 20)
        }
        return UIEdgeInsetsMake(0, 50, 0, 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, backgroundColorForSectionAt section: Int) -> UIColor {
        if section%2 == 0{
            return UIColor.purple
        }
        return UIColor.yellow
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, bgViewAddHeaderForSectionAt section: Int) -> Bool {
//        return true
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, bgViewAddFooterForSectionAt section: Int) -> Bool {
//        return false
//    }
}
