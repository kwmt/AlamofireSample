//
//  APIRequest.swift
//  AlamofireSample
//

import Alamofire

class APIRequest {
  
  private static var instance:APIRequest?
  
  
  /** シングルトンなファクトリメソッド */
  class var sharedInstance:APIRequest {
    get {
      if let instance = instance {
        return instance
      } else {
        self.instance = APIRequest()
        return self.instance!
      }
    }
  }
  
  
  private init(){}
  
  
  
  // 参考 Alamofire#URLRequestConvertible
  // https://github.com/Alamofire/Alamofire#urlrequestconvertible
  private enum Router: URLRequestConvertible {
    static let baseURLString = "http://httpbin.org"
    static let baseUrl = NSURL(string: Router.baseURLString)!
    
    case CreateUser([String: AnyObject])
    case ReadUser(String)
    case UpdateUser(String, [String: AnyObject])
    case DestroyUser(String)
    
    var method: Alamofire.Method {
      switch self {
      case .CreateUser:
        return .POST
      case .ReadUser:
        return .GET
      case .UpdateUser:
        return .PUT
      case .DestroyUser:
        return .DELETE
      }
    }
    
    var path: String {
      switch self {
      case .CreateUser:
        return "/users"
      case .ReadUser(let username):
        return "/\(username)"
      case .UpdateUser(let username, _):
        return "/users/\(username)"
      case .DestroyUser(let username):
        return "/users/\(username)"
      }
    }
    // MARK: URLRequestConvertible
    
    var URLRequest: NSURLRequest {
      let URL = NSURL(string: Router.baseURLString)!
      let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
      mutableURLRequest.HTTPMethod = method.rawValue
      
      
      switch self {
      case .CreateUser(let parameters):
        return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
      case .UpdateUser(_, let parameters):
        return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters).0
      default:
        return mutableURLRequest
      }
    }

  }
  
  func readUser(completion:(json:success:Bool, error:NSError?) -> Void){
    let request = Alamofire.request(Router.ReadUser("get")) // GET /users/
    //https://github.com/Alamofire/Alamofire#response-json-handler
    request.responseJSON(){
      (request, response, jsonData, error) in
      println("request:\(request)\n, response:\(response)\n, jsonData:\(jsonData)\n, error:\(error)")
      let success = error == nil
      if !success {
        completion(success: false, error: error)
        return
      }
      //jsonデータをモデルにマッピングしておいて、呼び出し元に返す
      // ...
      completion(success: true, error: nil)
    }
  }
  

  
  
}