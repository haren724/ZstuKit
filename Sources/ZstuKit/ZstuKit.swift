import Foundation

public protocol ZKSsoAuthDelegate {
    func login() async
}

public class ZKSsoAuthUser {
    public var username: String
    public var password: String
    
    private(set) var delegate: ZKSsoAuthDelegate?
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    init(_ username: String, _ password: String) {
        self.username = username
        self.password = password
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

