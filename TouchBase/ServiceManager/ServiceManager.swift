//
//  ServiceManager.swift
//  TouchBase
//
//  Created by Rajendra JAt on 28/12/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class ServiceManager: NSObject
{
    /*-start-*/
    //1.
    func webserviceWithRequestMethod(_ method:HTTPMethod, url urlStr: String, parameters: [AnyHashable: Any], forTask apiTask: TaskType, currentView view: UIView, useAccessToken isAccessToken: Bool, completionHandler completionBlock: @escaping (_ response: AnyObject) -> Void)
    {
        if (apiTask == TaskType.kTaskResgister || apiTask == TaskType.kTaskLogin || apiTask == TaskType.kTaskVarification || apiTask == TaskType.kTaskGetStoreList || apiTask == TaskType.kTaskGetCouponList || apiTask == TaskType.kTaskVerifyStorePin || apiTask == TaskType.kTaskGetHelpITServices || apiTask == TaskType.kTaskGetHelpITSPList || apiTask == TaskType.kTaskGetHelpITFillForm || apiTask == TaskType.kTaskGetOutletList || apiTask == TaskType.kTaskGetProductList || apiTask == TaskType.kTaskGetFAQ || apiTask == TaskType.kTaskGetPaymentHistoryList || apiTask == TaskType.kTaskGetServiceCharges || apiTask == TaskType.kTaskBookACab || apiTask == TaskType.kTaskGetAcInfo || apiTask == TaskType.kTaskNotificationList || apiTask == TaskType.kTaskSendCartOnServer || apiTask == TaskType.kTaskPaymentRequest || apiTask == TaskType.kTaskGetWalletAmount || apiTask == TaskType.kTaskUpdateWalletAmount || apiTask == TaskType.kTaskPaymentRequestWallet || apiTask == TaskType.kTaskGetContactList || apiTask == TaskType.kTaskCountryList  || apiTask == TaskType.kUserProfileDetailList)
        {
            //=> code for set progressbar for show
            
            
        }
        self.httpMakeRequest(with: method, url: urlStr,param: parameters as AnyObject, completionHandler: {(responseObject: NSDictionary) -> Void in
            //print("isAccessToken\(isAccessToken)")
            if (apiTask == TaskType.kTaskResgister || apiTask == TaskType.kTaskLogin || apiTask == TaskType.kTaskVarification || apiTask == TaskType.kTaskGetStoreList || apiTask == TaskType.kTaskGetCouponList || apiTask == TaskType.kTaskVerifyStorePin || apiTask == TaskType.kTaskGetHelpITServices || apiTask == TaskType.kTaskGetHelpITSPList || apiTask == TaskType.kTaskGetHelpITFillForm || apiTask == TaskType.kTaskGetOutletList || apiTask == TaskType.kTaskGetProductList || apiTask == TaskType.kTaskGetFAQ || apiTask == TaskType.kTaskGetPaymentHistoryList || apiTask == TaskType.kTaskGetServiceCharges || apiTask == TaskType.kTaskBookACab || apiTask == TaskType.kTaskGetAcInfo || apiTask == TaskType.kTaskNotificationList || apiTask == TaskType.kTaskSendCartOnServer || apiTask == TaskType.kTaskPaymentRequest || apiTask == TaskType.kTaskGetWalletAmount || apiTask == TaskType.kTaskUpdateWalletAmount || apiTask == TaskType.kTaskPaymentRequestWallet || apiTask == TaskType.kTaskGetContactList || apiTask == TaskType.kTaskCountryList || apiTask == TaskType.kUserProfileDetailList)
            {
                //=> code for set progressbar for hide
            }
            completionBlock(responseObject )
        })
    }
    //1.
    func httpMakeRequest(with method: HTTPMethod, url urlStr: String,param parameters: AnyObject, completionHandler completionBlock:@escaping (_ responseObject: NSDictionary) -> Void)
    {
        
        switch method {
            
        case .get: break
            
            //GET
            
        case .post:
            
            /*
             
             let headers = [
             
             "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
             
             "Accept": "application/json"
             
             ]
             
             */
            
            if urlStr.contains("/Celebrations/")
            {
                print("Enters in request manager")
                let manager = Alamofire.SessionManager.default
                manager.session.configuration.timeoutIntervalForRequest = 120

                manager.request(urlStr, method: .post, parameters: parameters as? [String : AnyObject],encoding: JSONEncoding.default, headers: nil).responseJSON {
        response in
        switch response.result
        {
            
        case .success:
             SVProgressHUD.dismiss()
            //uncommmet it after test
            //print(response)
            if response.result.value != nil
            {
                // print( response.result.value)
                var dictResponseData:NSDictionary=NSDictionary()
                dictResponseData = response.result.value as! NSDictionary
                //Uncomment it after test
               // print(dictResponseData)
                print("Actual Response on \(Date())")
                completionBlock(dictResponseData)
            }
            break
        case .failure(let error):
            print("API NAME: \(urlStr) \n  RESPONSE ERROR: \(error)")
            print("Response error localized description \(error.localizedDescription)")
            //print(urlStr)
            // print(parameters)
            error.localizedDescription
            var dictResponseData:NSDictionary=NSDictionary()
            dictResponseData = ["serverError":"Error","ErrorName":"Request time out."]
            completionBlock(dictResponseData)
             SVProgressHUD.dismiss()
         }
      }
  }
  else{
  Alamofire.request(urlStr, method: .post, parameters: parameters as? [String : AnyObject],encoding: JSONEncoding.default, headers: nil).responseJSON {
      response in
      switch response.result
      {
      case .success:
          //uncommmet it after test
          //print(response)
          if response.result.value != nil
          {
              // print( response.result.value)
              var dictResponseData:NSDictionary=NSDictionary()
              dictResponseData = response.result.value as! NSDictionary
              //Uncomment it after test
             // print(dictResponseData)
              print("Actual Response on non celebration \(Date())")
              
              completionBlock(dictResponseData)
          }
          break
      case .failure(let error):
          print("API NAME: \(urlStr) \n RESPONSE ERROR: \(error)")
          print("Response error localized description \(error.localizedDescription)")
          //print(urlStr)
          // print(parameters)
          error.localizedDescription
          var dictResponseData:NSDictionary=NSDictionary()
          dictResponseData = ["serverError":"Error"]
          completionBlock(dictResponseData)
          //SVProgressHUD.dismiss()
       }
    }
  }

        case .put:
            var vard=""
        case .delete:
            
            var vard=""
            
            //DELETE
            
            
            
        case .patch:
            
            var vard=""
            
            //PATCH
            
            
            
        default:
            
            break
            
        }
    }
    
    
    //2.
    func webserviceWithRequestMethodIMAGE(_ method:HTTPMethod, url urlStr: String, parameters: [AnyHashable: Any], forTask apiTask: TaskType, currentView view: UIView, useAccessToken isAccessToken: Bool, completionHandler completionBlock: (_ response: AnyObject) -> Void)
    {
        if (apiTask == TaskType.kTaskResgister || apiTask == TaskType.kTaskLogin || apiTask == TaskType.kTaskVarification || apiTask == TaskType.kTaskGetStoreList || apiTask == TaskType.kTaskGetCouponList || apiTask == TaskType.kTaskVerifyStorePin || apiTask == TaskType.kTaskGetHelpITServices || apiTask == TaskType.kTaskGetHelpITSPList || apiTask == TaskType.kTaskGetHelpITFillForm || apiTask == TaskType.kTaskGetOutletList || apiTask == TaskType.kTaskGetProductList || apiTask == TaskType.kTaskGetFAQ || apiTask == TaskType.kTaskGetPaymentHistoryList || apiTask == TaskType.kTaskGetServiceCharges || apiTask == TaskType.kTaskBookACab || apiTask == TaskType.kTaskGetAcInfo || apiTask == TaskType.kTaskNotificationList || apiTask == TaskType.kTaskSendCartOnServer || apiTask == TaskType.kTaskPaymentRequest || apiTask == TaskType.kTaskGetWalletAmount || apiTask == TaskType.kTaskUpdateWalletAmount || apiTask == TaskType.kTaskPaymentRequestWallet || apiTask == TaskType.kTaskGetContactList || apiTask == TaskType.kTaskCountryList || apiTask == TaskType.kUserProfileDetailList)
        {
            //=> code for set progressbar for show
        }
        self.httpMakeRequestIMNAGE(with: method, url: urlStr,param: parameters as AnyObject, completionHandler: {(responseObject: NSDictionary) -> Void in
        //    print("isAccessToken 2 : \(isAccessToken)")
            if (apiTask == TaskType.kTaskResgister || apiTask == TaskType.kTaskLogin || apiTask == TaskType.kTaskVarification || apiTask == TaskType.kTaskGetStoreList || apiTask == TaskType.kTaskGetCouponList || apiTask == TaskType.kTaskVerifyStorePin || apiTask == TaskType.kTaskGetHelpITServices || apiTask == TaskType.kTaskGetHelpITSPList || apiTask == TaskType.kTaskGetHelpITFillForm || apiTask == TaskType.kTaskGetOutletList || apiTask == TaskType.kTaskGetProductList || apiTask == TaskType.kTaskGetFAQ || apiTask == TaskType.kTaskGetPaymentHistoryList || apiTask == TaskType.kTaskGetServiceCharges || apiTask == TaskType.kTaskBookACab || apiTask == TaskType.kTaskGetAcInfo || apiTask == TaskType.kTaskNotificationList || apiTask == TaskType.kTaskSendCartOnServer || apiTask == TaskType.kTaskPaymentRequest || apiTask == TaskType.kTaskGetWalletAmount || apiTask == TaskType.kTaskUpdateWalletAmount || apiTask == TaskType.kTaskPaymentRequestWallet || apiTask == TaskType.kTaskGetContactList || apiTask == TaskType.kTaskCountryList || apiTask == TaskType.kUserProfileDetailList)
            {
                //=> code for set progressbar for hide
            }
            completionBlock(responseObject )
        })
    }
    func httpMakeRequestIMNAGE(with method: HTTPMethod, url urlStr: String,param parameters: AnyObject, completionHandler completionBlock:(_ responseObject: NSDictionary) -> Void)
    {
        

        var parameters = [String:AnyObject]()
        parameters = [
            "name":"announcement" as AnyObject]
        
        let URL = baseUrl+touchBase_UploadImag
        let imageT = UIImage(named: "indicatorNew.png")
        /*myy code
        Alamofire.upload(.POST, URL, multipartFormData: {
            multipartFormData in
            
            if let imageData = UIImageJPEGRepresentation(imageT!, 0.6) {
                multipartFormData.appendBodyPart(data: imageData, name: "image", fileName: "file.png", mimeType: "image/png")
            }
            
            for (key, value) in parameters {
                multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
            }
        }, encodingCompletion: {
            encodingResult in
            
            switch encodingResult {
            case .Success(let upload, _, _):
        
                print("s")
                upload.responseJSON
                    {
                        response in
                        print(response.request)  // original URL request
                        print(response.response) // URL response
                        print(response.data)     // server data
                        print(response.result)   // result of response serialization
                        
                        if let JSON = response.result.value
                        {
                            print("JSON: \(JSON)")
                        }
                }
            case .Failure(let encodingError):
                print(encodingError)
            }
        })
 */
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
     //2.
     func HTTPMakeRequestWithMethod(method: HTTPMethod, url urlStr: String, parameters: [NSObject : AnyObject], completionHandler completionBlockNew: (responseObject: AnyObject) -> Void)
     {
     
     var error: NSError?
     let parameters = [
     "groupProfileID" : "6494",
     "month" : "November",
     "year" : "2016",
     "moduleID" : "17"
     
     ]
     
     
     let headers = [
     "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
     "Accept": "application/json"
     ]
     Alamofire.request(.POST,baseUrl, parameters: parameters, encoding: .JSON, headers: nil).responseJSON { response in
     if response.result.value != nil
     {
     
     print( response.result.value)
     
     
     
     var dictResponseData:NSDictionary=NSDictionary()
     dictResponseData = response.result.value as! NSDictionary
     
     
     // completionBlock(responseObject, nil);
     var error: NSError?
     
     // completionBlockNew(responseObject: response.result.value!, error: error!)
     
     // completionBlock(responseObject: dictResponseData, error: error!)
     
     print(dictResponseData)
     let varGetMessage = dictResponseData.valueForKey("TBAttendanceListResult")!.valueForKey("message") as! String
     let varGetStatus =  dictResponseData.valueForKey("TBAttendanceListResult")!.valueForKey("status") as! String
     if(varGetMessage=="success" && varGetStatus=="0")
     {
     for i in 0 ... dictResponseData.valueForKey("TBAttendanceListResult")!.valueForKey("AttendanceListResult")!.valueForKey("AttendanceResult")!.count-1
     {
     let letGetName=((dictResponseData.valueForKey("TBAttendanceListResult")!.valueForKey("AttendanceListResult")!.valueForKey("AttendanceResult")!.valueForKey("name") as! NSArray)[i])
     let letGetAttendance=((dictResponseData.valueForKey("TBAttendanceListResult")!.valueForKey("AttendanceListResult")!.valueForKey("AttendanceResult")!.valueForKey("attendence") as! NSArray)[i])
     let letGetId=((dictResponseData.valueForKey("TBAttendanceListResult")!.valueForKey("AttendanceListResult")!.valueForKey("AttendanceResult")!.valueForKey("idno") as! NSArray)[i])
     print(letGetName)
     print(letGetAttendance)
     print(letGetId)
     
     }
     }
     }
     }
     }
     /*-end----------------------------------------------------------------------------------------------------------------------------------------------------------------*/
     
     
     func dsdfd()
     {
     let headers = [
     "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
     "Accept": "application/json"
     ]
     
     let parameters: [String: Any] = [
     "IdQuiz" : 102,
     "IdUser" : "iosclient",
     "User" : "iosclient",
     "List": [
     [
     "IdQuestion" : 5,
     "IdProposition": 2,
     "Time" : 32
     ],
     [
     "IdQuestion" : 4,
     "IdProposition": 3,
     "Time" : 9
     ]
     ]
     ]
     
     Alamofire.request(.POST, "", parameters: [:], encoding: .JSON, headers: headers).responseJSON { response in
     
     }
     Alamofire.request(.GET, "http://httpbin.org/get", parameters: ["foo": "bar"])
     .response { (request, response, data, error) in
     print(request)
     print(response)
     print(error)
     }
     Alamofire.request(.GET, "http://httpbin.org/get")
     .response { (request, response, data, error) in
     print(request)
     print(response)
     print(error)
     }
     Alamofire.request(.GET, "http://httpbin.org/get")
     .authenticate(user: "", password: "")
     .progress { (bytesRead, totalBytesRead, totalBytesExpectedToRead) in
     print(totalBytesRead)
     }
     
     ///
     let parameterss = [
     "foo": "bar",
     "baz": ["a", 1],
     "qux": [
     "x": 1,
     "y": 2,
     "z": 3
     ]
     ]
     
     Alamofire.request(.POST,"https://yourServiceURL.com", parameters: parameterss, encoding: .JSON, headers: nil).responseJSON { response in
     print(response.result.value)
     }
     }
     */
}
