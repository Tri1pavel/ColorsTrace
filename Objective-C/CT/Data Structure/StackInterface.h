//
//  StackInterface.h
//  CT
//
//  Created by Development on 24.06.2022.
//

#import <UIKit/UIKit.h>

@protocol StackInterface
- (void)push:(id) element;
- (id)pop;
- (id)peek;
@end

