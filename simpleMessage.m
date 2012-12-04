//
//  simpleMessage.m
//  fileServer
//
//  Created by antan on 12/3/12.
//  Copyright (c) 2012 antan. All rights reserved.
//

#import "simpleMessage.h"
#import "shared.h"

@implementation simpleMessage

@synthesize msg=_msg;
@synthesize owner = _owner;





+(id) initWithStringMessage:(NSString *)msg owner:(NSString *)owner{
    simpleMessage * obj = [[self alloc] init];
    obj.msg = msg;
    obj.owner = owner;
    return  obj;
}

-(NSData *)serialiseToData{
    
    NSData * data = nil;
    //just append MSG_ENDDING to the message opject
    NSString *outString = [NSString stringWithFormat:@"%@%@",self.msg,MSG_ENDDING];
    data = [outString dataUsingEncoding:NSUTF8StringEncoding];
    
    return data;
}

+(simpleMessage *) initFromData:(NSData *)data{
  // NSInteger len = data.length;
   // NSRange range = NSMakeRange(0, 0);
   // range.location = 0;
   // range.length = len-MSG_ENDDING_LENGTH;
   // NSData * msgData =  [data subdataWithRange:range];
    
    
    
    NSString * stringMsg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSString  *str = [stringMsg stringByReplacingOccurrencesOfString:MSG_ENDDING withString:@""];
    
    // TODO : hard code here !!!!
    
    
  // stringMsg = [stringMsg substringWithRange:NSMakeRange(0, 5)];
    
    simpleMessage * msg = [simpleMessage initWithStringMessage:str  owner:@"ant"];
   
    return msg;
    
}


@end


//not completed
@implementation simpleMessenger

+(id) initWithSocket: (GCDAsyncSocket *)socket{
    return nil;
    
}

@end
