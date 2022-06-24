//
//  Stack.h
//  CT
//
//  Created by Development on 24.06.2022.
//

#import "StackInterface.h"

/**
 *  Stack is an abstract data type, which is a list of elements organized according to the LIFO principle.
 *
 *  Adds a new element at the end of the stack.
 *  - (void)push:(id) element;
 *
 *  Removes and returns the last element of the stack.
 *  - (id)pop;
 *
 *  Returns the last element of the stack.
 *  - (id)peek;
 */
@interface Stack : NSObject <StackInterface>
@property (readonly) NSMutableArray *items;
- (id)init;
/**
 *  @param items : Populate stack with initial values
 */
- (id)initWithItems:(NSArray *) items;
@end

