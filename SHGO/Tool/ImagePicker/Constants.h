//
//  Constants.h
//  taiben_ipad
//
//  Created by lbf on 14-8-15.
//  Copyright (c) 2014年 xun-ao. All rights reserved.
//

#ifndef taiben_ipad_Constants_h
#define taiben_ipad_Constants_h

//正式发布需要修改的参数
#define IS_Debug 1
#define DBVersion 1
#define DBName @"taiben.sqlite"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IOS7 ((double)[[UIDevice currentDevice].systemVersion doubleValue]>=7.0f)
#define IS_IOS8 ((double)[[UIDevice currentDevice].systemVersion doubleValue]>=8.0f)
#define STATUS_BAR_HEIGHT ((IS_IOS7) ? 20 : 0)

#define VERTICAL_WIDTH 768
#define VERTICAL_HEIGHT (1024-(20-STATUS_BAR_HEIGHT))
#define HORIZON_WIDTH 1024
#define HORIZON_HEIGHT (768-(20-STATUS_BAR_HEIGHT))


#endif
