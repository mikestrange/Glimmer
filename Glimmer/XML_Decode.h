//
//  XMLAnalytical.h
//  Glimmer
//
//  Created by Mac_Tech on 15/11/5.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLNode.h"

@interface XMLAnalysis : NSObject<NSXMLParserDelegate>
{
    @private
    XMLNode* root;
    XMLNode* currentParent;
    XMLNode* currentNode;
}

//解析数据，得到顶级节点 注意：这里必须以单节点作为父节点，不允许多个父节点
-(XMLNode*)parseXml:(NSData*)data;

@end
