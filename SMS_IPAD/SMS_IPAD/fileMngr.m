//
//  fileMngr.m
//  charletlevels
//
//  Created by hsa1 on 30/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "fileMngr.h"


@implementation fileMngr

+(void)saveDatapath:(NSString *)path contentarray:(NSMutableArray *)values
{
	NSMutableData *inData=[NSMutableData data];
	NSKeyedArchiver *encoder=[[NSKeyedArchiver alloc] initForWritingWithMutableData:inData];
	
	[encoder encodeObject:values];
	[encoder finishEncoding];
	
	[inData writeToFile:path atomically:YES];
	[encoder release];
	encoder=nil;
	
}

+(NSMutableArray *)fetchDatafrompath:(NSString *)path
{
	
	NSMutableData *outdata=[NSMutableData dataWithContentsOfFile:path];
	NSKeyedUnarchiver *decoder=[[NSKeyedUnarchiver alloc] initForReadingWithData:outdata];
	NSMutableArray *array=[decoder decodeObject];
	[decoder finishDecoding];
	[decoder release];
	decoder=nil;
	return array;
}

@end
