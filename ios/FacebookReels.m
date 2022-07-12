//
//  FacebookStories.m
//  RNShare
//
//  Created by Quynh Nguyen on 4/13/20.
//  Link: https://github.com/Quynh-Nguyen
//  Copyright © 2020 Facebook. All rights reserved.
//

// import RCTLog
#import <React/RCTLog.h>

#import "FacebookReels.h"

@implementation FacebookReels
RCT_EXPORT_MODULE();

- (void)shareSingle:(NSDictionary *)options
    failureCallback:(RCTResponseErrorBlock)failureCallback
    successCallback:(RCTResponseSenderBlock)successCallback {

    NSURL *urlScheme = [NSURL URLWithString:@"facebook-reels://share"];
    if (![[UIApplication sharedApplication] canOpenURL:urlScheme]) {
        [self fallbackFacebook];
    }

    // Create dictionary of assets and attribution
    NSMutableDictionary *items = [NSMutableDictionary dictionary];

    [items setObject: options[@"appId"] forKey: @"com.facebook.sharedSticker.appID"];

        

    if(![options[@"backgroundVideo"] isEqual:[NSNull null]] && options[@"backgroundVideo"] != nil) {
        NSURL *backgroundVideoURL = [RCTConvert NSURL:options[@"backgroundVideo"]];
        NSData *video = [NSData dataWithContentsOfURL:backgroundVideoURL];
        [items setObject: video forKey: @"com.facebook.sharedSticker.backgroundVideo"];
    }


    // Putting dictionary of options inside an array
    NSArray *pasteboardItems = @[items];

    // Prepare options to facebook
    NSDictionary *pasteboardOptions = @{UIPasteboardOptionExpirationDate : [[NSDate date] dateByAddingTimeInterval:60 * 5]};

    // This call is iOS 10+, can use 'setItems' depending on what versions you support
    [[UIPasteboard generalPasteboard] setItems:pasteboardItems options:pasteboardOptions];
    [[UIApplication sharedApplication] openURL:urlScheme options:@{} completionHandler:nil];

    successCallback(@[]);
}

- (void)fallbackFacebook {
    // Cannot open facebook
    NSString *stringURL = @"https://itunes.apple.com/app/facebook/id284882215";
    NSURL *url = [NSURL URLWithString:stringURL];
    [[UIApplication sharedApplication] openURL:url];

    NSString *errorMessage = @"Not installed";
    NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedString(errorMessage, nil)};
    NSError *error = [NSError errorWithDomain:@"com.rnshare" code:1 userInfo:userInfo];

    NSLog(errorMessage);
}
@end
