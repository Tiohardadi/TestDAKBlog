//
//  NetworkServices.swift
//  TestDAKBlog
//
//  Created by Tio Hardadi Somantri on 11/3/23.
//

import UIKit

enum HttpMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

class NetworkServices {
    let baseUrl = "http://localhost:8000/api"
    let userDefaults = UserDefaults.standard
    func getAccessToken() -> String {
        return userDefaults.string(forKey: "accessToken") ?? ""
    }
    func authLogin(
//        email: String, password: String,
        completion: @escaping (Result<UserResponse, Error>) -> Void) {
        let endPoint = self.baseUrl
        
//        let bodyData = """
//        {
//            "email" : "\(email)",
//            "password" : "\(password)"
//        }
//        """.data(using: String.Encoding.utf8)!
        let bodyData = """
        {
            "email" : "user@example.com",
            "password" : "string"
        }
        """.data(using: String.Encoding.utf8)!
        guard let urlComponents = URLComponentsBuilder(baseURL: endPoint)
                .path("/login")
                .buildUrl()
        else { return }
        
        let urlRequest = URLRequestBuilder(url: urlComponents)
            .httpMethod(.POST)
            .addBody(data: bodyData)
            .build()
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            print(response as Any)
            guard let data = data else { return }
            if let error = error {
                print(error.localizedDescription)
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let jsonSerial = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("jSON serial" , jsonSerial)
                let session = try jsonDecoder.decode(UserResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(session))
                }
                
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func authRegister(fullName: String, email: String, password: String, completion: @escaping (Result<UserResponse, Error>) -> Void) {
        let endPoint = self.baseUrl

        let bodyData = """
        {
            "name" : "\(fullName)",
            "email" : "\(email)",
            "password" : "\(password)"
        }
        """.data(using: String.Encoding.utf8)!
//        print(bodyData.data(using: String.Encoding.utf8)!)
        guard let urlComponents = URLComponentsBuilder(baseURL: endPoint)
                .path("/register")
                .buildUrl()
        else { return }

        let urlRequest = URLRequestBuilder(url: urlComponents)
            .httpMethod(.POST)
            .addBody(data: bodyData)
            .build()

        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            let _ = response as? HTTPURLResponse

            guard let data = data else { return }
            if let error = error {
                print(error.localizedDescription)
            }
            _ = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            let jsonDecoder = JSONDecoder()
            do {
                let session = try jsonDecoder.decode(UserResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(session))
                }

            } catch let error {
                completion(.failure(error.localizedDescription as! Error))
            }
        }.resume()
    }
    
    
    func getArticle(completion: @escaping(Result<ArticleResponse, Error>)  -> Void) {
        let endPoint = self.baseUrl

        guard let urlcomponents = URLComponentsBuilder(baseURL: endPoint)
            .path("/articles")
            .buildUrl()
        else { return }
        var urlRequest = URLRequestBuilder(url: urlcomponents)
            .httpMethod(.GET)
            .build()
        urlRequest.setValue("Bearer \(getAccessToken())", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            do {
                let session = try JSONDecoder().decode(ArticleResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(session))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()

    }
    
    func addArticle(title: String, description: String, completion: @escaping (Result<AddArticleResponse, Error>) -> Void) {
        let endPoint = self.baseUrl
        let bodyData = """
        {
            "title": \(title),
            "description": \(description)
        }
        """.data(using: String.Encoding.utf8)!
        guard let urlComponents = URLComponentsBuilder(baseURL: endPoint)
                .path("/articles")
                .buildUrl()
        else { return }
        var urlRequest = URLRequestBuilder(url: urlComponents)
            .httpMethod(.POST)
            .addBody(data: bodyData)
            .build()
        urlRequest.setValue("Bearer 18|i7hX0rfBuQ3Gz237M0YXhS8nRHlf2W1Cf1zISWsfaf01dad8", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            if let error = error {
                print(error.localizedDescription)
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let jsonSerial = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let session = try jsonDecoder.decode(AddArticleResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(session))
                }
                
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
//    func getProductBy(id: Int, user: UserEndpoint, completion: @escaping(ProductDetail) -> Void) {
//        let endPoint = self.baseUrl
//
//        guard let urlcomponents = URLComponentsBuilder(baseURL: endPoint)
//            .path(user.rawValue)
//            .path("/product")
//            .path("/\(id)")
//            .buildUrl()
//        else { return }
//
//        AF.request(urlcomponents.absoluteString, method: .get).validate()
//            .responseDecodable(of: ProductDetail.self) { result in
//                if let value = result.value {
//                    completion(value)
//                }
//        }
//    }
    

//
//    func createProduct(name: String, description: String, price: Int, category: Int, location: String, image: Data, completion: @escaping (Result<reponseProduct, Error>) -> Void) {
//        let baseUrl = self.baseUrl
//        let fullUrl = baseUrl + "/seller/product"
//        let headers : Alamofire.HTTPHeaders = [
//                    "access_token" : getAccessToken(),
//                    "cache-control" : "no-cache",
//                    "Accept-Language" : "en",
//                    "Connection" : "close",
//                    "Content-type" : "multipart/form-data"
//                ]
//                AF.upload(
//                multipartFormData: { multipartFormData in
//                    multipartFormData.append(image, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
//                    multipartFormData.append(name.data(using: .utf8)!, withName: "name")
//                    multipartFormData.append(description.data(using: .utf8)!, withName: "description")
//                    multipartFormData.append("\(price)".data(using: .utf8)!, withName: "base_price")
//                    multipartFormData.append("\(category)".data(using: .utf8)!, withName: "category_ids")
//                    multipartFormData.append(location.data(using: .utf8)!,  withName: "location")
//                },
//                to: fullUrl, usingThreshold: .max,
//                    method: .post,
//                    headers: headers)
//                .responseDecodable(of: reponseProduct.self) { (response) in
//                    switch response.result{
//                    case .success(let value):
//                        print("Json: \(value)")
//                        completion(.success( value ))
//                    case .failure(let error):
//                        print("Error: \(error.localizedDescription)")
//                        completion(.failure(error))
//                    }
//                }.uploadProgress { (progress) in
//                    print("Progress: \(progress.fractionCompleted)")
//                }
//    }
    
}
