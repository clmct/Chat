//
//  RequestMock.swift
//  RequestMock
//
//  Created by Алмат Кульбаев on 03.12.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation
@testable import ChatTF

final class RequestMock: RequestProtocol {
  var urlRequest: URLRequest?
}
