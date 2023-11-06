//
//  ImageCache.swift
//  voice
//
//  Created by Mac on 2023/3/22.
//

import UIKit
import SDWebImage
import CommonCrypto


@objc class YXBImageCache: NSObject {
    
    /*
    static func getImage(with url: URL , scale : CGFloat = 1) -> UIImage? {
        
        if let image = SDImageCache.shared.imageFromCache(forKey: url.absoluteString) {
            return UIImage.init(data: image.sd_imageData()!, scale: scale)
            
        } else {
            if let imageData = try? Data(contentsOf: url),
               let image = UIImage(data: imageData,scale: scale) {
                SDImageCache.shared.store(image, forKey: url.absoluteString, completion: nil)
                debugPrint("图片下载成功")
                return image
            }
            debugPrint("图片下载失败：\(url)")
            return nil
        }
    }
    */
    
    /// 修改了取图的方法 ,，示例
    /// DispatchQueue.global().async() {
    /// let image = ImageCache.getImage(with: URL(string: iconImg)!)
    ///     DispatchQueue.main.async {
    ///         回到主线程使用
    ///     }
    /// }

    static func getImage(with url: URL , scale : CGFloat = 1) -> UIImage? {
        var resultImage: UIImage?
        // 全局队列 + 同步执行。 效果等同于。  全局队列+异步执行+信号量为0。 为了等待block结果
        let queue = DispatchQueue.global()
        let semaphore = DispatchSemaphore(value: 0)
        queue.async {
            debugPrint("准备读取图片线程\(Thread.current)")
            self.getImageClosure(with: url, scale: scale) { image in
                resultImage = image
                debugPrint("真正的获取到图片, 的线程\(Thread.current)")
                semaphore.signal()
            }
        }
        semaphore.wait()
        debugPrint("返回图片结果的线程\(Thread.current)")
        return resultImage
    }
    
    // 包含一层闭包为了让异步方法能变回为正常同步方法，避免层层修改。 目前没有好的解决方案，或许是我没找到。
    static func getImageClosure(with url: URL , scale : CGFloat = 1, completeHandle: @escaping (_ image: UIImage?) -> Void ) {
        Task {
            let sd_image = await downloadImage(with: url, scale: scale)
            completeHandle(sd_image)
        }
    }
        
    // 使用swift新特性 异步函数
    private static func downloadImage(with url: URL? , scale : CGFloat = 1) async -> UIImage? {
        do {
            // 把三方库或其他block转化为 async throw的异步方法
            let continuation = try await withCheckedThrowingContinuation { (continuation:CheckedContinuation<UIImage?,Error>) in
                
                // SDWebImage取图
                SDWebImageManager.shared.loadImage(with: url, progress: nil) {image, data, error, type, result, url1 in
                    if error != nil {
                        debugPrint("图片下载失败：\(String(describing: url1 ?? URL(string: "")))")
                        continuation.resume(throwing: error!)
                    } else {
                        debugPrint("图片下载/加载成功")
                        continuation.resume(returning: UIImage.init(data: image!.sd_imageData()!, scale: scale))
                    }
                }
                
            }
            return continuation
        } catch  {
            return nil
        }
    }
    
    
    // 批量下载图片
    static func getImages(with urls: [String], completeHandle: @escaping (_ images: [UIImage]) -> Void) {
        if urls.isEmpty { completeHandle([])}
        
        var tempImages = [UIImage?](repeating: nil, count: urls.count)
        
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "downloadimages")
        
        for (i, url) in urls.enumerated() {
            
            group.enter()
            queue.async(group: group, execute: {
                
                getImageClosure(with: URL(string: url)!) { image in
                    if image != nil {
                        tempImages[i] = image
                    }
                    group.leave()
                }
            })
        }
        
