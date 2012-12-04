//
//  simpleMessage.h
//  fileServer
//
//  Created by antan on 12/3/12.
//  Copyright (c) 2012 antan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  GCDAsyncSocket;

@interface simpleMessage : NSObject

+(id) initWithStringMessage:(NSString *) msg owner: (NSString * ) owner;
-(NSData *)serialiseToData;
+(simpleMessage *)initFromData:(NSData *)data;

@property (assign) NSString * msg;
@property (assign) NSString * owner;

@end

//not completed

@interface simpleMessenger : NSObject
+(id) initWithSocket: (GCDAsyncSocket *)socket;

@end
