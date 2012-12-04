//
//  stringLogger.h
//  fileServer
//
//  Created by antan on 12/1/12.
//  Copyright (c) 2012 antan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface stringLogger : NSObject
{
   //NSTextView * textView;
}
+(id) initWithTextView: (NSTextView *)tView;
-(void) scrollToBottom ;
-(void)logText: (NSString*)logStr  withTag : (int) tag;
-(void)warningLog:(NSString *)str;
-(void)networkingLog:(NSString *)str;
-(void)messageLog:(NSString *)str;
-(void)statusLog:(NSString *)str;
@property (assign) NSTextView *textView;




@end
