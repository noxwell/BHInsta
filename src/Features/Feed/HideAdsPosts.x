#import "../../InstagramHeaders.h"
#import "../../Manager.h"

static NSArray *removeAdsItemsInList(NSArray *list, BOOL isFeed) {
    NSMutableArray *orig = [list mutableCopy];
    [orig enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        // Remove suggested posts
        if (isFeed && [BHIManager removeSuggestedPost]) {
            if ([obj respondsToSelector:@selector(explorePostInFeed)] && [obj performSelector:@selector(explorePostInFeed)]) {
                NSLog(@"[BHInsta] Removing suggested posts");

                [orig removeObjectAtIndex:idx];
            }
        }

        if (([obj isKindOfClass:%c(IGFeedItem)] && ([obj isSponsored] || [obj isSponsoredApp])) || [obj isKindOfClass:%c(IGAdItem)]) {
            NSLog(@"[BHInsta] Removing ads");

            [orig removeObjectAtIndex:idx];
        }
    }];
    return [orig copy];
}

// Suggested posts
%hook IGMainFeedListAdapterDataSource
- (NSArray *)objectsForListAdapter:(id)arg1 {
    if ([BHIManager hideAds]) {
        return removeAdsItemsInList(%orig, YES);
    }
    return %orig;
}
%end
%hook IGContextualFeedViewController
- (NSArray *)objectsForListAdapter:(id)arg1 {
    if ([BHIManager hideAds]) {
        return removeAdsItemsInList(%orig, NO);
    }
    return %orig;
}
%end
%hook IGVideoFeedViewController
- (NSArray *)objectsForListAdapter:(id)arg1 {
    if ([BHIManager hideAds]) {
        return removeAdsItemsInList(%orig, NO);
    }
    return %orig;
}
%end
%hook IGChainingFeedViewController
- (NSArray *)objectsForListAdapter:(id)arg1 {
    if ([BHIManager hideAds]) {
        return removeAdsItemsInList(%orig, NO);
    }
    return %orig;
}
%end
%hook IGStoryAdPool
- (id)initWithUserSession:(id)arg1 {
    if ([BHIManager hideAds]) {
        NSLog(@"[BHInsta] Removing ads");

        return nil;
    }
    return %orig;
}
%end
%hook IGStoryAdsManager
- (id)initWithUserSession:(id)arg1 storyViewerLoggingContext:(id)arg2 storyFullscreenSectionLoggingContext:(id)arg3 viewController:(id)arg4 {
    if ([BHIManager hideAds]) {
        NSLog(@"[BHInsta] Removing ads");

        return nil;
    }
    return %orig;
}
%end
%hook IGStoryAdsFetcher
- (id)initWithUserSession:(id)arg1 delegate:(id)arg2 {
    if ([BHIManager hideAds]) {
        NSLog(@"[BHInsta] Removing ads");

        return nil;
    }
    return %orig;
}
%end
// IG 148.0
%hook IGStoryAdsResponseParser
- (id)parsedObjectFromResponse:(id)arg1 {
    if ([BHIManager hideAds]) {
        NSLog(@"[BHInsta] Removing ads");

        return nil;
    }
    return %orig;
}
- (id)initWithReelStore:(id)arg1 {
    if ([BHIManager hideAds]) {
        NSLog(@"[BHInsta] Removing ads");

        return nil;
    }
    return %orig;
}
%end
%hook IGStoryAdsOptInTextView
- (id)initWithBrandedContentStyledString:(id)arg1 sponsoredPostLabel:(id)arg2 {
    if ([BHIManager hideAds]) {
        NSLog(@"[BHInsta] Removing ads");

        return nil;
    }
    return %orig;
}
%end
%hook IGSundialAdsResponseParser
- (id)parsedObjectFromResponse:(id)arg1 {
    if ([BHIManager hideAds]) {
        NSLog(@"[BHInsta] Removing ads");

        return nil;
    }
    return %orig;
}
- (id)initWithMediaStore:(id)arg1 userStore:(id)arg2 {
    if ([BHIManager hideAds]) {
        NSLog(@"[BHInsta] Removing ads");
        
        return nil;
    }
    return %orig;
}
%end