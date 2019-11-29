//
//  ViewController.swift
//  OKR-CoreAnimation
//
//  Created by Mahnoor Khan on 29/11/2019.
//  Copyright © 2019 Mahnoor Khan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    
    let names = ["Animation 1", "Animation 2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.delegate = self
        tblView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        switch indexPath.row {
        case 0:
            guard let vc = storyboard.instantiateViewController(withIdentifier: "Animation1") as? Animation1 else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            guard let vc = storyboard.instantiateViewController(withIdentifier: "Animation2") as? Animation2 else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
