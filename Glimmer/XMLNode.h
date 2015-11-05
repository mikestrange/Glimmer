//
//  XMLNode.h
//  Glimmer
//
//  Created by Mac_Tech on 15/11/5.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLNode : NSObject

//外界请不要修改
@property(copy,nonatomic,readonly)NSString* elementName;
@property(retain,nonatomic,readonly)NSDictionary* attributeDict;
@property(retain,nonatomic,readonly)NSMutableArray* childrens;
@property(copy,nonatomic)NSString* elementValue;
@property(retain,nonatomic)XMLNode* parent;

+(XMLNode*)make:(NSString*)file;

//建立初始化
-(instancetype)initWithName:(NSString*)name property:(NSDictionary*)property;
//根据楼层获取子节点
-(XMLNode*)getChildByIndex:(NSInteger)index;
//根据名称获取子节点
-(XMLNode*)getChildByName:(NSString*)name;
//获取属性值
-(NSString*)getDictValue:(NSString*)name;
//添加自节点
-(void)addChildNode:(XMLNode*)node;
//打印信息
-(void)toString;
@end
