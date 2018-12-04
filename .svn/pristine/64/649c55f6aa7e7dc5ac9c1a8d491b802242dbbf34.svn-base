//
//  NNMineOperationModel.h
//  YWL
//
//  Created by 来旭磊 on 2018/5/10.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           矿机运行状态模型
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import <Foundation/Foundation.h>

//矿机节点 model
@interface NNMineOperationNodeModel : NSObject

/** 服务器名称 */
@property (nonatomic, copy) NSString *server;
/** 服务器ip */
@property (nonatomic, copy) NSString *server_ip;
/** 状态 0为运行中 1为已停止 */
@property (nonatomic, copy) NSString *status;
/** 内容 */
@property (nonatomic, copy) NSString *text;

@end


@interface NNMineOperationModel : NSObject

/** 0为运行中 1为已停止 */
@property (nonatomic, copy) NSString *status;
/** 运算力 */
@property (nonatomic, copy) NSString *power;
/** 产量 */
@property (nonatomic, copy) NSString *day_out;
/** 机型 */
@property (nonatomic, copy) NSString *ltc_name;
/** 已释放 */
@property (nonatomic, copy) NSString *on_coin;
/** 节点数组 */
@property (nonatomic, strong) NSArray <NNMineOperationNodeModel *>*serverinfo;

@end
