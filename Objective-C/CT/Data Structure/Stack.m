//
//  Stack.m
//  CT
//
//  Created by Development on 24.06.2022.
//

#import "Stack.h"

@interface Stack ()
@property NSMutableArray *items;
@end

@implementation Stack

- (id)init {
    self = [super init];
    if (self) {
        self.items = [NSMutableArray array];
    }
    return self;
}

- (id)initWithItems:(NSArray *) items {
    self = [super init];
    if (self) {
        self.items = [items mutableCopy];
    }
    return self;
}

- (id)peek {
    return [self.items lastObject];
}

- (id)pop {
    id element = [self.items lastObject];
    [self.items removeLastObject];
    return element;
}

- (void)push:(id) view {
    [self.items addObject:view];
}

@end

