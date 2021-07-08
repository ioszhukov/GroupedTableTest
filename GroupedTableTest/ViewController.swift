//
//  ViewController.swift
//  GroupedTableTest
//
//  Created by Andrey Zhukov on 08.07.2021.
//

import UIKit

class ViewController: UIViewController {
    var tableView: UITableView!
    
    let data = [
        [], // первая секция без элементов
        Array(0...8),
        Array(0...5),
        Array(0...3),
        Array(0...10)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: self.view.bounds, style: .grouped)
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedSectionHeaderHeight = 100.0 // проставлена такая же высота, но из-за первой пустой секции есть лаг, когда доскролл до 1 секции происходит (примерно где-то там)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .refresh, target: self, action: #selector(didTaprefresh))
    }
    
    @objc
    func didTaprefresh() {
        tableView.reloadData()
    }
}


extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell ==  nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = String(data[indexPath.section][indexPath.row])
        
        return cell!
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("content: \(tableView.contentSize.height), offset: \(tableView.contentOffset.y)")
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "section \(section) header"
        
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if data[section].isEmpty {
            return CGFloat.leastNormalMagnitude
        }
        
        return 100.0
    }
    // если раскомментить это - будет без лагов скролл (то можно даже не удалять, методы делегата приоритетнее того проперти)
//    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        if data[section].isEmpty {
//            return CGFloat.leastNormalMagnitude
//        }
//
//        return 100.0
//    }
}

