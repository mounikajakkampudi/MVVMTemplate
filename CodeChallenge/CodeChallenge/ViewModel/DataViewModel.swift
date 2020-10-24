//
//  DataViewModel.swift
//  CodeChallenge
//
//  Created by Mounika Jakkampudi on 10/9/20.
//  Copyright © 2020 MVVM. All rights reserved.
//

import Foundation

class DataViewModel {
    var childrensList = [Children]()
    var afterLink = ""

    // Return ChildrenDataObject to UITableView cellForRow
    func getChildrenObjectAtIndex(index: Int) -> ChildrenDataObject {
        return childrensList[index].data ?? ChildrenDataObject()
    }
    // Return ChildrenDataObject count to UITableView numberOfRowsInSection
    func getChildrenObjectCount() -> Int {
        return childrensList.count
    }
}

extension DataViewModel {
    // Fetch call to NetworkManager to get ResponseDataObject of Feeds list
    func fetchChildrensList(completion: @escaping (Result<Bool, Error>) -> Void) {
        NetworkManager.shared.get(urlString: baseUrl + afterLink, completionBlock: { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data) :
                // Decode JSON Data with JSONDecoder to Data Model
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let dataObject = try decoder.decode(ResponseDataObject.self, from: data)
                    self.childrensList.append(contentsOf: dataObject.data?.children ?? [Children]())
                    self.afterLink = dataObject.data?.after ?? ""
                    completion(.success(true))
                } catch {
                    #if DEBUG
                    print("failed to decode json \(error)")
                    #endif
                    completion(.success(false))
                }
            }
        })
    }
}
