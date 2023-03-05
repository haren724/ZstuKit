import Foundation

public class ZKSsoUserData {
    public var username: String
    public var password: String
    
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
    
    init(userData: ZKSsoUserData) {
        self.userData = userData
    }
    
    init(_ userData: ZKSsoUserData) {
        self.userData = userData
    }
    
    public func login() async {
        
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

