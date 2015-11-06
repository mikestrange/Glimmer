//
//  ModuleDelivery.h
//  Glimmer
//
//  Created by Mac_Tech on 15/11/6.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBindVisitor.h"
#import "IDataTable.h"
#import "FacedEmployer.h"

@class FacedEmployer;

@interface ModuleDelivery : NSObject{
    @protected
    NSMutableArray* _bindMap;
    NSMutableDictionary* _dataMap;
}

@property(strong,readonly,nonatomic) FacedEmployer* faced;

@end
