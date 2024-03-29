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
    
    let names = ["Animation 1", "Animation 2", "Animation 3", "Animation 4", "Animation 5", "Animation 6", "Animation 7", "Animation 8", "Animation 9", "Animation 10"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
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
        case 2:
            guard let vc = storyboard.instantiateViewController(withIdentifier: "Animation3") as? Animation3 else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            guard let vc = storyboard.instantiateViewController(withIdentifier: "Animation4") as? Animation4 else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            guard let vc = storyboard.instantiateViewController(withIdentifier: "Animation5") as? Animation5 else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        case 5:
            guard let vc = storyboard.instantiateViewController(withIdentifier: "Animation6") as? Animation6 else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        case 6:
            guard let vc = storyboard.instantiateViewController(withIdentifier: "Animation7") as? Animation7 else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        case 7:
            guard let vc = storyboard.instantiateViewController(withIdentifier: "Animation8") as? Animation8 else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        case 8:
            guard let vc = storyboard.instantiateViewController(withIdentifier: "Animation9") as? Animation9 else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        case 9:
            guard let vc = storyboard.instantiateViewController(withIdentifier: "Animation10") as? Animation10 else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
