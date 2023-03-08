import Foundation
import JavaScriptCore

public class ZKSsoUserData {
    public var username: String
    public var password: String
    
    public var isSsoAuthorized: Bool { false }
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    init(_ username: String, _ password: String) {
        self.username = username
        self.password = password
    }
}

public class ZKSsoAuthSession {
    private(set) var userData: ZKSsoUserData
    private var session: URLSession
    
    private(set) var crypto: String = .init()
    private(set) var execution: String = .init()
    
    init(userData: ZKSsoUserData) {
        self.userData = userData
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5
        configuration.httpShouldSetCookies = true
        self.session = .init(configuration: configuration)
    }
    
    convenience init(_ userData: ZKSsoUserData) {
        self.init(userData: userData)
    }
    
    public func login() async throws {
        try await getCryproAndExecution()
    }
    
    private func getCryproAndExecution() async throws {
    //  初始化匹配HTML文本中`croypto`和`execution`字段的正则表达式
        let cryptoReg = try Regex("<p id=\"login-croypto\">(.*?)</p>")
        let executionReg = try Regex("<p id=\"login-page-flowkey\">(.*?)</p>")
        
    //  获取sso登录页面的HTML文本内容
        let (data, _) = try await session.data(from: URL(string: "https://sso.zstu.edu.cn/login")!)
    //  将HTML的Data类型转换成String
        guard let dataString = String(data: data, encoding: .utf8) else {
            print("invalid dataString")
            return
        }
    //  解析出`croypto`和`execution`字段
        guard let cryptoMatched = dataString.firstMatch(of: cryptoReg)?.last?.substring,
              let executionMatched = dataString.firstMatch(of: executionReg)?.last?.substring else {
            return
        }
        self.crypto = String(cryptoMatched)
        self.execution = String(executionMatched)
    }
}

public enum ZKSsoAuthError: LocalizedError {
    case wrongUsernameOrPassword, unknownError, timeOut
    
    public var errorDescription: String? {
        switch self {
        case .wrongUsernameOrPassword:
            return "账号或密码错误"
        case .unknownError:
            return "未知错误"
        case .timeOut:
            return "请求超时，请检查网络状态"
        }
    }
}

