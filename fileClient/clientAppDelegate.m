//
//  clientAppDelegate.m
//  fileClient
//
//  Created by antan on 11/29/12.
//  Copyright (c) 2012 antan. All rights reserved.
//

#import "clientAppDelegate.h"
#import "GCDAsyncSocket.h"
#import "shared.h"
#import  "stringLogger.h"
#import "simpleMessage.h"



@interface clientAppDelegate (ANT_private)<GCDAsyncSocketDelegate>

-(void) sendMessage : (simpleMessage *) msg;
-(void) onMessageCameIn: (simpleMessage *) msg;

@end


@implementation clientAppDelegate{
    stringLogger   * logger;
    int _connected;
}

@synthesize clientStatusField = _clientStatusField;
@synthesize connectButton = _connectButton;
@synthesize connectSocket = _connectSocket;
@synthesize transferSocketArray =_transferSocketArray;
//@synthesize connected = _connected;
@synthesize textLog = _textLog;

-(int) connected  {
    return _connected;
}

-(void) setConnected : (int)clientState{
    if (_connected == clientState){
        return;
    }
    _connected = clientState;
    switch (clientState) {
        case CLIENT_STATE_PENDING:
            [[self connectButton] setTitle:@"Connect"];
            [self.clientStatusField setStringValue:@"not connected.."];
            break;
        case CLIENT_STATE_CONNECTING:
            [self.clientStatusField setStringValue:@"connecting... , to quit CLICK Cancel"];
            [[self connectButton] setTitle:@"Cancel"];
            break;
            
        case CLIENT_STATE_CONNECTED:
            [self.clientStatusField setStringValue:@"connected"];
            [[self connectButton] setTitle:@"Disconnect"];
            break;
            
        default:
           // NSError *err = [NSError ini
            break;
    }
    return;
    
 
    
}

-(void) disconnectAll{
    
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    //setup logger
    logger = [stringLogger initWithTextView:self.textLog];
    
    [self setConnected:NO];
    self.connectSocket = nil;
    
    self.transferSocketArray   = [[NSMutableArray alloc] initWithCapacity:1];
}

-(void) prepareClientSocket{
    if (!self.connectSocket){
        self.connectSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    
    return;
    
}

-(void)beginConnect{
    NSError *err = nil;
    if (! [self.connectSocket connectToHost:ANT_SERVER_ADDRESS onPort:ANT_SERVER_PORT error:&err]){
        [logger warningLog:[NSString stringWithFormat:@"open connect soket error %@ ", &err]];
        
        [self setConnected:CLIENT_STATE_PENDING];
    }else{
        
        [logger statusLog:FORMAT(@"client is trying to connect to HOST: %@ at PORT : %d", ANT_SERVER_ADDRESS, ANT_SERVER_PORT)];
        
        [self setConnected:CLIENT_STATE_CONNECTING];
    }

}

-(void)disconnect{
    [self.connectSocket disconnect];
    

}
// ACtions linked to the XIB file


- (IBAction)sendButtonClick:(NSButton *)sender {
    
    if ([[self.msgField stringValue] isEqualToString:@""]){
        [logger warningLog:@"can not send a empty message!"];
    }else{
    
        //[logger messageLog:[self.msgField stringValue]];
        [self sendMessage:[simpleMessage initWithStringMessage:[self.msgField stringValue] owner:@"ant"]];
    }
}

- (IBAction)connectButtonClick:(id)sender {
  
    [self prepareClientSocket];
    switch (self.connected) {
        case CLIENT_STATE_PENDING:
            // to connect here
            [self beginConnect];
            
            break;
        case CLIENT_STATE_CONNECTING:
            [self disconnect];
            // to stop connect and back to pending here
            break;
        case CLIENT_STATE_CONNECTED:
            [self disconnect];
            // to disconnected here
            break;
            
        default:
            break;
    }
    
    
  
}





//some tool method

-(NSString *)getSocketInfoString: (GCDAsyncSocket*)sock{
    
    return FORMAT(@"LOCAL-- %@: port %hd, remote-- %@: port:%hd", [sock localHost], [sock localPort] , [sock connectedHost], [sock connectedPort]);
}





// GCDAsyncSocket delegate methods



- (void)socket:(GCDAsyncSocket *)sender didConnectToHost:(NSString *)host port:(UInt16)port
{
    
    NSString *logStr = FORMAT(@"connected to server at HOST : %@  at PORT : %hd", host , port);
    [logger networkingLog:logStr];
    
   // NSLog(@"Cool, I'm connected! That was easy.");
    [self setConnected: CLIENT_STATE_CONNECTED];
    
    
    //assert the connected socket is the same as self.connectSocker;
    
    assert(sender == self.connectSocket);
    
    // first message
    [self sendMessage:[simpleMessage initWithStringMessage:@"hello server" owner:@"ant"]];
    [sender readDataToData:MSG_ENDDING_NSDATA withTimeout:-1 tag:TAG_SIMPLE_MESSAGE];
    
    
}


- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)error {
    NSString *logStr = FORMAT(@"socket disconnected  LOCAL-- %@: port %hd, remote-- %@: port:%hd", [sock localHost], [sock localPort] , [sock connectedHost], [sock connectedPort]);
    [logger networkingLog:logStr];
    
    [self setConnected:CLIENT_STATE_PENDING];
   assert(sock == self.connectSocket);
    
    
   
    
}


-(void) socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    if (tag == TAG_SIMPLE_MESSAGE){
        [logger networkingLog:@"message send"];
    }
}

-(void) socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    if (tag == TAG_SIMPLE_MESSAGE){
        simpleMessage * sMsg = [simpleMessage initFromData:data];
        [self onMessageCameIn:sMsg];
        [sock readDataToData:MSG_ENDDING_NSDATA withTimeout:-1 tag:TAG_SIMPLE_MESSAGE];
        
    }
}

// message methods
-(void) sendMessage : (simpleMessage *)msg{
    if(self.connected != CLIENT_STATE_CONNECTED ){
        [logger warningLog:@" Client is not Connected!"];
    }
    NSData * msgData = [msg serialiseToData];
    [self.connectSocket writeData:msgData withTimeout:-1 tag:TAG_SIMPLE_MESSAGE];
    
}

-(void) onMessageCameIn:(simpleMessage *)simpleMsg{
    [logger messageLog:simpleMsg.msg];
}



@end
