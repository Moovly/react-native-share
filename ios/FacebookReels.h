

#import <UIKit/UIKit.h>
// import RCTConvert
#import <React/RCTConvert.h>
// import RCTBridge
#import <React/RCTBridge.h>
// import RCTUIManager
#import <React/RCTUIManager.h>
// import RCTLog
#import <React/RCTLog.h>
// import RCTUtils
#import <React/RCTUtils.h>
@interface FacebookReels : NSObject <RCTBridgeModule>

- (void *) shareSingle:(NSDictionary *)options failureCallback:(RCTResponseErrorBlock)failureCallback successCallback:(RCTResponseSenderBlock)successCallback;
@end
