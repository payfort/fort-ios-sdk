//
//  MainViewController.swift
//  SampleApp
//
//  Created by AlKalouti on 12/11/20.
//  Copyright © 2020 PayFort. All rights reserved.
//

import UIKit
import PayFortSDK

class MainViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak private var tableView: UITableView!
    
    var payFortController = PayFortController.init(enviroment: .sandBox)
    var stcController = STCPayViewController.init(enviroment: .sandBox)

    // MARK: - Properties
    
    var enviroment = PayFortEnviroment.sandBox
    var paramsArr = GlobalClass.returnParamsArray()
    var fruadParam = GlobalClass.shared.showFraudExtraParam
    
    private var extraParamDataSource: TableViewDataSource<ExtraParamCell, ExtraParam>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if fruadParam != GlobalClass.shared.showFraudExtraParam {
            fruadParam = GlobalClass.shared.showFraudExtraParam
            paramsArr = GlobalClass.returnParamsArray()
            extraParamDataSource.updateItems(paramsArr)
            tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        
        
        tableView.register(UINib(nibName: "ExtraParamCell", bundle: nil), forCellReuseIdentifier: "ExtraParamCell")
        
        // Register TableView generic data source
        extraParamDataSource = TableViewDataSource(cellIdenitfier: "ExtraParamCell", items: paramsArr) { cell, item, indexPath  in
            cell.setupCell(extraParam: item)
            cell.textField.tag = indexPath.row
            cell.textField.delegate = self
        }
        tableView.dataSource = extraParamDataSource
        
    }
    
    @IBAction private func createTokenAction(_ sender: Any) {
        
        UIPasteboard.general.string = payFortController.getUDID()
        print(payFortController.getUDID())
        
    }
    
    @IBAction func enviromentValueChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            //sandbox
            enviroment = .sandBox
        case 1:
            //pro
            enviroment = .production
        default:
            enviroment = .sandBox
        }
        
        payFortController = PayFortController.init(enviroment: enviroment)
        stcController = STCPayViewController.init(enviroment: enviroment)
    }
    
    @IBAction func commandValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            GlobalClass.shared.command = "PURCHASE"
            changeParamIsnideParamArr(key: "command", value: "PURCHASE")
        default:
            GlobalClass.shared.command = "AUTHORIZATION"
            changeParamIsnideParamArr(key: "command", value: "AUTHORIZATION")
        }
    }
    
    func changeParamIsnideParamArr(key: String, value: String) {
        paramsArr.filter({$0.title == key}).first?.text = value
        
        tableView.reloadData()
    }
    
    @IBAction func openPayfortPageAction(_ sender: Any) {
        payFortController.hideLoading = GlobalClass.shared.hideLoading
        payFortController.presentAsDefault = GlobalClass.shared.showFullPage
        payFortController.isShowResponsePage = GlobalClass.shared.showResponsePage
        if GlobalClass.shared.showCustomXib {
            payFortController.setPayFortCustomViewNib("CustomPayFortView")
        }else {
            payFortController.setPayFortCustomViewNib("")
        }
        print(extractExtraParam())
        return
        payFortController.callPayFort(withRequest: extractExtraParam(),
                                                 currentViewController: self) { (requestDic, responeDic) in
            print("--success--")
            print("--requestDic--\(requestDic)")
            print("--responeDic--\(responeDic)")
            GlobalClass.openResponseViewController(from: self, response: responeDic)

        } canceled: { (requestDic, responeDic) in
            print("--Canceled--")
            print("--requestDic--\(requestDic)")
            print("--responeDic--\(responeDic)")
            GlobalClass.openResponseViewController(from: self, response: responeDic)

        } faild: { (requestDic, responeDic, message) in
            print("--Faild--")
            print("--requestDic--\(requestDic)")
            print("--responeDic--\(responeDic)")
            print("--message--\(message)")
            GlobalClass.openResponseViewController(from: self, response: responeDic)

        }
        
    }

    func extractExtraParam() -> [String:String] {
        
        var params: [String:String] = [:]
        for item in paramsArr {
            if !item.text.isEmpty {
                params[item.title] = item.text
            }
        }
        
        return params
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToCustom" {
            let controller = segue.destination as! SelectCustomPaymentTypeVC
            controller.request = extractExtraParam()
            controller.enviroment = enviroment
        }else if segue.identifier == "directPay" {
            let controller = segue.destination as! DirectPayViewController
            controller.request = extractExtraParam()
            controller.enviroment = enviroment
        }
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let index = textField.tag
        let extraParam = paramsArr[index]
        extraParam.text = textField.text ?? ""
        paramsArr[index] = extraParam
    }
}
