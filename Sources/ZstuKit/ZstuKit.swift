import Foundation

public class ZKSsoLoginSession {
    
}

public class ZKSsoLoginSessionDelegate {
    
}

public enum ZKSsoLoginError: LocalizedError {
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

