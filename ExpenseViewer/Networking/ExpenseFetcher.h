//
//  ExpenseFetcher.h
//  ExpenseViewer
//
//  Created by chada bhavani on 17/09/26.
//

#ifndef ExpenseFetcher_h
#define ExpenseFetcher_h
#import <Foundation/Foundation.h>
//NS_ASSUME_NONNULL_BEGIN
@interface ExpenseFetcher : NSObject
-(void)fetchExpenses:(void(^) (NSArray * _Nullable expenses,NSError * _Nullable error))completion;
@end
//NS_ASSUME_NONNULL_END
#endif /* ExpenseFetcher_h */

