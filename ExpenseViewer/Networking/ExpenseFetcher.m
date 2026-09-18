//
//  ExpenseFetcher.m
//  ExpenseViewer
//
//  Created by chada bhavani on 17/09/26.
//

#import <Foundation/Foundation.h>
#import "ExpenseFetcher.h"
@implementation ExpenseFetcher
-(void)fetchExpenses:(void (^)(NSArray * _Nullable,NSError * _Nullable))completion {
    NSURL *url = [NSURL URLWithString:@"https://www.jsonkeeper.com/b/DYZJF"];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completion(nil,error);
            return;
            
        }
        NSError *jsonError;
        NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            completion(nil,jsonError);
            return;
        }
        completion(json,nil);
        
    }];
    [task resume];
}


@end
