//
//  fileMngr.h
//  charletlevels
//
//  Created by hsa1 on 30/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface fileMngr : NSObject 
{
	
}

+(void)saveDatapath:(NSString *)path contentarray:(NSMutableArray *)values;

+(NSMutableArray *)fetchDatafrompath:(NSString *)path;


@end
