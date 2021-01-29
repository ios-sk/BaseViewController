//
// SKNetworkingTool.m
//
// Created on 2021/1/20
//

#import "SKNetworkingTool.h"

@implementation SKNetworkingTool

+ (AFHTTPSessionManager *)shareSessionManager{
    static AFHTTPSessionManager * manager = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate,^
                  {
        //                      if ([SERVER_DEV containsString:@"www.saywash.com"]) {
        //                          manager =[[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:@"https://www.saywash.com"]];
        //                          [manager setSecurityPolicy:[RequestDataManager customSecurityPolicy]];
        //
        //                      }else{
        //                          manager = [AFHTTPSessionManager manager];
        //                          AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        //                          // 是否在证书的CN字段中验证域名。默认为“是”。
        //                          [securityPolicy setValidatesDomainName:NO];
        //                          // 是否信任具有无效或过期SSL证书的服务器。默认为“不”。
        //                          securityPolicy.allowInvalidCertificates = YES; //还是必须设成YES
        //                          manager.securityPolicy = securityPolicy;
        //                      }
        
        manager = [AFHTTPSessionManager manager];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        // 是否在证书的CN字段中验证域名。默认为“是”。
        [securityPolicy setValidatesDomainName:NO];
        // 是否信任具有无效或过期SSL证书的服务器。默认为“不”。
        securityPolicy.allowInvalidCertificates = YES; //还是必须设成YES
        manager.securityPolicy = securityPolicy;
        
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json", @"application/xml",@"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*"]];
        
        manager.requestSerializer.timeoutInterval = 30;
        
    });
    return manager;
}

@end
