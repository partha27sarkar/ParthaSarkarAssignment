//
//  ViewController.swift
//  ParthaSarkarAssignment
//
//  Created by Partha Sarkar on 24/07/18.
//  Copyright © 2018 Partha Sarkar. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableMainView: UITableView!
    
    var viewModel: MainViewModel!
    let cellId = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = MainViewModel()
        self.tableMainView.delegate = self
        self.tableMainView.dataSource = self
        self.setupRightBtn()
        self.loadMostPopularAPI()
    }
    
    private func loadMostPopularAPI(){
        self.viewModel.getMostPopularAPI({ response in
            self.viewModel.apiData = response
            DispatchQueue.main.async {
                self.tableMainView.reloadData()
            }
        }, errorHandling: { err in
            print(err)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupRightBtn(){
        
        let crossNavBtn = UIButton(type: .custom)
        crossNavBtn.setImage(UIImage.init(named: "icon-menu")?.imageWithColor(color1: .white), for: .normal)
        crossNavBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        crossNavBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        //crossNavBtn.addTarget(self, action: #selector(onClose), for: .touchUpInside)
        
        let crossBarBtn = UIBarButtonItem(customView: crossNavBtn)
        
        self.navigationItem.setLeftBarButton(crossBarBtn, animated: false)
    }
    
}

extension MainViewController :UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.apiData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MainTableViewCell
        cell.setData = self.viewModel.apiData[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
}




extension UIImage {
    func imageWithColor(color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color1.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}








