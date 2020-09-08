

import UIKit
import Alamofire

class AFWrapper: NSObject
{
    //MARK:- Get Method
    class func requestGETURL_WithParameter_ReturnStatuscode(_ strURL: String, headers : [String : String]?,params : [String : String]?, success:@escaping (Data,Int,JSON) -> Void, failure:@escaping (Error) -> Void)
    {
        let final_strURL : String = strURL
        print(final_strURL)
        Alamofire.request(final_strURL, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            if responseObject.result.isSuccess {
                print(responseObject.response!.statusCode)
                var StatusCode : Int = 1;
                StatusCode = responseObject.response!.statusCode
                success(responseObject.data!,StatusCode,JSON(responseObject.result.value!))
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
}

