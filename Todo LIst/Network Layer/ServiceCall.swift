//
//  ServiceCall.swift
//  Todo LIst
//
//  Created by Captain on 07/09/20.
//  Copyright © 2020 Captain. All rights reserved.
//

import Foundation
import Alamofire
import SKActivityIndicatorView
class ServiceCall: NSObject
{
    static let shareInstance = ServiceCall()
    func Get_TodoDetail(ViewController: UIViewController,Api_Str : String) {
        if Singleton.sharedInstance.NetworkRechability(){
            Utils.ShowActivityIndicator(message: "Loading")
            var Todo_VC = ViewController as! TodoVC
            AFWrapper.requestGETURL_WithParameter_ReturnStatuscode(Api_Str, headers: [:], params: [:], success: { (responseObject, statusCode, JSONObject) in
                print(JSONObject)
                SKActivityIndicator.dismiss()
                if statusCode == 200 {
                    let result = try? JSONDecoder().decode([TodoModel].self, from: responseObject)
                    Todo_VC.Arr_TodoList = result!
                    Todo_VC.tbl_TodoListDetail.reloadData()
                }else {
                    print("Something Gone Wrong..")
                }
            })
            { (error) in
                SKActivityIndicator.dismiss()
                print(error.localizedDescription)
            }
        }else {
            print("Internet Not Availabel")
        }
    }
}

