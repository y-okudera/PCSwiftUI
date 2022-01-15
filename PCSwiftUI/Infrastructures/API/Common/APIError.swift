//
//  APIError.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/05.
//

import Foundation

enum APIError: Error {
  /// 通信エラー
  case cannotConnected
  /// 不正なレスポンス
  case invalidResponse(Error)
  /// ステータスコード400番台
  case clientError(Int)
  /// ステータスコード500番台
  case serverError(Int)
  /// レスポンスデータのdecodeに失敗
  case decodeError(DecodingError)
  /// その他のエラー
  case unknown(Error)

  init(error: Error) {
    if let apiError = error as? APIError {
      self = apiError
      return
    }

    if let urlError = error as? URLError {
      switch urlError.code {
      case .timedOut,
        .cannotFindHost,
        .cannotConnectToHost,
        .networkConnectionLost,
        .dnsLookupFailed,
        .httpTooManyRedirects,
        .resourceUnavailable,
        .notConnectedToInternet,
        .secureConnectionFailed,
        .cannotLoadFromNetwork:
        self = APIError.cannotConnected
      default:
        self = APIError.unknown(error)
      }
      return
    }

    // errorがAPIErrorでもURLErrorでもない場合
    self = APIError(error: error)
  }
}

extension APIError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .cannotConnected:
      return "通信に失敗しました。"
    case .invalidResponse:
      return "不正なレスポンスを取得しました。"
    case .clientError(let statusCode):
      return "クライアントエラー(\(statusCode))"
    case .serverError(let statusCode):
      return "サーバーエラー(\(statusCode))"
    case .decodeError:
      return "デコードエラー"
    case .unknown:
      return "その他エラー"
    }
  }

  var recoverySuggestion: String? {
    switch self {
    case .cannotConnected:
      return "通信環境の良い場所で再度お試しください。"
    case .invalidResponse(let error):
      return (error as NSError).localizedRecoverySuggestion ?? error.reflectedString
    case .clientError:
      return nil
    case .serverError:
      return nil
    case .decodeError(let decodingError):
      return (decodingError as NSError).localizedRecoverySuggestion ?? decodingError.reflectedString
    case .unknown(let error):
      return (error as NSError).localizedRecoverySuggestion ?? error.reflectedString
    }
  }
}
