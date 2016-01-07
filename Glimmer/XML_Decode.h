//
//  XMLAnalytical.h
//  Glimmer
//
//  Created by Mac_Tech on 15/11/5.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XML_Node.h"

@class XML_Node;

@interface XMLAnalysis : NSObject<NSXMLParserDelegate>
{
    @private
    XML_Node* root;
    XML_Node* currentParent;
    XML_Node* currentNode;
}

//解析数据，得到顶级节点 注意：这里必须以单节点作为父节点，不允许多个父节点
-(XML_Node*)parseXml:(NSData*)data;

@end
