//
//  MainViewController.swift
//  ValidationExample
//
//  Created by BV on 2018. 5. 29..
//  Copyright © 2018년 Sung9. All rights reserved.
//

import UIKit
import RxDataSources
import RxCocoa
import RxSwift

struct TableSection {
    var header: String
    var items: [Item]
}

extension TableSection : AnimatableSectionModelType {
    typealias Item = String
    
    var identity: String {
        return header
    }
    
    init(original: TableSection, items: [Item]) {
        self = original
        self.items = items
    }
}

class MainViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<TableSection>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<TableSection>(configureCell: { ds, tv, ip, item in
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
            cell.textLabel?.text = item + ""
            return cell
        })
        
        
        dataSource.titleForHeaderInSection = { ds, index in
            return ds.sectionModels[index].header
        }
        
        let sections = [
            TableSection(header: "", items: ["phone","email"])
        ]
        
        Observable.just(sections)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)
        
        self.tableView.rx.setDelegate(self)
            .disposed(by: self.disposeBag)
        
        self.dataSource = dataSource
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setViewControllerTitle(title: "MainViewController")
    }
}

extension MainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.dataSource?[indexPath] == nil ? 0 : 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        LogHelper.printLog("indexPath : \(indexPath)")
        DispatchQueue.main.async {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        guard let detailVC = self.returnVC(sbName: Constants_storyboard.MAIN, vcName: "DetailViewController") as? DetailViewController else { return }
        detailVC.type = indexPath.row == 0 ? RegexType.phone : RegexType.email
        self.push(vc: detailVC)
    }
}
