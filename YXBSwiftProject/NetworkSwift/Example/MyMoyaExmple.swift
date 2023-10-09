//
//  MyMoyaExmple.swift
//  MyNetWork
//
//  Created by 杨晓斌 on 2023/7/19.
//

import Moya


// MARK: - 这是一个示例，使用NetworkManager进行请求的

// 模型, 并非要遵守MyBaseModelProtocol, 网络请求只是把网络数据返回了，解析可以自己的第三方，如SwiftJson,HandyJson
struct CatModel: MyBaseModelProtocol {
    let id: String
    let url: String
    let width, height: CGFloat
}

// API枚举，需要遵守APIService协议
enum CatAPI {
    /// 获取一个猫咪的信息
    case getOneCat
    /// 获取10个猫, 注意get中url里面？后的要当参数传递
    case getTenCats(limit: Int)
    /// 点赞和取消点赞， value=1点赞  value=-1取消点赞
    case voteImage(image_id: String, value: Int)
    /// 收藏
    case favourites(image_id: String)
    /// 取消收藏
    case notFavourites(favouriteId: String)
}

extension CatAPI: APIService {
    var route: APIRoute {
        switch self {
        case .getOneCat: return .get("/v1/images/search")
        case .getTenCats: return .get("/v1/images/search")
        case .voteImage(_, _): return .post("/v1/votes")
        case .favourites(_): return .post("/v1/favourites")
        case .notFavourites(let favouriteId): return .delete("/v1/favourites/\(favouriteId)")
        }
    }
    
    var parameters: APIParameters? {
        // 需要的参数和，解析方法，解析方式可以为空。
        typealias PE = (parameters: [String: Any], encoding: ParameterEncoding?)
        var result: PE = ([:], nil)
        
        switch self {
        case .getTenCats(let limit):
            result.parameters = ["limit": limit]
            
        case let .voteImage(image_id, value):
            result.parameters = ["image_id": image_id, "value": value]
        
        case .favourites(let image_id):
            result.parameters = ["image_id": image_id]
        
        default:
            return nil
        }
                
        return APIParameters(values: result.parameters, encoding: result.encoding)
    }
    
    var headers: [String : String]? {
        ["x-api-key": "live_g3h0QDMzhjyT8OvVMZ8oZP1F41zqHFdbQ05KHof8nX0fQ7TmNFVr8tkVR3OD3pDH",
         "content-type":"application/json"]
    }
}


// MARK: - 使用示例代码，
struct SuiBianBa {
    
    // 使用请求
    func requestOneCatInfo() {
        let network = NetworkManager<CatAPI>()
        network.sendRequest(.getOneCat) { jsonString in
            
//            if let model = try? JSONDecoder().decode([CatModel].self, from: jsonString.data(using: .utf8)!) {
//                print("我的猫咪模型", model)
//            }
            
        } failure: { error in
            print("我打印的错误:", error)
        }
    }
    
    // 使用请求
    func requestTenCatInfo() {
        let network = NetworkManager<CatAPI>()
        network.sendRequest(.getTenCats(limit: 10)) { jsonString in
            
//            if let model = try? JSONDecoder().decode([CatModel].self, from: jsonString.data(using: .utf8)!) {
//                print("我的猫咪模型", model)
//            }
            
        } failure: { error in
            print("我打印的错误:", error)
        }
    }
    
    // 使用点赞
    func requesVote() {
        let network = NetworkManager<CatAPI>()
        let target: CatAPI = .voteImage(image_id: "7mm", value: -1)
        network.sendRequest(target) { jsonString in
            print("点赞操作成功", jsonString)
        } failure: { error in
            print("点赞失败", error)
        }
    }
    
    // 请求收藏
    func requestFavorite() {
        let network = NetworkManager<CatAPI>()
        let target: CatAPI = .favourites(image_id: "4eh")
        network.sendRequest(target) { jsonString in
            print("收藏操作成功", jsonString)
        } failure: { error in
            print("收藏失败", error)
        }
    }
    
    // 取消收藏
    func rquestCancelFavourites() {
        let network = NetworkManager<CatAPI>()
        let target: CatAPI = .notFavourites(favouriteId: "232367120")
        network.sendRequest(target) { jsonString in
            print("取消收藏操作成功", jsonString)
        } failure: { error in
            print("取消收藏失败", error)
        }
        
    }
}
