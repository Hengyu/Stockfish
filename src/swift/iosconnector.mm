#import "iosconnector.h"

#import "../../../include/CEngine.h"
#import "../../../include/CMove.h"
#import "../../../include/CPrincipalVariation.h"
#import "../../../include/CResult.h"
#import "../../../include/CSearchedMove.h"
#import "../../../include/CScore.h"

#import "../../../CEngine/CEngine_Private.h"
#import "../../../CEngine/CScore_Private.h"
#import "../../../CEngine/CMove_Private.h"
#import "../../../CEngine/CPrincipalVariation_Private.h"

#pragma mark - Principal Variation Callback

void principal_variation(const PrincipalVariationInfo* info) {
    if (!info) return;

    NSMutableArray<CMove *> *movesArray = [NSMutableArray arrayWithCapacity:info->moves.size()];
    for (const Move& move : info->moves) {
        [movesArray addObject:[[CMove alloc] initWithMove:move]];
    }

    CScore *score = [[CScore alloc] initWithBridge:&info->score];

    NSString *wdl = info->winDrawlose.empty()
    ? nil
    : [NSString stringWithUTF8String:info->winDrawlose.c_str()];

    CPrincipalVariation *pv = [[CPrincipalVariation alloc] initWithMoves:movesArray
                                                                   score:score
                                                                   depth:info->depth
                                                          selectiveDepth:info->selectiveDepth
                                                             winDrawLose:wdl
                                                                   nodes:info->nodes
                                                                    time:info->time];

    [[CEngine sharedEngine] sendPrincipalVariation:pv];
}

#pragma mark - Searched Move Callback

void searched_move(const Move& move, unsigned long moveNum, int depth) {
    CSearchedMove *searched = [[CSearchedMove alloc] initWithMove:move];
    searched.number = (NSUInteger)moveNum;
    searched.depth = (NSUInteger)depth;
    [[CEngine sharedEngine] sendSearchedMove:searched];
}

#pragma mark - Best Move Callback

void best_move(const Move& best, const Move& ponder) {
    if (best != Move::none()) {
        CMove *bestMove = [[CMove alloc] initWithMove:best];
        CMove *ponderMove = [[CMove alloc] initWithMove:ponder];
        CResult *result = [[CResult alloc] initWithBestMove:bestMove ponderMove:ponderMove];
        [[CEngine sharedEngine] sendResult:result];
    } else {
        [[CEngine sharedEngine] sendPositionIsMate];
    }
}

#pragma mark - Draw Detection Callback

void position_is_draw(void) {
    [[CEngine sharedEngine] sendPositionIsDraw];
}
