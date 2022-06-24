//
//  StackInterface.h
//  CT
//
//  Created by Development on 24.06.2022.
//

#import <UIKit/UIKit.h>

@protocol StackInterface

@required
- (void)push:(id) element;
@required
- (id)pop;
@required
- (id)peek;

@end

