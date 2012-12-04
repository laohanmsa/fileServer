//
//  clientAppDelegate.h
//  fileClient
//
//  Created by antan on 11/29/12.
//  Copyright (c) 2012 antan. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class GCDAsyncSocket;
@interface clientAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *clientStatusField;
@property (weak) IBOutlet NSButton *connectButton;
@property (assign,readwrite,atomic) int connected;
@property (strong) GCDAsyncSocket *connectSocket;
@property (strong) NSMutableArray * transferSocketArray;

//property for msg and file
@property (weak ) IBOutlet NSButton * sendButton;
@property (weak ) IBOutlet NSButton * fileButton;
@property (weak ) IBOutlet NSTextField *msgField;

@property (strong) IBOutlet NSTextView *textLog;

- (IBAction)sendButtonClick:(NSButton *)sender;

- (IBAction)connectButtonClick:(id)sender;
@end
