//
//  TodoList_Cell.swift
//  Todo LIst
//
//  Created by Captain on 07/09/20.
//  Copyright © 2020 Captain. All rights reserved.
//

import UIKit

class TodoList_Cell: UITableViewCell {
    
    @IBOutlet var lbl_Title: UILabel!
    @IBOutlet var img_Check_Uncheck: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func DisplayTodoList(indexPath : IndexPath , myTodo : TodoVC) {
        var Filter_Obj = [TodoModel]()
       if myTodo.searchActive && myTodo.SerchTodo.text!.trimmed != "" && myTodo.Is_Filter_Select_All == true {
            Filter_Obj = myTodo.searchResults
        }else if myTodo.searchActive && myTodo.SerchTodo.text!.trimmed != "" && myTodo.Is_Filter_Select_Complete == true {
            Filter_Obj = myTodo.searchResults.filter{$0.completed == true}
        }else if myTodo.searchActive && myTodo.SerchTodo.text!.trimmed != "" && myTodo.Is_Filter_Select_Uncomplete == true {
            Filter_Obj = myTodo.searchResults.filter{$0.completed == false}
       }else if myTodo.Is_Filter_Select_All == true || myTodo.Is_Filter_Select_Complete == true || myTodo.Is_Filter_Select_Uncomplete == true {
        if myTodo.Is_Filter_Select_All == true {
            Filter_Obj = myTodo.Arr_TodoList
        }else if myTodo.Is_Filter_Select_Complete == true {
            Filter_Obj = myTodo.Arr_TodoList.filter{$0.completed == true}
        }else if myTodo.Is_Filter_Select_Uncomplete == true {
            Filter_Obj = myTodo.Arr_TodoList.filter{$0.completed == false}
        }
       }else {
            Filter_Obj = myTodo.Arr_TodoList
        }
        
        let Obj = Filter_Obj[indexPath.row]
        self.lbl_Title.text = Obj.title!
        self.img_Check_Uncheck.image = UIImage(named: (Obj.completed! == true) ? "ic_Check" : "ic_Uncheck")
    }
    
}
