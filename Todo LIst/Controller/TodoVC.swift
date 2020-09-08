//
//  ViewController.swift
//  Todo LIst
//
//  Created by Captain on 07/09/20.
//  Copyright © 2020 Captain. All rights reserved.
//

import UIKit

class TodoVC: UIViewController {
    //Mark:- IBOutlet
    @IBOutlet var tbl_TodoListDetail: UITableView!
    @IBOutlet var SerchTodo: UISearchBar!
    @IBOutlet var btn_All: UIButton!
    @IBOutlet var btn_Complete: UIButton!
    @IBOutlet var btn_Uncomplete: UIButton!
    @IBOutlet var img_All: UIImageView!
    @IBOutlet var img_Complete: UIImageView!
    @IBOutlet var img_Uncomplete: UIImageView!
    //Mark:- Variable
    var Arr_TodoList = [TodoModel]()
    var searchActive : Bool = false
    var searchResults = [TodoModel]()
    var Is_Select_All : Bool = true
    var Is_Select_Complete : Bool = false
    var Is_Select_Uncomplete : Bool = false
    var Is_Filter_Select_All : Bool = false
    var Is_Filter_Select_Complete : Bool = false
    var Is_Filter_Select_Uncomplete : Bool = false
    //Mark:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitializeView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.title = ""
    }
    func InitializeView() {
        self.tbl_TodoListDetail.register(UINib(nibName: "TodoList_Cell", bundle: nil), forCellReuseIdentifier: "TodoList_Cell")
        self.tbl_TodoListDetail.rowHeight = UITableView.automaticDimension
        self.tbl_TodoListDetail.tableFooterView = UIView()
        self.tbl_TodoListDetail.separatorStyle = .none
        //calling api
        ServiceCall.shareInstance.Get_TodoDetail(ViewController: self, Api_Str: "http://jsonplaceholder.typicode.com/todos")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
        searchActive = false;
        self.SerchTodo.text = ""
        self.searchResults = (NSMutableArray().mutableCopy() as! NSMutableArray) as! [TodoModel]
        self.tbl_TodoListDetail.delegate = self
        self.tbl_TodoListDetail.dataSource = self
        self.tbl_TodoListDetail.reloadData()
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch ended")
        super.touchesEnded(touches, with: event)
    }
    //Mark:- Button Action
    @IBAction func btn_Click_Filter(_ sender: UIButton) {
        self.view.endEditing(true)
        self.SerchTodo.text = ""
        if sender.tag == 1 {
            print("All Click")
            self.Is_Select_All = !self.Is_Select_All
            self.img_All.image = UIImage(named: Is_Select_All ? "ic_Radio_Selected" : "ic_Radio_Unselected")
            self.img_Complete.image = UIImage(named: Is_Select_All ? "ic_Radio_Unselected" : "ic_Radio_Selected")
            self.img_Uncomplete.image = UIImage(named: Is_Select_All ? "ic_Radio_Unselected" : "ic_Radio_Selected")
            self.Is_Select_Complete = false
            self.Is_Select_Uncomplete = false
            self.Is_Select_All = false
            
            self.Is_Filter_Select_All = true
            self.Is_Filter_Select_Complete = false
            self.Is_Filter_Select_Uncomplete = false
            self.tbl_TodoListDetail.reloadData()
        }else if sender.tag == 2 {
            print("Complete Click")
            self.Is_Select_Complete = !self.Is_Select_Complete
            self.img_Complete.image = UIImage(named: Is_Select_Complete ? "ic_Radio_Selected" : "ic_Radio_Unselected")
            self.img_All.image = UIImage(named: Is_Select_Complete ? "ic_Radio_Unselected" : "ic_Radio_Selected")
            self.img_Uncomplete.image = UIImage(named: Is_Select_Complete ? "ic_Radio_Unselected" : "ic_Radio_Selected")
            self.Is_Select_All = false
            self.Is_Select_Uncomplete = false
            self.Is_Select_Complete = false
            
            self.Is_Filter_Select_All = false
            self.Is_Filter_Select_Complete = true
            self.Is_Filter_Select_Uncomplete = false
            self.tbl_TodoListDetail.reloadData()
        }else {
            print("UnComplete Click")
            self.Is_Select_Uncomplete = !self.Is_Select_Uncomplete
            self.img_Uncomplete.image = UIImage(named: Is_Select_Uncomplete ? "ic_Radio_Selected" : "ic_Radio_Unselected")
            self.img_Complete.image = UIImage(named: Is_Select_Uncomplete ? "ic_Radio_Unselected" : "ic_Radio_Selected")
            self.img_All.image = UIImage(named: Is_Select_Uncomplete ? "ic_Radio_Unselected" : "ic_Radio_Selected")
            self.Is_Select_All = false
            self.Is_Select_Complete = false
            self.Is_Select_Uncomplete = false
            
            self.Is_Filter_Select_All = false
            self.Is_Filter_Select_Complete = false
            self.Is_Filter_Select_Uncomplete = true
            self.tbl_TodoListDetail.reloadData()
        }
    }
}
extension TodoVC : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive && self.SerchTodo.text!.trimmed != "" && Is_Filter_Select_All == true {
            return self.searchResults.count
        }else if searchActive && self.SerchTodo.text!.trimmed != "" && Is_Filter_Select_Complete == true {
            return searchResults.filter{$0.completed == true}.count
        }else if searchActive && self.SerchTodo.text!.trimmed != "" && Is_Filter_Select_Uncomplete == true {
            return searchResults.filter{$0.completed == false}.count
        }else {
            return Arr_TodoList.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TodoList_Cell = tableView.dequeueReusableCell(withIdentifier: "TodoList_Cell") as! TodoList_Cell
        cell.DisplayTodoList(indexPath: indexPath, myTodo: self)
        cell.selectionStyle = .none
        tableView.separatorStyle = .singleLine//(self.arrOptions.count == indexPath.row+1 ) ?
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did Selecte call")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
extension TodoVC : UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       searchActive = false;
       self.view.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchActive
        {
            if(searchText == "")
            {
                self.searchResults = Arr_TodoList
                self.tbl_TodoListDetail?.delegate = self
                self.tbl_TodoListDetail?.dataSource = self
                self.tbl_TodoListDetail?.reloadData()
            }
            else
            {
                let filtered = Arr_TodoList.filter{(($0.title!).lowercased()).contains(searchText.trimmed.lowercased())}
                
                self.searchResults = filtered
                print(filtered)
                self.tbl_TodoListDetail?.delegate = self
                self.tbl_TodoListDetail?.dataSource = self
                self.tbl_TodoListDetail?.reloadData()
            }
        }
    }
}