        group.notify(queue: DispatchQueue.main) {
            let images = tempImages.compactMap({$0})
            completeHandle(images)
        }
    }
    
    // 并返回图片在缓存中的路径
    static func getCachedImagePath(for urlString: String) -> String? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        let cacheKey = SDWebImageManager.shared.cacheKey(for: url)
        let cachedImagePath = SDImageCache.shared.cachePath(forKey: cacheKey)
        return cachedImagePath
    }
    
    /// 获取图片的本地路径，如果没有就去下载
    static func getImageLocalPath(urlString: String, completion: @escaping (_ url: String, _ path: String?) -> Void) {
        // 先看看本地缓存是否存在
        if let path = YXBImageCache.getCachedImagePath(for: urlString) {
            debugPrint("本地已缓存图片：", path)
            completion(urlString, path)
        } else {
            DispatchQueue.global().async {
                guard let _ = YXBImageCache.getImage(with: URL(string: urlString)!) else {
                    DispatchQueue.main.async {
                        completion(urlString, nil)
                    }
                    return
                }
                // 回到主线程使用
                DispatchQueue.main.async {
                    let path = YXBImageCache.getCachedImagePath(for: urlString)
                    completion(urlString, path)
                }
            }
        }
    }
    
    static func getResourceLocalPath(for urlString: String) -> String? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let effectsDirectory = cacheDirectory.appendingPathComponent("effects")
        let fileExtension = URL(string: urlString)?.pathExtension ?? "unknown"
        let fileName = "\(urlString.md5).\(fileExtension)"
        let fileURL = effectsDirectory.appendingPathComponent(fileName)
        return fileURL.path
    }
    
    static func getResourcePath(urlString: String, completion: @escaping (_ url: String, _ path: String?) -> Void, fail: @escaping (_ url: String, _ error: Error) -> Void) {
        let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let effectsDirectory = cacheDirectory.appendingPathComponent("effects")
        let fileExtension = URL(string: urlString)?.pathExtension ?? "unknown"
        let fileName = "\(urlString.md5).\(fileExtension)"
        let fileURL = effectsDirectory.appendingPathComponent(fileName)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            // 文件已存在于缓存目录中，直接返回文件URL和路径
            debugPrint("文件已缓存: ", urlString)
            completion(urlString, fileURL.path)
        } else {
            // 文件不存在，进行下载
            if let url = URL(string: urlString) {
                let downloadTask = URLSession.shared.downloadTask(with: url) { (location, response, error) in
                    if let error = error {
                        // 下载失败，可以在这里处理错误
                        debugPrint("下载失败：\(error)")
                        DispatchQueue.main.async {
                            fail(urlString, error)
                        }
                        return
                    }
                    
                    guard let location = location else {
                        // 下载失败，未能获取到临时文件的位置
                        debugPrint("下载失败：未能获取到临时文件的位置")
                        DispatchQueue.main.async {
                            completion(urlString, nil)
                        }
                        return
                    }
                    
                    do {
                        // 创建 effects 文件夹
                        try FileManager.default.createDirectory(at: effectsDirectory, withIntermediateDirectories: true, attributes: nil)
                        // 将临时文件移动到缓存目录
                        try FileManager.default.moveItem(at: location, to: fileURL)
                        debugPrint("下载成功，文件保存在：\(fileURL)")
                        DispatchQueue.main.async {
                            completion(urlString, fileURL.path)
                        }
                    } catch {
                        // 移动文件失败
                        debugPrint("下载成功，但移动文件失败：\(error)")
                        DispatchQueue.main.async {
                            fail(urlString, error)
                        }
                    }
                }
                
                downloadTask.resume()
            } else {
                debugPrint("下个毛啊：给的什么url", urlString)
                completion(urlString, nil)
            }
        }
    }

}


private extension String {
    var md5: String {
        let data = Data(self.utf8)
        let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
            var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
            return hash
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}


//class CustomImageCache: SKImageCacheable {
//
//    func imageForKey(_ key: String) -> UIImage? {
//        return SDImageCache.shared.imageFromCache(forKey: key)
//    }
//
//    func setImage(_ image: UIImage, forKey key: String) {
//        SDImageCache.shared.store(image, forKey: key)
//    }
//
//    func removeImageForKey(_ key: String) {
//
//    }
//
//    func removeAllImages() {
//
//    }
//}
