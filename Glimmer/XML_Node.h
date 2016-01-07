//
//  XMLNode.h
//  Glimmer
//
//  Created by Mac_Tech on 15/11/5.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XML_Decode.h"


@class XMLAnalysis;

@interface XML_Node : NSObject

//外界请不要修改
@property(copy,nonatomic,readonly)NSString* elementName;
@property(retain,nonatomic,readonly)NSDictionary* attributeDict;
@property(retain,nonatomic,readonly)NSMutableArray* childrens;
@property(copy,nonatomic)NSString* elementValue;
@property(retain,nonatomic)XML_Node* parent;

+(XML_Node*)make:(NSString*)file;

//建立初始化
-(instancetype)initWithName:(NSString*)name property:(NSDictionary*)property;
//根据楼层获取子节点
-(XML_Node*)getChildByIndex:(NSInteger)index;
//根据名称获取子节点
-(XML_Node*)getChildByName:(NSString*)name;
//获取属性值
-(NSString*)getDictValue:(NSString*)name;
//添加自节点
-(void)addChildNode:(XML_Node*)node;
//打印信息
-(void)toString;
@end
