//
//  stringLogger.m
//  fileServer
//
//  Created by antan on 12/1/12.
//  Copyright (c) 2012 antan. All rights reserved.
//

#import "stringLogger.h"
#import "shared.h"

@implementation stringLogger

//should put some method in here as private : TODO




@synthesize textView = _textView;


+(id) initWithTextView:(NSTextView *)tView{
    stringLogger *obj  = [[self alloc] init];
    obj.textView = tView;
    return obj;
}

-(void) scrollToBottom  {

    NSScrollView *scrollView = [self.textView enclosingScrollView];
	NSPoint newScrollOrigin;
	
	if ([[scrollView documentView] isFlipped])
		newScrollOrigin = NSMakePoint(0.0F, NSMaxY([[scrollView documentView] frame]));
	else
		newScrollOrigin = NSMakePoint(0.0F, 0.0F);
	
	[[scrollView documentView] scrollPoint:newScrollOrigin];

}

-(void)logText: (NSString*)logStr  withTag : (int) tag{
    
    NSString *paragraph = [NSString stringWithFormat:@"%@\n", logStr];
    NSColor *textColor;
    NSString * leadingTag ;
    
	
    switch (tag) {
        case LOG_TAG_WARNING:
            textColor = [NSColor redColor];
            leadingTag   = @"[Warning]";
            
            break;
        case LOG_TAG_NETWORKING:
            textColor = [NSColor purpleColor];
            leadingTag   = @"[Networking]";
            break;
        case LOG_TAG_MSG :
            textColor = [NSColor blueColor];
            leadingTag   =@"[Message]";
            break;
            
        case LOG_TAG_DIAGNOSE:
            textColor = [NSColor brownColor];
            leadingTag   =@"[Diagnose]";
            break;
            
        default:
            
            textColor = [NSColor blackColor];
            leadingTag   = @"[Undefined]";
            break;
    }
    
    paragraph = [NSString stringWithFormat:@"%@___%@",leadingTag,paragraph];
    
	NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithCapacity:1];
	[attributes setObject:textColor forKey:NSForegroundColorAttributeName];
	
	NSAttributedString *as = [[NSAttributedString alloc] initWithString:paragraph attributes:attributes];
	
	[[self.textView textStorage] appendAttributedString:as];
	[self scrollToBottom];
    


}

-(void)warningLog:(NSString *)str{
    [self logText:str withTag:LOG_TAG_WARNING];
    
}

-(void)networkingLog:(NSString *)str{
    [self logText:str withTag:LOG_TAG_NETWORKING];
}

-(void)messageLog:(NSString *)str{
    [self logText:str withTag:LOG_TAG_MSG];
}

-(void)statusLog:(NSString *)str {
    [self logText:str withTag:LOG_TAG_DIAGNOSE];
}

@end
