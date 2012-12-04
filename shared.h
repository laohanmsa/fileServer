//
//  shared.h
//  fileServer
//
//  Created by antan on 11/27/12.
//  Copyright (c) 2012 antan. All rights reserved.
//
#ifndef SHARED
#define SHARED


// some networking var
#define ANT_FILE_READ_WRITE_CHUNK_SIZE  1024*4

// server client info
#define ANT_SERVER_ADDRESS @"127.0.0.1"
#define ANT_SERVER_PORT 8888
#define ANT_CLIENT_PORT 9999

// for client status


#define CLIENT_STATE_PENDING 0
#define CLIENT_STATE_CONNECTING 1
#define CLIENT_STATE_CONNECTED 2


// for server status
#define SERVER_PENDING 0
#define SERVER_LISTENING 1
#define SERVER_CONNECTED 2



// some string values
#define ANT_TEXT_STATUS_FOR_SERVER_LAUNCHED @"server is waiting for connection"
#define ANT_TEXT_STATUS_FOR_SERVER_DOWN @"server is not launched"


// basic msg string
#define ANT_MSG_HELLO @"hello"
#define ANT_MSG_HELLO_ACK @"hello_ack"


//log tag
#define LOG_TAG_WARNING 1
#define LOG_TAG_NETWORKING 2
#define LOG_TAG_MSG 3
#define LOG_TAG_DIAGNOSE 4


//message config

#define MSG_ENDDING @"&&&"
#define MSG_ENDDING_NSDATA [MSG_ENDDING dataUsingEncoding: NSUTF8StringEncoding]
#define MSG_ENDDING_LENGTH [MSG_ENDDING_NSDATA length]


//socket TAGs
#define TAG_SIMPLE_MESSAGE 1


//some tools

#define FORMAT(format, ...) [NSString stringWithFormat:(format), ##__VA_ARGS__]

#endif


