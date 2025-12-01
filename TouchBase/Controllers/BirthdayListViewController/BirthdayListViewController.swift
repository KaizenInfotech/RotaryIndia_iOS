//
//  BirthdayListViewController.swift
//  TouchBaseGit
//
//  Created by Umesh on 27/05/15.
//  Copyright (c) 2015 Parag. All rights reserved.
//

import UIKit
import EventKit

class BirthdayListViewController: UIViewController ,UIGestureRecognizerDelegate,UIPopoverPresentationControllerDelegate,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var bdayTable: UITableView!
    @IBOutlet var popupView: UIView!
    
    var selectedForce: CGFloat = 3
    var selectedDuration: CGFloat = 3
    var selectedDelay: CGFloat = 0
    
    var selectedDamping: CGFloat = 0.7
    var selectedVelocity: CGFloat = 0.7
    var selectedScale: CGFloat = 1
    var selectedX: CGFloat = 0
    var selectedY: CGFloat = 0
    var selectedRotate: CGFloat = 0
    
    let screenSize: CGRect = UIScreen.main.bounds
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        createNavigationBar()
        
        // Do any additional setup after loading the view.
        let recognizer = UITapGestureRecognizer(target: self, action:#selector(BirthdayListViewController.handleTaponpopup(_:)))
        recognizer.delegate = self
       popupView.addGestureRecognizer(recognizer)
      
    }
    
    func handleTap(_ recognizer: UITapGestureRecognizer) {
        print("remove")
        
        
    }
    @objc func handleTaponpopup(_ recognizer: UITapGestureRecognizer){
        popupView .removeFromSuperview()
    //    setOptions("fadeOut")
   //     popupView.animate()
        
    }
    
    
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title="Celebrations"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(BirthdayListViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        
        let buttonlog = UIButton(type: UIButton.ButtonType.custom)
        buttonlog.frame = CGRect(x: 0, y: 0, width: 60, height: 40)
        buttonlog.titleLabel?.textAlignment = NSTextAlignment.right
        buttonlog.titleLabel?.font = UIFont(name: "Open Sans", size: 14)
        buttonlog.setImage(UIImage(named: "search_btn"), for: UIControl.State.normal)
        buttonlog.addTarget(self, action: #selector(BirthdayListViewController.searchClicked), for: UIControl.Event.touchUpInside)
        let skipButton: UIBarButtonItem = UIBarButtonItem(customView: buttonlog)
        self.navigationItem.rightBarButtonItem = skipButton
        
    }
    
     @objc func backClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func searchClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
      
    
     func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell:BdayListCell! = bdayTable.dequeueReusableCell(withIdentifier: "bdayCEll", for: indexPath) as! BdayListCell
        
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showPopupView()
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        footerView.backgroundColor = UIColor(red: 59/255.0, green: 71/255.0, blue: 98/255.0, alpha: 1.0)
        
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: 250, height: 30))
        label.textAlignment = NSTextAlignment.left
        label.text = "BIRTHDAYS & ANNIVERSARIES"
        label.font =  UIFont(name: "Roboto-Regular", size: 14)
        label.textColor = UIColor(red: 161/255.0, green: 255/255.0, blue: 214/255.0, alpha: 1.0)
        label.backgroundColor=UIColor.clear
        footerView.addSubview(label)
        
        let image = UIImage(named: "calendar.png") as UIImage!
        let evntbtn = UIButton(frame: CGRect(x: tableView.frame.size.width-30, y: 5, width: 25, height: 30))
        evntbtn.setImage(image ,  for: UIControl.State.normal)
        evntbtn.addTarget(self, action: #selector(BirthdayListViewController.buttonTapped), for: .touchUpInside)
        evntbtn.titleLabel?.textColor = UIColor(red: 7/255.0, green: 159/255.0, blue: 92/255.0, alpha: 1.0)
        evntbtn.backgroundColor=UIColor.clear
        footerView.addSubview(evntbtn)
        
        let bottomLine = UIImageView (frame: CGRect(x: 0, y: 39,  width: tableView.frame.size.width, height: 1))
        bottomLine.backgroundColor=UIColor(red: 218/255.0, green: 221/255.0, blue: 226/255.0, alpha: 1.0)
        footerView.addSubview(bottomLine)
        
        return footerView
    }
    @objc func buttonTapped(){
        //calVC
        self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "calVC") as UIViewController, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
       // menu.view.removeFromSuperview()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(withDuration: 0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
        })
    }
    
    
    func showPopupView(){
        
        popupView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        self.view .addSubview(popupView)
        
     //   setOptions("fadeIn")
     //   popupView.animate()
    }
    
    
/*
    func setOptions(animationStr: String) {
        popupView.force = selectedForce
        popupView.duration = selectedDuration
        popupView.delay = selectedDelay
        
        popupView.damping = selectedDamping
        popupView.velocity = selectedVelocity
        popupView.scaleX = selectedScale
        popupView.scaleY = selectedScale
        popupView.x = selectedX
        popupView.y = selectedY
        popupView.rotate = selectedRotate
        
        popupView.animation = animationStr//data[0][selectedRow]
        popupView.curve = "spring"//data[1][selectedEasing]
    }
*/
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
